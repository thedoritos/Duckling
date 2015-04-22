//
//  Identifiers.swift
//  Duckling
//
//  Created by t-matsumura on 4/22/15.
//  Copyright (c) 2015 Humour Studio. All rights reserved.
//

import Argo
import Runes

struct Identifiers {
    let uuid: String
    let idPairs: [IdentifierPair]
}

struct IdentifierPair {
    let major: String
    let minor: String
}

extension Identifiers : JSONDecodable {
    static func create(uuid: String)(idPairs: [IdentifierPair]) -> Identifiers {
        return Identifiers(uuid: uuid, idPairs: idPairs)
    }
    
    static func decode(j: JSONValue) -> Identifiers? {
        return Identifiers.create
            <^> j <| "uuid"
            <*> j <|| "idPairs"
    }
}

extension IdentifierPair : JSONDecodable {
    static func create(major: String)(minor: String) -> IdentifierPair {
        return IdentifierPair(major: major, minor: minor)
    }
    
    static func decode(j: JSONValue) -> IdentifierPair? {
        return IdentifierPair.create
            <^> j <| "major"
            <*> j <| "minor"
    }
}