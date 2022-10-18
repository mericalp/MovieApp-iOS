//
//  APICaller.swift
//  MovieApp
//
//  Created by Meric on 03.10.2022.
//

import Foundation

struct ConstantsPath {
    static let API_KEY = "yourkey"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "yourkey"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedData
}

class APICaller {
    
    // MARK: -
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
        
        guard let url = URL(string: "\(ConstantsPath.baseURL)/3/trending/movie/day?api_key=\(ConstantsPath.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, err in
            guard let data = data, err == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        //
        task.resume()
    }
    
    // MARK: -
    func getTrendingTvs(completion: @escaping(Result<[Movie],Error>) -> Void) {
        
        guard let url = URL(string: "\(ConstantsPath.baseURL)/3/trending/tv/day?api_key=\(ConstantsPath.API_KEY)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, err in
            guard let data = data, err == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        //
        task.resume()
    }
    
    // MARK: -
    func getUpcomingMovies(completion: @escaping(Result<[Movie],Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsPath.baseURL)/3/movie/upcoming?api_key=\(ConstantsPath.API_KEY)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, err in
            guard let data = data, err == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        //
        task.resume()
    }
    
    // MARK: -
    func getPopular(completion: @escaping (Result<[Movie],Error>) -> Void) {
        
        guard let url = URL(string: "\(ConstantsPath.baseURL)/3/movie/popular?api_key=\(ConstantsPath.API_KEY)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, err in
            guard let data = data, err == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        //
        task.resume()
    }
    
    // MARK: -
    func getTopRated(completion: @escaping (Result<[Movie],Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsPath.baseURL)/3/movie/top_rated?api_key=\(ConstantsPath.API_KEY)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, err in
            guard let data = data, err == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        //
        task.resume()
    }
    
    // MARK: -
    func getDiscoverMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsPath.baseURL)/3/discover/movie?api_key=\(ConstantsPath.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, err in
            guard let data = data, err == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        //
        task.resume()
    }
    
    // MARK: -
    func getYoutubeVideos(with query: String, completion: @escaping (Result<VideoElement,Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(ConstantsPath.YoutubeBaseURL)q=\(query)&key=\(ConstantsPath.YoutubeAPI_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, err in
            guard let data = data, err == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
            }
        }
        //
        task.resume()
    }
    
    // MARK: -
    func searchQuery(with query: String, completion: @escaping (Result<[Movie],Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(ConstantsPath.baseURL)/3/search/movie?api_key=\(ConstantsPath.API_KEY)&query=\(query)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, err in
            guard let data = data, err == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        //
        task.resume()
    }
 
}


// https://api.themoviedb.org/3/discover/movie?api_key=<<api_key>>&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate

// https://api.themoviedb.org/3/movie/upcoming?api_key=<<api_key>>&language=en-US&page=1
