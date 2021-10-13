//
//  BackgroundImageReadingStudent.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

func BackgroundImageReadingStudent() -> some View {
    return Image("EmptyState")
        .resizable()
        .aspectRatio(contentMode: .fill)
}

func BackgroundImageLogin() -> some View {
    return Image("Login")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: 1500, maxHeight: 900, alignment: .center)
}
