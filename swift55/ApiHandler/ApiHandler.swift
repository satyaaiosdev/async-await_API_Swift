//
//  ApiHandler.swift
//  swift55
//
//  Created by Satyaa Akana on 27/06/21.
//

import Foundation
enum ApiError: String, Error{
    case urlError = "url not found"
    case decodingError = "invalid format"
}

struct ApiHandler{
    static func getParse<T: Decodable>(url: String) async -> Result<T, ApiError>{
        guard let url = URL(string: url) else{
            return .failure(.urlError)
        }
        let session = URLSession.shared
        do{
            let response = try await session.data(from: url)
            let json = try JSONDecoder().decode(T.self, from: response.0)
            return .success(json)
        }catch{
            return .failure(.decodingError)
        }
    }
}

