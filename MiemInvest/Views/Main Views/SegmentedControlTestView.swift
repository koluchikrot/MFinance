//
//  SegmentedControlTestView.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 23.05.2022.
//

import SwiftUI

struct SegmentedControlTestView: View {
    @State var selectedIndex: Int = 0
    
    var body: some View {
        SegmentedControl(selectedIndex: $selectedIndex, titles: ["One", "Two", "Three"])
    }
}

struct SegmentedControlTestView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlTestView()
    }
}
