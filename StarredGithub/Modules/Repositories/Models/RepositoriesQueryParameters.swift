import Foundation

struct RepositoriesQueryParameters: Codable {
    let query: RepositoriesQuery
    let sortType: String
    let pageNumber: Int
    let itemPerPageCount: Int
    
    func toDictionary() -> [String: Any] {
        return [
            "q": query.toString(),
            "sort": sortType,
            "page": pageNumber,
            "per_page": itemPerPageCount
        ]
    }
}

struct RepositoriesQuery: Codable {
    let language: String
    
    func toString() -> String {
        return "language:\(language)"
    }
}
