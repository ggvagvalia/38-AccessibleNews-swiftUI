//
//  MainPage.swift
//  38-AccessibleNews-swiftUI
//
//  Created by gvantsa gvagvalia on 6/17/24.
//

import SwiftUI

struct MainPage: View {
    @EnvironmentObject var newsViewModel: MainPageViewModel
    @State private var news: Articles?
    
    var body: some View {
        NavigationStack {
            VStack {
                
                TableViewCellRepresentable(viewModel: newsViewModel, didSelectRow: { article in
                    news = article
                })
                .frame(width: screenWidth / 1.1, height: screenHeight)
                .safeAreaPadding(.vertical)
            }
            .background(
                     NavigationLink(
                         destination: UIKitDetailsView(news: $news),
                         isActive: Binding<Bool>(
                             get: { news != nil },
                             set: { _ in news = nil }
                         ),
                         label: { EmptyView() }
                     )
                 )
             }
        .onAppear {
            newsViewModel.fetchData()
        }
    }
}


//#Preview {
//    ContentView()
//}
