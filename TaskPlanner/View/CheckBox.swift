//
//  CheckBox.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 02.02.2023.
//

import SwiftUI

struct CheckBox: View {
    @Binding var state: Bool
    
    var body: some View {
        //Button(action: { state.toggle() } )  {
            Image(systemName: state ? "checkmark.square" : "square")
        //}
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(state: .constant(true))
    }
}
