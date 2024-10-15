//
//  Movie.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 11/10/24.
//

struct MovieResult: Codable {
  
  var page: Int?
  var totalResults: Int?
  var results: [Movie]?
  var totalPages: Int?
  //    var dates: Dates?
  
  enum CodingKeys: String, CodingKey {
    case page = "page"
    case totalResults = "total_results"
    case results = "results"
    case totalPages = "total_pages"
    //        case dates = "dates"
  }
}

struct Movie: Codable, Hashable {
  
  var popularity: Double?
  var voteCount: Int?
  var posterPath: String?
  var releaseDate: String?
  var overview: String?
  var voteAverage: Double?
  var backdropPath: String?
  var id: Int?
  var adult: Bool?
  var video: Bool?
  var originalLanguage: String?
  var title: String?
  var genreIds: [Int]?
  var originalTitle: String?
  
  enum CodingKeys: String, CodingKey {
    case popularity = "popularity"
    case voteCount = "vote_count"
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case overview = "overview"
    case voteAverage = "vote_average"
    case backdropPath = "backdrop_path"
    case id = "id"
    case adult = "adult"
    case video = "video"
    case originalLanguage = "original_language"
    case title = "title"
    case genreIds = "genre_ids"
    case originalTitle = "original_title"
  }
}
