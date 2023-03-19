//
//  DailyPictureScreen.swift
//  NASA Daily Pics
//
//  Created by APPLE on 19/03/23.
//

import SwiftUI

struct DailyPictureScreen: View {
    
    @StateObject var viewModel: DailyPictureDefaultViewModel = DailyPictureDefaultViewModel()
    
    var body: some View {
        
        ScrollView {
            
            Text(viewModel.state.title)
                .frame(maxWidth: .infinity, alignment: .center)
                .bold()
                .font(.title2)
                
            Spacer(minLength: 20)
            
            AsyncImage(url: viewModel.state.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            
            Spacer(minLength: 20)
            
            Text(viewModel.state.explination)
        }
        .padding()
    }
}

struct DailyPictureScreen_Previews: PreviewProvider {
    static var previews: some View {
        DailyPictureScreen()
    }
}
