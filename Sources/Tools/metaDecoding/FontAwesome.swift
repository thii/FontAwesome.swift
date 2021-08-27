//
//  File.swift
//  
//
//  Created by Mason Phillips on 8/27/21.
//

import Foundation

typealias FAIcons = Dictionary<String, FAIcon>
struct FAIcon: Decodable {
    let changes: Array<String>
    let styles : Array<String>
    let unicode: String
    let label  : String
    let svg    : Dictionary<String, SVG>
    
    struct SVG: Decodable {
        let raw    : String
        let viewBox: Array<String>
        let width  : Int
        let height : Int
        let path   : Path
        
        enum Path: Decodable {
            case single(path: String)
            case multiple(path: [String])
            
            init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                
                if let path = try? container.decode(String.self) {
                    self = .single(path: path)
                } else if let path = try? container.decode(Array<String>.self) {
                    self = .multiple(path: path)
                } else {
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "An unexpected SVG path was found")
                }
            }
        }
    }
}
