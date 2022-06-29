//
//  ApiManager.swift
//  Spotify Clone
//
//  Created by HAMZA on 25/6/2022.
//

import Foundation

struct Constants {
    static let baseApiUrl = "https://api.spotify.com/v1"
}

enum ApiError: Error {
    case failedToGetData
}

final class ApiManager {
    static let shared = ApiManager()
    
    private init() { }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseApiUrl + "/me"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(ApiError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    print(result)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
                
            }
            task.resume()
        }
    }
    
    public func getNewReleases(completion: @escaping (Result<NewReleasesResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseApiUrl + "/browse/new-releases?limit=50"), type: .GET) {  request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(ApiError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            
            task.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping (Result<FeaturedPlaylistResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseApiUrl + "/browse/featured-playlists?limit=2"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(ApiError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
//    public func getRecommendations(completion: @escaping (Result<String, Error>) -> Void) {
//        createRequest(with: URL(string: Constants.baseApiUrl + "/recommendations"), type: .GET) { request in
//            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
//                guard let data = data, error == nil else {
//                    completion(.failure(ApiError.failedToGetData))
//                    return
//                }
//
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print("json: \(json)")
//                } catch {
//                    print(error.localizedDescription)
//                    completion(.failure(error))
//                }
//
//            }
//            task.resume()
//        }
//    }
    
    public func getRecommendedGenres(completion: @escaping (Result<String, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseApiUrl + "/recommendations/available-genre-seeds"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data, error == nil else {
                    completion(.failure(ApiError.failedToGetData))
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print("json: \(json)")
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?,type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiUrl = url else { return }
            
            var request = URLRequest(url: apiUrl)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
    
}
