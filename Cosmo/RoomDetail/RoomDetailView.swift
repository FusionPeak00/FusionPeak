//
//  RoomDetailView.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI

struct RoomDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 28, weight: .black))
                    }
                    
                    Spacer()
                    
                    Text("RESERVATIONS")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .black))
                }
                .padding(.horizontal)
                
                ScrollView {
                    
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    RoomDetailView()
}
