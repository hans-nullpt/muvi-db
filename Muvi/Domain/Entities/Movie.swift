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

struct MovieDetail: Codable {

    var video: Bool?
    var productionCompanies: [ProductionCompanies]?
    var title: String?
    var voteCount: Int?
    var originalTitle: String?
    var runtime: Int?
    var status: String?
    var id: Int?
    var spokenLanguages: [SpokenLanguages]?
    var overview: String?
    var backdropPath: String?
    var posterPath: String?
    var tagline: String?
    var revenue: Int?
    var imdbId: String?
    var adult: Bool?
    var originalLanguage: String?
//    var belongsToCollection: Any?
    var genres: [Genres]?
    var releaseDate: String?
    var popularity: Double?
    var homepage: String?
    var originCountry: [String]?
    var voteAverage: Double?
    var productionCountries: [ProductionCountries]?
    var budget: Int?

    enum CodingKeys: String, CodingKey {
        case video = "video"
        case productionCompanies = "production_companies"
        case title = "title"
        case voteCount = "vote_count"
        case originalTitle = "original_title"
        case runtime = "runtime"
        case status = "status"
        case id = "id"
        case spokenLanguages = "spoken_languages"
        case overview = "overview"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case tagline = "tagline"
        case revenue = "revenue"
        case imdbId = "imdb_id"
        case adult = "adult"
        case originalLanguage = "original_language"
//        case belongsToCollection = "belongs_to_collection"
        case genres = "genres"
        case releaseDate = "release_date"
        case popularity = "popularity"
        case homepage = "homepage"
        case originCountry = "origin_country"
        case voteAverage = "vote_average"
        case productionCountries = "production_countries"
        case budget = "budget"
    }
}

struct ProductionCompanies: Codable {

    var originCountry: String?
    var name: String?
    var id: Int?
    var logoPath: String?

    enum CodingKeys: String, CodingKey {
        case originCountry = "origin_country"
        case name = "name"
        case id = "id"
        case logoPath = "logo_path"
    }
}

struct SpokenLanguages: Codable {

    var name: String?
    var englishName: String?
    var iso6391: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
    }
}

struct Genres: Codable {

    var name: String?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
}

struct ProductionCountries: Codable {

    var name: String?
    var iso31661: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case iso31661 = "iso_3166_1"
    }
}
