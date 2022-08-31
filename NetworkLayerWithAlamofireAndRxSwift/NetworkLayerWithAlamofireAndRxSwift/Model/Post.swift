//
//  Post.swift
//  NetworkLayerWithAlamofireAndRxSwift
//
//  Created by Григорий Виняр on 31/08/2022.
//

import Foundation

struct Post: Codable {
  let id: Int
  let title: String
  let body: String
  let userId: Int
}
