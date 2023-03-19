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

    init(service: PlanetaryService.Type = PlanetaryDefaultService.self) {
        
        self.service = service
        
        state = DailyPictureState()
        
        NetworkCheck.isInternetAvailable { [weak self] isInternetAvailable in
            
            guard let self else { return }
            
            if isInternetAvailable {
                self.fetchDetails()
            } else {
                print("Hello")
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.state.title = UserDefaults.standard.value(forKey: "DailyPicture_Title") as! String
                    self.state.explination = UserDefaults.standard.value(forKey: "DailyPicture_Detail") as! String
                    self.state.imageData = FileHelper.getImage()
                }
            }
        }
    }
}

private extension DailyPictureDefaultViewModel {
    
    func fetchDetails() {

        Task {
            do {
                try await getPictureDetails()
                try await getImage()
                
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
    
    func getPictureDetails() async throws {
        
        let model = try await service.getPictureOfTheDay()

        await MainActor.run { [weak self] in
            self?.setToUserDefaults(model: model)
        }
    }
    
    func getImage() async throws {

        let imageData = try await service.getImage(urlString: state.imageUrl)
        
        DispatchQueue.main.async { [weak self] in
            self?.saveImage(data: imageData)
        }
    }
    
    func setToUserDefaults(model: DailyPicture) {
        state.title = model.title
        state.explination = model.explanation
        state.imageUrl = model.url
        UserDefaults.standard.set(model.title, forKey: "DailyPicture_Title")
        UserDefaults.standard.set(model.explanation, forKey: "DailyPicture_Detail")
    }
    
    func saveImage(data: Data) {
        state.imageData = data
        FileHelper.save(image: data)
    }
}
