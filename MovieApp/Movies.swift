//
//  Movies.swift
//  MovieApp
//
//  Created by Jimmy on 5/7/2021.
//

import Foundation

struct Movies: Codable {
    let id: Int64
    let uuid: String
    let name: String
    let chiName: String
    let dbTrailerUrl: String?
    let thumbnail: String?
    let openDate: String?
    let synopsis: String?
    let chiSynopsis: String?
    let interestingness: Int64?
    let commentCount: Int64
    let interestingnessComing: Int64?
    let engNormalAltNames: String?
    let favCount: Int64
    let language: String?
    let chiLanguage: String?
    let isCommentable: Bool?
    let isShowPromoIcon: Bool?
    let isOpenMonth: Bool?
    let status: Int64?
    let pagination: pagination
    let favourite: Bool?
    let notification: Bool?
    let screenShots: [String]?
    let commentDate: String?
    let rateCount: Int64
    let multitrailers: [String]?
    let trailerUrl: String?
    let infoDict: infoDict
    let chiInfoDict: chiInfoDict
    let duration: Int64?
    let rating: Int64?
    
    struct pagination: Codable {
        let comments: [String]?
        let page: Int64?
        let size: Int64?
        let total: Int64?
    }

    struct infoDict: Codable {
        let Category: String?
        let Language: String?
        let Director: String?
        let Genre: String?
        let Duration: String?
        let Cast: String?
    }

    struct chiInfoDict: Codable {
        let 演員: String?
        let 語言: String?
        let 級別: String?
        let 導演: String?
        let 類型: String?
        let 片長: String?
    }

}
