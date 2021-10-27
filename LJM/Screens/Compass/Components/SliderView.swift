////
////  SliderView.swift
////  LJM
////
////  Created by Laura Benetti on 24/02/21.
////
//
//import Foundation
//import SwiftUI
//import Sliders
//
//struct SliderView: View{
//    @State var sliderValue: CGFloat = 20.0
//    @State var test: String = ""
//    
//    var body: some View{
//
//        
//        ValueSlider(value: $sliderValue, in: 0...20, step: 1)
//            .valueSliderStyle(
//                HorizontalValueSliderStyle(
//                    track:
//                        
//                        Color.clear
//                        .clipShape(Capsule())
//                        .frame(height: 9.toScreenSize())
//                        .border(Color(red: 165/255, green: 165/255, blue: 165/255))
//                                //                        LinearGradient(
////                        gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]),
////                        startPoint: .leading,
////                        endPoint: .trailing
//                    //)
//                        
//                    .cornerRadius(4),
//                    thumb: Circle().fill(Color(red: 62/255, green: 161/255, blue: 155/255)),
//                    thumbSize: CGSize(width: 27.toScreenSize(), height: 27.toScreenSize())
//                )
//            )
//        
////        ValueSlider(value: $sliderValue, in: 0...20, step: 1)
////            .valueSliderStyle(
////                HorizontalRangeTrack(
////                                    view: Capsule().foregroundColor(.purple)
////                                )
////                    .frame(height: 16)
////                    .cornerRadius(4),
////                    thumbSize: CGSize(width: 48, height: 16)
////                )
////            )
//        
//        .frame(width: 265.toScreenSize(), height: 30.toScreenSize())    }
//}
//
//struct SliderView_Previews: PreviewProvider {
//    static var previews: some View {
//        SliderView()
//    }
//}
