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
        
        ScrollView {
            
            Text(viewModel.state.title)
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                
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
                .font(.footnote)
        }
        .padding()
    }
}

struct DailyPictureScreen_Previews: PreviewProvider {
    static var previews: some View {
        DailyPictureScreen()
    }
}
