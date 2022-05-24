//
//  UnderlineModifier.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 23.05.2022.
//

import SwiftUI

/// This modifier provides an animated underscore for the SegmentedControl.
struct UnderlineModifier: ViewModifier
{
    var selectedIndex: Int
    let frames: [CGRect]
    
    func body(content: Content) -> some View
    {
        content
            .background(
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: frames[selectedIndex].width, height: 2)
                    .offset(x: frames[selectedIndex].minX - frames[0].minX), alignment: .bottomLeading
            )
            .background(
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 1), alignment: .bottomLeading
            )
    }
}
