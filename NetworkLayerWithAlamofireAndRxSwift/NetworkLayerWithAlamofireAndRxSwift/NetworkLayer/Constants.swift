//
//  Constants.swift
//  NetworkLayerWithAlamofireAndRxSwift
//
//  Created by Григорий Виняр on 31/08/2022.
//

import Foundation

struct Constants {
  
  // The API's base URL
  static let baseURL = "https://jsonplaceholder.typicode.com"
  
  // The parameters (Queries) that we're gonna use
  struct Parameters {
    static let userId = "userId"
  }
  
  // The header fields
  enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
  }
  
  // The content type (JSON)
  enum ContentType: String {
    case json = "application/json"
  }
}
