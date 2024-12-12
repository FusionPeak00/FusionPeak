//
//  InitView.swift
//
//  Created by D K on 06.12.2024.
//

import SwiftUI

struct InitView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabMainView()
                    .environmentObject(viewModel)
            } else {
                LogInView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    InitView()
}
