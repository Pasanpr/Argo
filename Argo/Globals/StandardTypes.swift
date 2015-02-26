import Foundation
import Runes

extension String: JSONDecodable {
  public static func fromJSON(j: JSON) -> Parser<String> {
    switch j {
    case let .String(s): return pure(s)
    default: return typeMismatch("String", j)
    }
  }
}

extension Int: JSONDecodable {
  public static func fromJSON(j: JSON) -> Parser<Int> {
    switch j {
    case let .Number(n): return pure(n as Int)
    default: return typeMismatch("Int", j)
    }
  }
}

extension Double: JSONDecodable {
  public static func fromJSON(j: JSON) -> Parser<Double> {
    switch j {
    case let .Number(n): return pure(n as Double)
    default: return typeMismatch("Double", j)
    }
  }
}

extension Bool: JSONDecodable {
  public static func fromJSON(j: JSON) -> Parser<Bool> {
    switch j {
    case let .Number(n): return pure(n as Bool)
    default: return typeMismatch("Bool", j)
    }
  }
}

extension Float: JSONDecodable {
  public static func fromJSON(j: JSON) -> Parser<Float> {
    switch j {
    case let .Number(n): return pure(n as Float)
    default: return typeMismatch("Float", j)
    }
  }
}

public func decodeArray<A where A: JSONDecodable, A == A.DecodedType>(value: JSON) -> Parser<[A]> {
  switch value {
  case let .Array(a): return sequence({ A.fromJSON($0) } <^> a)
  default: return typeMismatch("Array", value)
  }
}

public func typeMismatch<T>(type: String, object: JSON) -> Parser<T> {
  return .Failure("\(object) is not a \(type)")
}