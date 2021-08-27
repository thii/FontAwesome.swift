import Foundation
import SwiftCLI

let tools = CLI(name: "tools", version: "1.0.0", description: "FontAwesome.swift tools")
tools.commands = [GenerateFontCommand()]

tools.goAndExit()
