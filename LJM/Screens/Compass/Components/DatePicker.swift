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
        
        DatePicker(
            selection: $pickerDate,
            displayedComponents: .date,
            label: { EmptyView() }
        )
            .id(pickerDate)
            .padding(.horizontal, 20)
        //        .datePickerStyle(FieldDatePickerStyle())
            .frame(width: 80, height: 26)
        
    }
    
}



struct DatePicker_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(pickerDate: .constant(Date()))
    }
}

