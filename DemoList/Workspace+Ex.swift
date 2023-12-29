//
//  Workspace.swift
//  DemoList
//
//  Created by Tangram Yume on 2023/12/28.
//

import Foundation
import Workspace
import PathKit

public extension Workspace {
  /// located in ~/.demo/$path
  private static let _demo = Path.home + ".demo"
  
  init(demo: String) {
    self.init(path: (Workspace._demo + demo).string)
  }
  
  static var list: [Workspace] {
    do {
      let list = try Self._demo.children().filter(\.isDirectory).map(\.lastComponent).map(Workspace.init(demo:))
      return list
    } catch {
      return []
    }
  }
  func initial() {
    initialize(.code, .loadable, .spm)
  }
}


public extension SourceFile {
  static let spm = SourceFile(.swift, """
  // swift-tools-version: 5.7
  
  import PackageDescription
  
  let package = Package(
      name: "SPM",
      platforms: [
          .macOS(.v11)
      ],
      products: [
          .library(name: "DL", type: .dynamic, targets: ["DL"]),
      ],
      targets: [
          .target(name: "DL")
      ]
  )
  """, "Package.swift")
  
  static let code = SourceFile(.swift, """
  import SwiftUI
  
  struct ContentView: View {
      @State var count = 0
  
      var body: some View {
          VStack {
              Text("\\(count)")
  
              Button("+") {
                  count += 1
              }
  
              Button("-") {
                  count -= 1
              }
  
              Button("++") {
                  count += 100
              }
          }
          .foregroundColor(.white)
          .background(Color.black)
      }
  }
  """, "Sources/DL/View.swift")
  
  static let loadable = SourceFile(.swift, """
  import SwiftUI
  
  open class PluginBuilder {
      // MARK: Lifecycle
  
      public init() { }
  
      // MARK: Open
  
      open func build() -> any View {
          print("dummy")
          return Text("dummy")
      }
  }
  
  final class _PluginBuilder: PluginBuilder {
      override final
      func build() -> any View {
          print("Plugin")
          return ContentView()
      }
  }
  
  @_cdecl("createPlugin")
  public func createPlugin() -> UnsafeMutableRawPointer {
      Unmanaged.passRetained(_PluginBuilder()).toOpaque()
  }
  
  """, "Sources/DL/Loadable.swift")
}
