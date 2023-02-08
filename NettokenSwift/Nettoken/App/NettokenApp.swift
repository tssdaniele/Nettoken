//
//  NettokenApp.swift
//  Nettoken
//
//  Created by Daniele Tassone on 07/02/2023.
//

import SwiftUI

@main
struct NettokenApp: App {
    var body: some Scene {
        WindowGroup {
            NettokenListView(viewModel: NettokenVM())
        }
    }
}
