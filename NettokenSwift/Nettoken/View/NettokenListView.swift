//
//  ContentView.swift
//  Nettoken
//
//  Created by Daniele Tassone on 07/02/2023.
//

import SwiftUI

struct NettokenListView<Model>: View where Model: NettokenViewModel {
    @StateObject private var viewModel: Model
    init (viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    @Environment(\.colorScheme)
    private var colorScheme
}

extension NettokenListView {
    var body: some View {
        NavigationView {
            List(viewModel.model.groups, id: \.self) { group in
                    Section(header: Text(group.name)) {
                        ForEach(group.credentials, id: \.self) { credential in
                                NavigationLink(destination: NettokenDetailView(model: credential)) {
                                    HStack {
                                        ImageView(url: URL(string: credential.logo))
                                        Text(credential.name)
                                            .bold()
                                    }
                                    .padding(3)
                            }
                        }
                    }
                }.listStyle(.inset)
                .navigationBarTitle("Nettoken")
                .alert(item: $viewModel.info, content: { info in
                    Alert(title: Text(info.title),
                          message: Text(info.message),
                          dismissButton: .cancel())
                }).padding()
            }
        }
}

struct NettokenListView_Previews: PreviewProvider {
    static var previews: some View {
        NettokenListView(viewModel: NettokenViewModelMock())
    }
}
