//
//  ContentView.swift
//  DemoList
//
//  Created by Tangram Yume on 2023/12/5.
//

import SwiftUI
import PathKit
import CodeViewMonaco
import Workspace
import WebKit

struct ContentView: View {
  @State var items: [Workspace] = Workspace.list
  @State private var selection: Workspace? = nil // Nothing selected by default.
  
  @State var isOpen: Bool = false
  @State var newTitle: String = ""
  
  var body: some View {
    NavigationSplitView {
      List(items, id: \.self, selection: $selection) { ws in
        NavigationLink(ws.path.lastComponent.description, value: ws.path)
      }
    } detail: {
      HStack {
        CodeView(selection?.load(.code))
        if let ws = selection {
          DLView(ws: ws)
        }
      }
    }
    .onReceive(NotificationCenter.default.publisher(for: .build)) { notification in
      Task { @MainActor in
        print("[Build] start")
        let res = try? selection?.executeCommand()
        print("[Build] res: \(res ?? "")")
        print("[Build] done")
        NotificationCenter.default.post(name: .load, object: nil)
      }
    }
    .toolbar {
      toolbars
    }
  }
  
  var toolbars: some ToolbarContent {
    ToolbarItemGroup {
      Button(action: { isOpen = true }, label: {
        Label("Login", systemImage: "plus.circle")
      })
      .sheet(isPresented: $isOpen) {
        //        NavigationView {
        VStack {
          TextField("Enter Title", text: $newTitle)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
          
          HStack {
            Button("Cancel") {
              isOpen = false
            }
            .padding()
            
            Spacer()
            
            Button("OK") {
              let ws = Workspace(demo: newTitle)
              guard !ws.path.exists else {
                return
              }
              ws.initial()
              items.append(ws)
              isOpen = false
              newTitle = "" // Reset the title for the next use
            }
            .padding()
          }
        }
      }
    }
  }
}


#Preview {
  ContentView()
}
