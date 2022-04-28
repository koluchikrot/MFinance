//
//  ForecastDetail.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 27.04.2022.
//

import SwiftUI

struct ForecastDetail: View {
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                Text("Technical analysis")
                    .font(.title2)
                    .padding(.leading)
                Divider()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Price change")
                            .foregroundColor(.secondary)
                        Text("Up (80%)")
                    }
                    .padding([.leading])
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Last 5 predictions accuracy")
                            .foregroundColor(.secondary)
                        Text("77%")
                    }
                    .padding(.trailing)
                }
            }
            .padding([.top, .bottom])
            .background(Color.primary.colorInvert())
            .cornerRadius(15)
            .shadow(color: Color.primary.opacity(0.10), radius: 15.0, x: 0, y: 0.0)
        }
        .padding()
    }
}

struct ForecastDetail_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDetail()
    }
}
