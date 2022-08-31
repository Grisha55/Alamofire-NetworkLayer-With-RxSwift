//
//  APIClient.swift
//  NetworkLayerWithAlamofireAndRxSwift
//
//  Created by Григорий Виняр on 31/08/2022.
//

import Foundation
import Alamofire
import RxSwift

class ApiClient {
  
  static func getPosts(userId: Int) -> Observable<[Post]> {
    return request(APIRouter.getPosts(userId: userId))
  }
  
  //MARK: - The request function to get results in an Observable
  private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
    //Create an RxSwift observable, which will be the one to call the request when subscribed to
    return Observable<T>.create { observer in
      //Trigger the HttpRequest using AlamoFire (AF)
      let request = AF.request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
        //Check the result from Alamofire's response and check if it's a success or a failure
        switch response.result {
        case .success(let value):
          //Everything is fine, return the value in onNext
          observer.onNext(value)
          observer.onCompleted()
        case .failure(let error):
          //Something went wrong, switch on the status code and return the error
          switch response.response?.statusCode {
          case 403:
            observer.onError(APIError.forbidden)
          case 404:
            observer.onError(APIError.notFound)
          case 409:
            observer.onError(APIError.conflict)
          case 500:
            observer.onError(APIError.internalServerError)
          default:
            observer.onError(error)
          }
        }
      }
      
      //Finally, we return a disposable to stop the request
      return Disposables.create {
        request.cancel()
      }
    }
  }
}
