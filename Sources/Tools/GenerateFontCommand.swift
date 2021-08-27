//
//  File.swift
//  
//
//  Created by Mason Phillips on 8/24/21.
//

import Foundation
import SwiftCLI
import Stencil
import SwiftUI

class GenerateFontCommand: Command {
    let name: String = "font"
    let shortDescription: String = "Generate font icons from a template"
    
    let defaultFontPath: String = "FortAwesome/Font-Awesome/otfs"
    let defaultMetaPath: String = "FortAwesome/Font-Awesome/metadata/icons.json"
    let defaultStencil : String = "FAIcon.stencil"
    
    @Key("-p", "--path", description: "The path of the font to generate for")
    var path: String?
    
    @Key("-m", "--meta", description: "The path to the metadata file used to generate icons")
    var meta: String?
    
    @Key("-s", "--stencil", description: "The name of the stencil to use")
    var stencil: String?
    
    enum GeneratorError: Error {
        case noMetaFileAtPath, noStencilFileAtPath
    }
    
    func execute() throws {
        let fontPath = self.path ?? defaultFontPath
        let metaPath = self.meta ?? defaultMetaPath
        let stencil  = self.stencil ?? defaultStencil
        
        guard let data = FileManager.default.contents(atPath: metaPath) else {
            throw GeneratorError.noMetaFileAtPath
        }
        let context = try JSONDecoder().decode(FAIcons.self, from: data)

        let extensions = registerExtensions()
        let fsLoader = FileSystemLoader(paths: ["Sources/Tools/stencils/"])
        let environment = Environment(loader: fsLoader, extensions: extensions)

        do {
            let rendered = try environment.renderTemplate(name: stencil, context: ["icons": context])
            print(rendered)
        } catch let error {
            if let error = error as? TemplateSyntaxError {
                print(error.reason)
            } else {
                print(error.localizedDescription)
            }
        }
        
//        let renderedString = try environment.renderTemplate(name: stencil, context: ["icons": context])
//        print(renderedString)
    }
    
    func registerExtensions() -> [Extension] {
        let keywords = Extension()
        keywords.registerFilter("keywords") { value in
            guard let value = value as? String else { return nil }
            switch value {
            case "500px"    : return "`fiveHundredPixels"
            case "default"  : return "`default`"
            case "subscript": return "`subscript`"
            default: return value
            }
        }
        keywords.registerFilter("camelCased") { (value: Any?, arguments: [Any?]) in
            guard let value = value as? String, let separator = arguments.first as? String else { return nil }
            return value.split(separator: Character(separator)).reduce("") { (accumulator: String, element: String.SubSequence) in
                "\(accumulator)\(accumulator.count > 0 ? String(element.capitalized) : String(element))"
            }
        }
        keywords.registerFilter("braced") { value in
            guard let value = value as? String else { return nil }
            return "{\(value)}"
        }
        
        return [keywords]
    }
}

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
