//
//  AddImageButton.swift
//  LJM
//
//  Created by Laura Benetti on 28/11/20.
//

import Foundation
import SwiftUI
import Combine


struct AddButton: View {
    var buttonSize: CGFloat
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var didTap: Bool = false
    @State private var counter: Int = 5 {
        didSet {
            print(counter)
            if counter <= 0 {
                didTap = false
                print("Tieni le corna")
            }
        }
    }
    
    var body: some View {
        VStack{
            
            if didTap {
                CountDownWrapper<AddLabelView>()
            }
            
        Button(action: {
            self.didTap = true
        }){
            ZStack{
                if didTap == false{
                Image(systemName: "plus.circle")
                    .resizable()
                    .foregroundColor(Color("customCyan"))
                }else{
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color("customCyan"))
                    
                }
            }

        }
        .frame(width: buttonSize.toScreenSize(), height: buttonSize.toScreenSize(), alignment: .center)
        .buttonStyle(PlainButtonStyle())
        
            if didTap {
                CountDownWrapper<UndoView>()
            }
        }
        
        
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(buttonSize: 100)
    }
}

struct AddLabelView: Vanishable {
    @ObservedObject var counter: Counter
    
    var body: some View{
        Text("Added to My Journey!")
        .foregroundColor(Color("customCyan"))
        
    }
    
}

struct UndoView: Vanishable {
    @ObservedObject var counter: Counter
    
    var body: some View {
        HStack {
            Text("\(counter.value)")
                .foregroundColor(Color("customCyan"))
                .frame(width: 16, height: 16)
                .overlay(Circle().stroke().foregroundColor(Color.gray))
            Button{
                print()
            }label:{
                Text("Undo")
                    .foregroundColor(.red)
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

