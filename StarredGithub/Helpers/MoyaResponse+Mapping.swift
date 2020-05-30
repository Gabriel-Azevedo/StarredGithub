import Moya
import RxSwift
import Foundation

extension ObservableType where Element == Moya.Response {
    func map<T: Decodable>(_ type: T.Type) -> Observable<T> {
        return flatMap { (response: Response) -> Observable<T> in
            return Observable.just(try response.map(type))
        }
    }
}
