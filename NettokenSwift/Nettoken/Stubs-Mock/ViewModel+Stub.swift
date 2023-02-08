//
//  Stub-Mock.swift
//  Nettoken
//
//  Created by Daniele Tassone on 07/02/2023.
//

import Foundation

class NettokenViewModelMock: NettokenViewModel {
    @Published var model: NettokenModel
    @Published var info: AlertInfo?
    @Published var ipv4: String?
    required init() {
        model = NettokenModel(groups: GroupModel.stubs)
        ipv4 = getIpAddress()
    }
    
    func getIpAddress() -> String? {
            var address : String?
            
            // Get list of all interfaces on the local machine:
            var ifaddr : UnsafeMutablePointer<ifaddrs>?
            guard getifaddrs(&ifaddr) == 0 else { return nil }
            guard let firstAddr = ifaddr else { return nil }
            
            // For each interface ...
            for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
                let interface = ifptr.pointee
                
                // Check for IPv4 or IPv6 interface:
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    // Check interface name:
                    let name = String(cString: interface.ifa_name)
                    if  name == "en0" {
                        // Convert interface address to a human readable string:
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    } else if (name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3") {
                        // Convert interface address to a human readable string:
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(1), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
            
            return address
        }
}
    
// MARK: - All Groups
extension GroupModel {
    
    static let stubs: [Self] = [
        .stub1,
        .stub2,
        .stub3
    ]
    
}

// MARK: - All Credentials
extension CredentialModel {
    
    static let stubs: [Self] = [
        .stub1,
        .stub2,
        .stub3,
        .stub4
    ]
    
}

extension GroupModel {
    
    static let stub1: Self = .init(
        idGroup: "1",
        name: "testGroup1",
        credentials: CredentialModel.stubs
    )
    
    static let stub2: Self = .init(
        idGroup: "2",
        name: "testGroup2",
        credentials: CredentialModel.stubs
    )
    
    static let stub3: Self = .init(
        idGroup: "3",
        name: "testGroup3",
        credentials: CredentialModel.stubs
    )
}

extension CredentialModel {
    static let stub1: Self = .init(
        idCredential: "1",
        name: "Fitbit",
        username: "testUsername",
        email: "testEmail",
        password: "testPassword",
        logo: "https://logo.clearbit.com/fitbit.com"
    )
    
    static let stub2: Self = .init(
        idCredential: "2",
        name: "Airbnb",
        username: "testUsername",
        email: "testEmail",
        password: "testPassword",
        logo: "https://logo.clearbit.com/airbnb.com"
    )
    
    static let stub3: Self = .init(
        idCredential: "3",
        name: "Amazon",
        username: "testUsername",
        email: "testEmail",
        password: "testPassword",
        logo: "https://logo.clearbit.com/amazon.com"
    )
    
    static let stub4: Self = .init(
        idCredential: "4",
        name: "Booking",
        username: "testUsername",
        email: "testEmail",
        password: "testPassword",
        logo: "https://logo.clearbit.com/booking.com"
    )
}
