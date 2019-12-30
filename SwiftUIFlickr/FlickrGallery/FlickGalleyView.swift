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
    //    let row: hotoViewModel.photos
    let numberOfColumn: Int = 3
    @State var search: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $search)
                    .font(.body)
                .padding(.all)
                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                .background(Color(red: 239.0/255.0, green: 243.0/255, blue: 244.0/255.0, opacity:1.0))
                Button(action: {
                    print("Delete button tapped!")
                }) {
                    HStack {
                        Image(systemName: "circle.grid.3x3.fill")
                            .font(.headline)
                        Text("Select")
                    }.padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
                }
            }
            
            List() {
                ForEach(0..<40) { _ in
                    HStack {
                        ForEach(0..<self.numberOfColumn) { _ in
                            Image("1")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
            }.padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: -20))
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlickGalleyView(search: "Hello")
    }
}
