//
//  ContentView.swift
//  ContactFetchApp
//
//  Created by Igor Malyarov on 29.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        VStack(spacing: 32) {
            
            Color.clear
                .overlay {
                    viewModel.duration.map {
                        Text($0.formatted())
                            .font(.largeTitle)
                    }
                }
            
            Picker("Select keys", selection: $viewModel.keys) {
                ForEach(ContactKeys.allCases, id: \.self) { key in
                    Text(key.rawValue)
                }
            }
            .pickerStyle(.wheel)
            
            Button("Fetch Contacts", action: viewModel.fetchContactsButtonTapped)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
