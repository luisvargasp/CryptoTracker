//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by FerVP on 18/04/25.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}
#Preview {
    XMarkButton()
}
