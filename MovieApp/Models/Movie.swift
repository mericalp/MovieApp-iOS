//
//  Movie.swift
//  MovieApp
//
//  Created by Meric on 03.10.2022.
//

import Foundation

struct TrendingMovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let relase_date: String?
    let vote_average: Double
}

/*
 {
adult = 0;
"backdrop_path" = "/twybTlqm4v7JKjkxktZqmffGT8k.jpg";
"first_air_date" = "2022-09-16";
"genre_ids" =             (
 80,
 18
);
id = 128013;
"media_type" = tv;
name = Santo;
"origin_country" =             (
 ES
);
"original_language" = es;
"original_name" = Santo;
overview = "Two cops must learn to work together to catch the world's most-wanted drug dealer, whose face has never been revealed.";
popularity = "126.009";
"poster_path" = "/qIF53PuAJB0SE37IuPe77xCBuse.jpg";
"vote_average" = "7.571";
"vote_count" = 7;
}
 
 */




