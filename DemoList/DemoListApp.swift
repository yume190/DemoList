//
//  DemoListApp.swift
//  DemoList
//
//  Created by Tangram Yume on 2023/12/5.
//

import SwiftUI

extension Notification.Name {
  static let save = Notification.Name(rawValue: "com.codeview.save")
  static let build = Notification.Name(rawValue: "com.codeview.build")
  static let load = Notification.Name(rawValue: "com.codeview.load")
  static let loadCode = Notification.Name(rawValue: "com.codeview.loadCode")
}

@main
struct DemoListApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .commands {
      CommandMenu("WS") {
        Divider()
        Button("Build") {
          NotificationCenter.default.post(name: .build, object: nil)
        }.keyboardShortcut("b", modifiers: [.command])
        Button("Save") {
          NotificationCenter.default.post(name: .save, object: nil)
        }.keyboardShortcut("s", modifiers: [.command])
        Button("Load Code") {
          NotificationCenter.default.post(name: .loadCode, object: nil)
        }.keyboardShortcut("l", modifiers: [.command])
      }
    }
  }
}
