//
//  ContentView.swift
//  LGDSwiftUI
//
//  Created by LvGuangDa on 2020/2/7.
//  Copyright © 2020 shijunnian. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLeftNav = false
    @State var isRightNav = false
    
    init() {
        //修改导航栏文字颜色
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        UINavigationBar.appearance().tintColor = .systemBlue
    }
    
    var body: some View {
        
        TabView {
            // Tab1:
            NavigationView {
                Text("This is the first tab.")
            }.tabItem {
                Image.init(systemName: "star.fill")
                Text("Tab1").font(.subheadline)
            }
            
            // Tab2:
            NavigationView {
                Text("This is the second tab.")
            }.tabItem {
                Image.init(systemName: "star.fill")
                Text("Tab2").font(.subheadline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
