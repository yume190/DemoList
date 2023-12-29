//
//  AnyView.swift
//  DemoList
//
//  Created by Tangram Yume on 2023/12/7.
//

import SwiftUI


extension View {
  var anyView: AnyView {
    .init(erasing: self)
  }
}
