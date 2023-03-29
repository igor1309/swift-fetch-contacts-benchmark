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
                .overlay { viewModel.result.map(resultView) }
            
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
    
    @ViewBuilder
    private func resultView(result: Result<TimeInterval, Error>) -> some View {
        
        switch result {
        case let .success(timeInterval):
             Text(timeInterval.formatted() + " sec")
                .font(.largeTitle)
            
        case let .failure(error):
            Text(error.localizedDescription)
                .foregroundColor(.red)
                .font(.title)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
