//
//  DataView.swift
//  DemoList
//
//  Created by Tangram Yume on 2023/12/28.
//

import Foundation

import SwiftUI

struct DataView: View {
    @State var count = 0
    
    var body: some View {
        VStack {
            Text("\(count)")
                
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
