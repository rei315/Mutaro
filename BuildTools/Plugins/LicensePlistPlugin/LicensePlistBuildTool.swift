import Foundation
import PackagePlugin

@main
struct LicensePlistBuildTool: BuildToolPlugin {
    func createBuildCommands(context _: PluginContext, target _: Target) async throws -> [Command] {
        Diagnostics.error("Plugin only supported in Xcode build phases")
        return []
    }
}

#if canImport(XcodeProjectPlugin)
    import XcodeProjectPlugin

    extension LicensePlistBuildTool: XcodeBuildToolPlugin {
        func createBuildCommands(context: XcodePluginContext, target _: XcodeTarget) throws -> [Command] {
            guard ProcessInfo.processInfo.environment["CI"] == nil else {
                return []
            }

            let licensePlist = try context.tool(named: "license-plist")
            let fileManager = FileManager.default

            // Checks LicensePlist config

            let configPath = context.xcodeProject.directory.appending(subpath: "license_plist.yml")
            guard fileManager.fileExists(atPath: configPath.string) else {
                Diagnostics.error("Can't find 'license_plist.yml' file")
                return []
            }

            // The folder with checked out package sources
            let packageSourcesPath = context.pluginWorkDirectory
                .removingLastComponent()
                .removingLastComponent()
                .removingLastComponent()
                .removingLastComponent()

            // Output directory inside build output directory
            let outputDirectoryPath = context.pluginWorkDirectory.appending(subpath: "com.mono0926.LicensePlist.Output")
            try fileManager.createDirectory(atPath: outputDirectoryPath.string, withIntermediateDirectories: true)

            return [
                .prebuildCommand(
                    displayName: "LicensePlist is processing licenses...",
                    executable: licensePlist.path,
                    arguments: [
                        "--sandbox-mode",
                        "--config-path",
                        configPath.string,
                        "--package-sources-path",
                        packageSourcesPath,
                        "--output-path",
                        outputDirectoryPath.string
                    ],
                    outputFilesDirectory: context.pluginWorkDirectory
                )
            ]
        }
    }

#endif
