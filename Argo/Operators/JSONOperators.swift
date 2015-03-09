import Runes

// MARK: Values

// Pull value from JSON
public func <|<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, key: String) -> DecodeResult<A> {
  return decodeObject(json) >>- { (A.decode <^> $0[key]) ?? .MissingKey(key) }
}

// Pull optional value from JSON
public func <|?<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, key: String) -> DecodeResult<A?> {
  return .optional(json <| key)
}

// Pull embedded value from JSON
public func <|<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, keys: [String]) -> DecodeResult<A> {
  return flatReduce(keys, json, <|) >>- { A.decode($0) }
}

// Pull embedded optional value from JSON
public func <|?<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, keys: [String]) -> DecodeResult<A?> {
  return .optional(json <| keys)
}

// MARK: Arrays

// Pull array from JSON
public func <||<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, key: String) -> DecodeResult<[A]> {
  return json <| key >>- decodeArray
}

// Pull optional array from JSON
public func <||?<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, key: String) -> DecodeResult<[A]?> {
  return .optional(json <|| key)
}

// Pull embedded array from JSON
public func <||<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, keys: [String]) -> DecodeResult<[A]> {
  return json <| keys >>- decodeArray
}

// Pull embedded optional array from JSON
public func <||?<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, keys: [String]) -> DecodeResult<[A]?> {
  return .optional(json <|| keys)
}

