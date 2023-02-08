//
//  NettokenDTO.swift
//  Nettoken
//
//  Created by Daniele Tassone on 07/02/2023.
//

import Foundation

// MARK: - NettokenDTO (Data Transfer Object)
struct NettokenDTO: Codable {
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let profile: Profile

    enum CodingKeys: String, CodingKey {
        case profile
    }
}

// MARK: - Profile
struct Profile: Codable {
    let id: String
    let phone: String
    let appID: String
    let verified: Bool
    let active: Bool
    let groups: [Group]

    enum CodingKeys: String, CodingKey {
        case id
        case phone
        case appID = "appId"
        case verified
        case active
        case groups
    }
    
    func toModel() -> NettokenModel {
        return .init(groups: groups.map { $0.toModel() })
    }
}

// MARK: - Group
struct Group: Codable {
    let id: String
    let source: String
    let name: String
    let credentials: [Credential]

    enum CodingKeys: String, CodingKey {
        case id
        case source
        case name
        case credentials
    }
    
    func toModel() -> GroupModel {
        return .init(idGroup: id,
                     name: name,
                     credentials: credentials.map { $0.toModel() })
    }
}

// MARK: - Credential
struct Credential: Codable {
    let id: String
    let note: String
    let groupID: String
    let name: String
    let username: String
    let email: String
    let password: String
    let logo: String
    let dashboardSpaceID: String?
    let phone: String?
    let publicKey: String?
    let secretKey: String?
    let shared: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case note
        case groupID = "groupId"
        case name
        case username
        case email
        case password
        case logo
        case dashboardSpaceID
        case phone
        case publicKey
        case secretKey
        case shared
    }
    
    func toModel() -> CredentialModel {
        return .init(idCredential: id,
                     name: name,
                     username: username,
                     email: email,
                     password: password,
                     logo: logo)
    }
}
