//
//  APIRouter.swift
//  NetworkLayerWithAlamofireAndRxSwift
//
//  Created by Григорий Виняр on 31/08/2022.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
  
  // The endpoint name we'll call later
  case getPosts(userId: Int)
  
  // MARK: - HTTPMethod
  // This returns the HTTPMethod type. It's used to determine the type if several endpoints are peresent
  private var method: HTTPMethod {
    switch self {
    case .getPosts:
      return .get
    }
  }
  
  // MARK: - Path
  // The path is the part following the base url
  private var path: String {
    switch self {
    case .getPosts:
      return "posts"
    }
  }
  
  // MARK: - Parameters
  // This is the queries part, it's optional because an endpoint can be without parameters
  private var parameters: Parameters? {
    switch self {
    case .getPosts(let userId):
      // A dictionary of key (From the constants file) and its value is returned
      return [Constants.Parameters.userId : userId]
    }
  }
  
  // MARK: - URLRequestConvertible
  func asURLRequest() throws -> URLRequest {
    
    let url = try Constants.baseURL.asURL()
    
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    // HTTPMethod
    urlRequest.httpMethod = method.rawValue
    
    // Common Headers
    urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HTTPHeaderField.acceptType.rawValue)
    urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HTTPHeaderField.contentType.rawValue)
    
    // Encoding
    let encoding: ParameterEncoding = {
      switch method {
      case .get:
        return URLEncoding.default
      default:
        return JSONEncoding.default
      }
    }()
    
    return try encoding.encode(urlRequest, with: parameters)
  }
}
