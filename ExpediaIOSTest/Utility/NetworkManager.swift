//
//  NetworkManager.swift
//  ExpediaIOSTest
//
//  Created by Diego Martinez on 09/11/23.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private let cs : CharacterSet = {
        var newCS = CharacterSet.urlQueryAllowed
        newCS.remove("+")
        return newCS
    }()
    
    enum HtttpMethod: String{
        case get = "GET"
    }
    

    func getURL(path: Endpoint) -> URL {
        let urlcomponents = URLComponents(string: path.absoluteURL)!
        print("query: \(urlcomponents.query ?? "")")
        return urlcomponents.url!
    }
    

    
    static func formRequest(url: URL, method: HtttpMethod, contentType: String = "application/json") -> URLRequest {
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.httpMethod = method.rawValue
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")

        return request
    }
    
    
    static func request<T: Decodable>(request: URLRequest, onResult: @escaping (Result<T>) -> Void) {
        doRequest(request: request, onResult: onResult)
    }
    
    
    static func doRequest<T: Decodable>(request: URLRequest, onResult: @escaping (Result<T>) -> Void) {
        print("do request \(request.url?.absoluteString ?? "")")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            if let error = error {
                print("response error: ", error)
                DispatchQueue.main.async { onResult(.networkError(error.localizedDescription)) }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async { onResult(.networkError("error_converting_response_to_http_response")) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    onResult(.serverError(ErrorResponse(code: httpResponse.statusCode, message: "error_nil_body")))
                }
                return
            }
            print("response code: \(httpResponse.statusCode)")
            if httpResponse.isSuccessful() {
                let responseBody: Result<T> = self.parseResponse(data: data)
                DispatchQueue.main.async { onResult(responseBody) }
            } else {
                let responseBody: Result<T> = self.parseError(data: data)
                DispatchQueue.main.async { onResult(responseBody) }
            }
        }
        task.resume()
    }
    
    static func parseResponse<T: Decodable>(data: Data) -> Result<T> {
        do {
            return .success(try JSONDecoder().decode(T.self, from: data))
        } catch {
            print("failed parsing successful response, parsing err: \(error)")
            return parseError(data: data)
        }
    }
    
    static func parseError<T>(data: Data) -> Result<T> {
        print("parsing error")
        do {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            return .serverError(errorResponse)
        } catch {
            return .serverError(ErrorResponse(code: 0, message: "error_parsing_error_response"))
        }
    }
}
