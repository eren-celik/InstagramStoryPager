//
//  MainView.swift
//  InstagramStory
//
//  Created by Eren  Çelik on 11.06.2021.
//

import SwiftUI

struct MainView : View {
    @ObservedObject private var viewModel = IGStoryViewModel()
    @State private var showStory : IGStoryModel?
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    gridView
                }
                .frame(height: 120)
                
                Spacer()
            }
            .navigationTitle("Instagram Story")
            .sheet(item: $showStory,onDismiss: {
                self.viewModel.orderedData()
            }) { IGStoryView(itemCount: $0.stories.count, selection: $0.id, storyData: $0) }

        }
    }
    
    private var gridView: some View {
        LazyVGrid(columns: [GridItem(.flexible(minimum: 200, maximum: 600))] ) {
            HStack {
                ForEach(viewModel.dummyData.indices) { index in
                    ProfileImageView(data: .constant(viewModel.dummyData[index]))
                        .onTapGesture {
                            viewModel.dummyData[index].seen = true
                            showStory = viewModel.dummyData[index]
                        }
                }
            }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


