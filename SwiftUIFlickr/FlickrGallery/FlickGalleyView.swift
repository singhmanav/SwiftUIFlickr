//
//  ContentView.swift
//  SwiftUIFlickr
//
//  Created by Manav on 30/12/19.
//  Copyright © 2019 Manav. All rights reserved.
//

import SwiftUI
import UIKit
struct FlickGalleyView: View {
    let row: photoViewModel.photos
    let numberOfColumn: Int = 3
    
    var body: some View {
        List() {
            ForEach(row) { _ in
                HStack {
                    ForEach(0..<numberOfColumn) { _ in
                        Image
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }.padding(EdgeInsets.init(top: 0, leading: -20, bottom: 0, trailing: -20))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlickGalleyView()
    }
}
