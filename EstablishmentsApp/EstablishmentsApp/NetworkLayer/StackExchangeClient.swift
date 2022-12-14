//
//  StackExchangeClient.swift
//  EstablishmentsApp
//
//  Created by Григорий Виняр on 28/08/2022.
//

import Foundation

protocol StackExchangeClientProtocol: AnyObject {
  func getEstablishments(with request: EstablishmentsRequest, completion: @escaping (Result<[EstablishModel] , DataResponseError>) -> Void)
  func getMenu(with request: MenuRequest, completion: @escaping (Result<[MenuModel], DataResponseError>) -> Void)
}

final class StackExchangeClient: StackExchangeClientProtocol {
  private lazy var baseURL: URL = {
    return URL(string: "http://94.127.67.113:8099/")!
  }()
  
  let session: URLSession
  
  init(session: URLSession = URLSession.shared) {
    self.session = session
  }
  
  func getMenu(with request: MenuRequest, completion: @escaping (Result<[MenuModel], DataResponseError>) -> Void) {
    
    let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
    
    session.dataTask(with: urlRequest) { data, response, error in
      guard
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.hasSuccessStatusCode,
        let data = data
      else {
        completion(Result.failure(DataResponseError.network))
        return
      }
      
      guard let decodedResponse = try? JSONDecoder().decode([MenuModel].self, from: data) else {
        completion(Result.failure(DataResponseError.decoding))
        return
      }
      
      completion(Result.success(decodedResponse))
    }.resume()
  }
  
  func getEstablishments(with request: EstablishmentsRequest, completion: @escaping (Result<[EstablishModel], DataResponseError>) -> Void) {
    
    let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
    
    session.dataTask(with: urlRequest) { data, response, error in
      guard
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.hasSuccessStatusCode,
        let data = data
      else {
        completion(Result.failure(DataResponseError.network))
        return
      }
      
      guard let decodedResponse = try? JSONDecoder().decode([EstablishModel].self, from: data) else {
        completion(Result.failure(DataResponseError.decoding))
        return
      }
      
      completion(Result.success(decodedResponse))
    }.resume()
  }
}
