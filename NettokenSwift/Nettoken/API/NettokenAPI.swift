//
//  NettokenAPI.swift
//  Nettoken
//
//  Created by Daniele Tassone on 07/02/2023.
//

import Foundation
import Combine

protocol NettokenAPIFetchable {
    func fetchCredentialsList() -> AnyPublisher<NettokenDTO, APIError>
}

class NettokenAPI {
    let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension NettokenAPI: Fetchable {
    struct NettokenAPIComponent {
        static let scheme = "http"
        static let host = IPAddress
        static let port = 5000
        static let path = "/"
    }
    
    func urlComponentForCredentialsList() -> URLComponents {
        var components = URLComponents()
        components.scheme = NettokenAPIComponent.scheme
        components.host = NettokenAPIComponent.host
        components.port = NettokenAPIComponent.port
        components.path = NettokenAPIComponent.path
        return components
    }
}

extension NettokenAPI: NettokenAPIFetchable {
    func fetchCredentialsList() -> AnyPublisher<NettokenDTO, APIError> {
        return fetch(with: self.urlComponentForCredentialsList(), url: nil, session: self.session)
    }
}

extension NettokenAPI {
    static var IPAddress: String {
            var address: String = ""
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
            if getifaddrs(&ifaddr) == 0 {
                var ptr = ifaddr
                while ptr != nil {
                    defer { ptr = ptr?.pointee.ifa_next }
                    
                    let interface = ptr?.pointee
                    let addrFamily = interface?.ifa_addr.pointee.sa_family
                    if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                        let name = String(cString: (interface?.ifa_name)!)
                        if name == "en2" {
                            print(name)
                            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                            getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                            address = String(cString: hostname)
                            print(address)
                         }
                    }
                }
                freeifaddrs(ifaddr)
            }
             return address
        }
}
