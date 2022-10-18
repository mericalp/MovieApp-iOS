//
//  YoutubeSearchResponse.swift
//  MovieApp
//
//  Created by Meric on 03.10.2022.
//

import Foundation


struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

// MARK: Video Identifier
struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}


/*
 {
     etag = "GUuAcbHc9Yl3YhPFJet-4ps6EZ0";
     items =     (
                 {
             etag = "09YTY3U_a09sR7aIKQpXJC5SuPs";
             id =             {
                 kind = "youtube#video";
                 videoId = tqDbYqPn7Ho;
             };
             kind = "youtube#searchResult";
         },
                 {
             etag = iujzcT8KH73VYXexzFbnbBq9Xzg;
             id =             {
                 kind = "youtube#video";
                 videoId = "cA5LyE6l-KQ";
             };
             kind = "youtube#searchResult";
         },
                 {
             etag = "X6KiWqywAxl_ajfvwUgP4nG-JrM";
             id =             {
                 kind = "youtube#video";
                 videoId = 5Np9Dw7lOSw;
             };
             kind = "youtube#searchResult";
         },
                 {
             etag = IHEY90rY3dcNKJzml4hB4wmy1ao;
             id =             {
                 kind = "youtube#playlist";
                 playlistId = "PLbRPa1HTLmvs27SDAp1zSMXcnQaeXog-x";
             };
             kind = "youtube#searchResult";
         },
                 {
             etag = "lk8409-m28s-u0WqMRhDC0vgfsE";
             id =             {
                 kind = "youtube#video";
                 videoId = 0Dj2kq5Neus;
             };
             kind = "youtube#searchResult";
         }
     );
     kind = "youtube#searchListResponse";
     nextPageToken = CAUQAA;
     pageInfo =     {
         resultsPerPage = 5;
         totalResults = 1000000;
     };
     regionCode = TR;
 }
*/
