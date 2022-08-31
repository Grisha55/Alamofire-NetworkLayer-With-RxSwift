//
//  APIError.swift
//  NetworkLayerWithAlamofireAndRxSwift
//
//  Created by Григорий Виняр on 31/08/2022.
//

import Foundation

enum APIError: Error {
  case forbidden           // Status code 403
  case notFound            // Status code 404
  case conflict            // Status code 409
  case internalServerError // Status code 500
}
