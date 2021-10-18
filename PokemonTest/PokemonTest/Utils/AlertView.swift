//
//  AlertView.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 17/10/21.
//

import SwiftUI

struct AlertView: View {
    
    @State var showsAlert = false
    
    internal var onOkTapped: (() -> Void)?
    
    internal var firstTitle: String = ""
    internal var secondTitle: String = ""
    
    var body: some View {
        
        ZStack {}.alert(isPresented: self.$showsAlert) {
            let primaryButton = Alert.Button.cancel(Text("Ok")) {
                if let okTapped = onOkTapped {
                    okTapped()
                }
            }
            
            return Alert(title: Text(firstTitle), message: Text(secondTitle), dismissButton: primaryButton)
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
