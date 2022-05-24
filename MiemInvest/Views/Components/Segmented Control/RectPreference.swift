//
//  RectPreference.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 23.05.2022.
//

import SwiftUI

struct RectPreferenceKey: PreferenceKey
{
    typealias Value = CGRect

    static var defaultValue = CGRect.zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect)
    {
        value = nextValue()
    }
}
