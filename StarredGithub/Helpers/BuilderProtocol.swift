import Foundation

protocol Builder {
    associatedtype Parameters
    associatedtype Return

    static func build(with parameters: Parameters) -> Return
}

extension Builder where Parameters == Void {

    static func build() -> Return {
        return build(with: ())
    }
}
