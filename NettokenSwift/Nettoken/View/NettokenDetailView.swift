//
//  NettokenDetailView.swift
//  Nettoken
//
//  Created by Daniele Tassone on 07/02/2023.
//

import Foundation
import SwiftUI

struct NettokenDetailView: View {
    @State private var showPassword = false
    let model: CredentialModel
    init (model: CredentialModel) {
        self.model = model
    }
}

extension NettokenDetailView {
    var body: some View {
        VStack(alignment: .center){
            HStack {
                ImageView(url: URL(string: model.logo), width: 100, height: 70, clipShapeType: .rounded).padding()
                VStack {
                    Toggle(isOn: $showPassword) {
                        Text("Show Password")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }.padding(35)
                }
            }
            List {
                Text("\(model.name)")
                Text("\(model.email)")
                Text("\(model.username)")
                if showPassword {
                    Text(model.password)
                }
            }.listStyle(.plain)
        }
    }
}

struct NettokenDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NettokenDetailView(model: NettokenViewModelMock().model.groups.first!.credentials.first!)
    }
}
