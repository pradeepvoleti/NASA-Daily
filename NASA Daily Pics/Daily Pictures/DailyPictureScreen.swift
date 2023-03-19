//
//  DailyPictureScreen.swift
//  NASA Daily Pics
//
//  Created by APPLE on 19/03/23.
//

import SwiftUI

struct DailyPictureScreen: View {
    
    @StateObject var viewModel = DailyPictureDefaultViewModel()
    
    var body: some View {
        
        VStack {
            
            if viewModel.state.showWarning {
                Text(viewModel.noInternetMessage)
                    .padding()
                    .background(Rectangle().fill(Color.red))
                    .foregroundColor(Color.white)
                    .bold()
                    .padding(-10)
            }
            
            ScrollView {
                
                Text(viewModel.state.title)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer(minLength: 20)
                
                if !viewModel.state.hideProgress {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                        .frame(height: viewModel.state.hideProgress ? 0 : 20)
                }
                if let imageData = viewModel.state.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                Spacer(minLength: 20)
                
                Text(viewModel.state.explination)
                    .font(.footnote)
            }
            .padding()
        }
    }
}

struct DailyPictureScreen_Previews: PreviewProvider {
    static var previews: some View {
        DailyPictureScreen()
    }
}
