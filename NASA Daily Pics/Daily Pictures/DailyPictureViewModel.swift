//
//  DailyPictureViewModel.swift
//  NASA Daily Pics
//
//  Created by APPLE on 19/03/23.
//

import Foundation

final class DailyPictureDefaultViewModel: ObservableObject {
    
    @Published var state: DailyPictureState
    
    private var service: PlanetaryService.Type
    
    var noInternetMessage = "We are not connected to the internet, showing you the last image we have."

    init(service: PlanetaryService.Type = PlanetaryDefaultService.self) {
        
        self.service = service
        state = DailyPictureState()
        fetchDetails()
    }
}

private extension DailyPictureDefaultViewModel {
    
    func fetchDetails() {
        
        Task {
            do {
                let isInternetAvailable = try await NetworkCheck.isInternetAvailable()
                
                if isInternetAvailable {
                    try await getFromAPI()
                } else {
                    self.getFromLocalData()
                }
            } catch(let error) {
                
                switch error {
                case let networkError as NetworkError:
                    print(networkError)
                default:
                    print(error)
                }
            }
        }
    }
    
    func getFromAPI() async throws {
        
        try await getPictureDetails()
        try await getImage()
    }
    
    func getFromLocalData() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.state.title = UserDefaults.standard.value(forKey: "DailyPicture_Title") as! String
            self.state.explination = UserDefaults.standard.value(forKey: "DailyPicture_Detail") as! String
            let lastSaved = UserDefaults.standard.value(forKey: "DailyPicture_Date") as! String
            self.state.showWarning = !DateUtility.lastSavedToday(dateString: lastSaved)
            self.state.imageData = FileHelper.getImage()
            self.state.hideProgress = true
        }
    }
}

private extension DailyPictureDefaultViewModel {
    
    func getPictureDetails() async throws {
        
        let model = try await service.getPictureOfTheDay()
        
        await MainActor.run { [weak self] in
            self?.setToUserDefaults(model: model)
        }
    }
    
    func setToUserDefaults(model: DailyPicture) {
        state.title = model.title
        state.explination = model.explanation
        state.imageUrl = model.url
        UserDefaults.standard.set(model.title, forKey: "DailyPicture_Title")
        UserDefaults.standard.set(model.explanation, forKey: "DailyPicture_Detail")
        UserDefaults.standard.set(model.date, forKey: "DailyPicture_Date")
    }
}

private extension DailyPictureDefaultViewModel {
    
    func getImage() async throws {

        let imageData = try await service.getImage(urlString: state.imageUrl)
        
        DispatchQueue.main.async { [weak self] in
            self?.saveImage(data: imageData)
        }
    }
    
    func saveImage(data: Data) {
        state.imageData = data
        state.hideProgress = true
        FileHelper.save(image: data)
    }
}
