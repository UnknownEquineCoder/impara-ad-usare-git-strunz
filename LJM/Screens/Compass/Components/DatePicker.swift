//
//  DatePicker.swift
//  LJM
//
//  Created by Laura Benetti on 24/02/21.
//

import Foundation
import SwiftUI

struct DatePickerView: View{
    @Environment(\.colorScheme) var colorScheme
    @Binding var pickerDate : Date
    
    
    var body: some View {
        
//        CustomDatePicker(date: $pickerDate)
        
        DatePicker(
            selection: $pickerDate,
            displayedComponents: .date,
            label: { EmptyView() }
        )
            .padding(.horizontal, 20)
            .datePickerStyle(FieldDatePickerStyle())
            .frame(width: 80)
            .environment(\.locale, Locale(identifier: "en"))
            .cursor(.pointingHand)
        }
    
}



struct DatePicker_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(pickerDate: .constant(Date()))
    }
}


//struct CustomDatePicker: View {
//  @Binding var date: Date
//
//  @State private var showPicker: Bool = true
//  @State private var selectedDateText: String = "Date"
//
//  private var selectedDate: Binding<Date> {
//    Binding<Date>(get: { self.date}, set : {
//        self.date = $0
//        self.setDateString()
//    })
//  } // This private var I found… somewhere. I wish I could remember where
//
//  // To take the selected date and store it as a string for the text field
//  private func setDateString() {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "dd MMM, yyyy"
//
//    self.selectedDateText = formatter.string(from: self.date)
//  }
//
//  var body: some View {
//    VStack {
//        VStack {
//
//            TextField("", text: $selectedDateText)
//                .onAppear() {
//                    self.setDateString()
//                }
//                .onTapGesture {
//                    self.showPicker.toggle()
//                }
//            .multilineTextAlignment(.trailing)
//        }
//
//        if showPicker {
//            DatePicker("", selection: selectedDate,
//            displayedComponents: .date)
//            .datePickerStyle(FieldDatePickerStyle())
//            .labelsHidden()
//        }
//    }
//  }
//}
