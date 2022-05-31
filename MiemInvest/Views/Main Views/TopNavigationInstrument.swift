//
//  TopNavigationInstrument.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 23.05.2022.
//

import SwiftUI

struct TopNavigationInstrument: View {
    @EnvironmentObject var modelData: ModelData
    @ObservedObject var infoModel: InstrumentInfoViewModel
    
    let screenWidth = screenSize.width
    let navBarColor = Color.blue.opacity(0.3)
    
    @State var selectedIndex: Int = 0
    
    var body: some View {
        if infoModel.instrumentInfo != nil {
            
        ZStack {
            // content
            Group {
                VStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: screenWidth, height: 40)
                    switch selectedIndex {
                    case 0:
                        InstrumentForecasts(infoModel: infoModel)
                    case 1:
                        InstrumentInfoView(infoModel: infoModel)
                    case 2:
                        InstrumentNews(newsModel: NewsViewModel(index: 6, text: infoModel.instrumentInfo!.id))
                    default:
                        InstrumentIndex()
                    }
                }
            }
            .navigationTitle(infoModel.instrumentInfo!.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: FavoriteButton(isSet: infoModel.instrumentInfo!.isFavorite, instrumentId: infoModel.instrumentInfo!.id).environmentObject(modelData))
            .background(NavigationConfigurator { nc in
                            nc.navigationBar.barTintColor = UIColor(navBarColor)
                        })
            
            // navigation tab
            Group {
                ZStack {
                    VStack {
                        Rectangle()
                            .fill(navBarColor)
                            .frame(width: screenWidth, height: 138)
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(.all)
                    VStack {
                        ZStack {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: screenWidth, height: 50)
                            SegmentedControl(selectedIndex: $selectedIndex, titles: ["Прогноз", "Инфо", "Новости"])
                        }
                        Spacer()
                    }
                }
            }
        }
        }
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}

//struct TopNavigationInstrument_Previews: PreviewProvider {
//    static var previews: some View {
//        TopNavigationInstrument()
//    }
//}
