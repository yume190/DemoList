//
//  DynamicLoadView.swift
//  DemoList
//
//  Created by Tangram Yume on 2023/12/7.
//

import Foundation
import SwiftUI
import CodeViewMonaco
import Workspace
import PathKit


struct DLView: View {
  let ws: Workspace
  @State var temp: Bool = false
  init(ws: Workspace) {
    self.ws = ws
  }
  
  var body: some View {
    if temp {
      reload
    } else {
      reload
    }
  }
  
  var reload: some View {
    load
      .onReceive(NotificationCenter.default.publisher(for: .load)) { notification in
        temp = !temp
      }
  }
  
  var load: AnyView {
    let path = ws.path + ".build/debug/libDL.dylib"
    if path.exists {
      return (try? PluginLoader.load(at: path.string)) ?? Text("Temp 123").anyView
    } else {
      return Text("Load Fail").anyView
    }
  }
}
