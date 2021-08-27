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
    
    let defaultEnumName: String = "FAIcon"
    let defaultEnumFile: String = "FA-Enum.swift"
    let defaultFontPath: String = "FortAwesome/Font-Awesome/otfs"
    let defaultMetaPath: String = "FortAwesome/Font-Awesome/metadata/icons.json"
    let defaultStencil : String = "FAIcon.stencil"
    
    @Key("-p", "--path", description: "The path of the font to generate for")
    var path: String?
    
    @Key("-m", "--meta", description: "The path to the metadata file used to generate icons")
    var meta: String?
    
    @Key("-s", "--stencil", description: "The name of the stencil to use")
    var stencil: String?
    
    @Key("-f", "--filename", description: "The filename to generate")
    var enumFilename: String?
    
    @Key("-e", "--enumName", description: "The enum name to generate")
    var enumName: String?
    
    enum GeneratorError: Error {
        case noMetaFileAtPath, noStencilFileAtPath
    }
    
    func execute() throws {
        let enumName = self.enumName ?? defaultEnumName
        let enumFile = self.enumFilename ?? defaultEnumFile
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

        // Uncomment for debugging stencil
//        do {
//            let rendered = try environment.renderTemplate(name: stencil, context: ["icons": context])
//            print(rendered)
//        } catch let error {
//            if let error = error as? TemplateSyntaxError {
//                print(error.reason)
//            } else {
//                print(error.localizedDescription)
//            }
//        }
        
        // Render icon template
        let renderedString = try environment.renderTemplate(name: stencil, context: ["enum": enumName, "icons": context])
        FileManager.default.createFile(atPath: "Sources/Core/\(enumFile)", contents: renderedString.data(using: .utf8), attributes: nil)
        
        // Gather all existing fonts
        let existingFonts = try! FileManager.default.contentsOfDirectory(atPath: "Sources/Core/Resources")
        
        // Copy new fonts
        let fontFiles = try! FileManager.default.contentsOfDirectory(atPath: fontPath)
        fontFiles.forEach { fontFile in
            // Copy only fonts
            guard fontFile.hasSuffix(".otf") else { return }
            
            // Remove a font if it already exists
            if existingFonts.contains(fontFile) {
                try! FileManager.default.removeItem(atPath: "Sources/Core/Resources/\(fontFile)")
            }
            
            try! FileManager.default.copyItem(atPath: "\(fontPath)/\(fontFile)", toPath: "Sources/Core/Resources/\(fontFile)")
        }
        
        print("Done! Copied \(fontFiles.count) otf files and created \(context.count) icons")
    }
    
    func registerExtensions() -> [Extension] {
        let faIcon = Extension()
        faIcon.registerFilter("keywords") { value in
            guard let value = value as? String else { return nil }
            switch value {
            case "500px"    : return "fiveHundredPixels"
            case "default"  : return "`default`"
            case "subscript": return "`subscript`"
            default: return value
            }
        }
        faIcon.registerFilter("camelCased") { (value: Any?, arguments: [Any?]) in
            guard let value = value as? String, let separator = arguments.first as? String else { return nil }
            return value.split(separator: Character(separator)).reduce("") { (accumulator: String, element: String.SubSequence) in
                "\(accumulator)\(accumulator.count > 0 ? String(element.capitalized) : String(element))"
            }
        }
        faIcon.registerFilter("braced") { value in
            guard let value = value as? String else { return nil }
            return "{\(value)}"
        }
        faIcon.registerFilter("styles") { value in
            guard let value = value as? Array<String> else { return nil }
            return value.joined(separator: ", .")
        }
        
        return [faIcon]
    }
}
