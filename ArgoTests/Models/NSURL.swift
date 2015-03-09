import Argo
import Foundation

extension NSURL: JSONDecodable {
  public typealias DecodedType = NSURL

  public class func decode(j: JSON) -> DecodeResult<NSURL> {
    switch j {
    case .String(let urlString):
      return NSURL(string: urlString).map(pure) ?? .TypeMismatch("\(j) is not a URL")
    default: return .TypeMismatch("\(j) is not a URL")
    }
  }
}
