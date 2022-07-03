//
//  CircleImage.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

struct CircleImage: View {
    @ObservedObject var imageLoader: ImageLoader
    @State private var animate = false
    
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            } else {
                    Rectangle()
                        .fill(.gray)
            }
        }
        .cornerRadius(15)
    }

}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(imageLoader: ImageLoader (attachmentId: "100003"))
    }
}
