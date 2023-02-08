//
//  NettokenDTO.swift
//  Nettoken
//
//  Created by Daniele Tassone on 07/02/2023.
//

import Foundation

struct NettokenModel {
    let groups: [GroupModel]
}

struct GroupModel: Hashable, Identifiable {
    let id = UUID()
    let idGroup: String
    let name: String
    let credentials: [CredentialModel]
}

struct CredentialModel: Hashable, Identifiable {
    let id = UUID()
    let idCredential: String
    let name: String
    let username: String
    let email: String
    let password: String
    let logo: String
}
