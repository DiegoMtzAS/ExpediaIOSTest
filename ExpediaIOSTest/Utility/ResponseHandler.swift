//
//  ResponseHandler.swift
//  ExpediaIOSTest
//
//  Created by Diego Martinez on 09/11/23.
//



import Foundation

enum Result<T> {
    case success(_ response: T)
    case serverError(_ err: ErrorResponse)
    case networkError(_ err: String)
}



struct ErrorResponse: Codable {
    let code: Int?
    let message: String?
    
    
    enum CodingKeys: String, CodingKey {
        case message = "Message", code = "Code"
    }
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.code = try container?.decodeIfPresent(Int.self, forKey: .code)
        self.message = try container?.decodeIfPresent(String.self, forKey: .message)
    }
}

extension HTTPURLResponse {
    
    func isSuccessful() -> Bool {
        return statusCode >= 200 && statusCode <= 299
    }
}
