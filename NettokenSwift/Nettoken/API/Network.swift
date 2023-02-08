//
//  Network.swift
//  Nettoken
//
//  Created by Daniele Tassone on 07/02/2023.
//

import Foundation
import Combine

protocol Fetchable {
    func fetch<T>(with urlComponent: URLComponents?, url: URL?, session: URLSession) -> AnyPublisher<T,APIError> where T: Decodable
}

protocol Downloadable {
    func downloadData(with urlComponent: URLComponents?, url: URL?, session: URLSession) -> AnyPublisher<Data,APIError>
}

extension Downloadable {
    func downloadData(with urlComponent: URLComponents? = nil, url: URL?, session: URLSession) -> AnyPublisher<Data,APIError> {
        if let url = url {
            return apiCall(url: url, session: session)
        }
        guard let urlComponent = urlComponent, let url = urlComponent.url else {
            return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
        }
        return apiCall(url: url, session: session)
    }
    
    func apiCall(url: URL, session: URLSession) -> AnyPublisher<Data,APIError> {
        session.dataTaskPublisher(for: URLRequest(url: url))
            .tryMap { response -> Data in
                guard
                    let httpURLResponse = response.response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200
                else {
                    throw APIError.status(message: "Invalid Status Code")
                }
                
                return response.data
            }
            .mapError { APIError.map($0) }
            .eraseToAnyPublisher()
    }
}

extension Fetchable {
    func fetch<T>(with urlComponent: URLComponents? = nil, url: URL?, session: URLSession) -> AnyPublisher<T,APIError> where T: Decodable {
        if let url = url {
            return apiCall(url: url, session: session)
        }
        guard let urlComponent = urlComponent, let url = urlComponent.url else {
            return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
        }
        return apiCall(url: url, session: session)
    }
    
    func apiCall<T>(url: URL, session: URLSession) -> AnyPublisher<T,APIError> where T: Decodable {
        session.dataTaskPublisher(for: URLRequest(url: url))
         .mapError { error in
            APIError.network(message: error.localizedDescription)
         }
         .flatMap(maxPublishers: .max(1)) { pair in
           decode(pair.data)
         }
         .eraseToAnyPublisher()
    }
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
  let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
    .parsing(message: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}

enum APIError: Identifiable, LocalizedError {
    var id: String { localizedDescription }
    case request(message: String)
    case network(message: String)
    case status(message: String)
    case parsing(message: String)
    case other(message: String)
    
    static func map(_ error: Error) -> APIError {
        return (error as? APIError) ?? .other(message: error.localizedDescription)
    }
}
