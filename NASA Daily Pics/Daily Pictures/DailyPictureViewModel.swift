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
        getPictureOfTheDay()
    }
}

private extension DailyPictureDefaultViewModel {
    
    func getPictureOfTheDay() {
        
        Task {
            do {
                let model = try await service.getPictureOfTheDay()
                DispatchQueue.main.async { [weak self] in
                    
                    guard let self else { return }
                    self.state.title = model.title
                    self.state.explination = model.explanation
                    self.state.imageUrl = URL(string: model.url)
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
}
