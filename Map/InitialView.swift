//
//  InitialView.swift
//  Map
//
//  Created by Juan Camilo Marín Ochoa on 29/08/22.
//

import SwiftUI

struct InitialView: View {
    @State private var directions: [String] = []
    @State private var showDirections = false
    
    var body: some View {
        ZStack {
            MapView(directions: $directions).edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                Button(action: {
                    self.showDirections.toggle()
                }) {
                    Text("MOSTRAR RUTA")
                }
                .padding()
                .foregroundColor(Color(UIColor.white))
                .background(Color(directions.isEmpty ? UIColor.lightGray : UIColor.systemBlue))
                .cornerRadius(20)
                .disabled(directions.isEmpty)
                .keyboardShortcut(.defaultAction)
            }
        }.sheet(isPresented: $showDirections, content: {
            NavigationView {
                List(0..<self.directions.count, id: \.self) { i in
                    Text(self.directions[i]).padding()
                }
                .navigationTitle("Ruta Textual")
            }
        })
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
