//
//  Swift-FormatPlugin.swift
//  
//
//  Created by minguk-kim on 2023/01/19.
//

import Foundation
import PackagePlugin

@main
struct SwiftFormatPlugin {
    func format(tool: PluginContext.Tool, targetDirectories: [String], configurationFilePath: String?) throws {
        let swiftFormatExec = URL(fileURLWithPath: tool.path.string)
        
        var arguments: [String] = ["format"]
        
        arguments.append(contentsOf: targetDirectories)
        
        arguments.append(contentsOf: ["--recursive", "--parallel", "--in-place"])
        
        if let configurationFilePath = configurationFilePath {
            arguments.append(contentsOf: ["--configuration", configurationFilePath])
        }
        
        let process = try Process.run(swiftFormatExec, arguments: arguments)
        process.waitUntilExit()
        
        if process.terminationReason == .exit && process.terminationStatus == 0 {
            print("Formatted the source code.")
        }
        else {
            let problem = "\(process.terminationReason):\(process.terminationStatus)"
            Diagnostics.error("swift-format invocation failed: \(problem)")
        }
    }
}

extension SwiftFormatPlugin: CommandPlugin {
    func performCommand(
        context: PluginContext,
        arguments: [String]
    ) async throws {
        let swiftFormatTool = try context.tool(named: "swift-format")
        
        var argExtractor = ArgumentExtractor(arguments)
        let targetNames = argExtractor.extractOption(named: "target")
        let targetsToFormat = try context.package.targets(named: targetNames)
        
        let configurationFilePath = argExtractor.extractOption(named: "configuration").first
        
        let sourceCodeTargets = targetsToFormat.compactMap{ $0 as? SourceModuleTarget }
        
        try format(
            tool: swiftFormatTool,
            targetDirectories: sourceCodeTargets.map(\.directory.string),
            configurationFilePath: configurationFilePath
        )
    }
}
