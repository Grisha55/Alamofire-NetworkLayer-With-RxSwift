//
//  ViewController.swift
//  NetworkLayerWithAlamofireAndRxSwift
//
//  Created by Григорий Виняр on 31/08/2022.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .yellow
    
    getPosts()
  }

  private func getPosts() {
    APIClient.getPosts(userId: 1)
      .observe(on: MainScheduler.instance)
      .subscribe { postsList in
        print("List of posts:", postsList)
      } onError: { error in
        switch error {
        case APIError.conflict:
          print("Conflict error")
        case APIError.forbidden:
          print("Forbidden error")
        case APIError.notFound:
          print("Not found error")
        default:
          print("Unknown error:", error)
        }
      }
      .disposed(by: disposeBag)

  }

}

