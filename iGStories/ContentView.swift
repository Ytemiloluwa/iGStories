//
//  ContentView.swift
//  iGStories
//
//  Created by Temiloluwa on 11/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    var width = UIScreen.main.bounds.width
    @State var text = ""
    var body: some View {
        
        TabView {
            
            ForEach(data) { story in
                
                
                // going to cubic transistion
                
                GeometryReader { g in
                    
                    ZStack {
                        
                        LinearGradient(gradient: .init(colors: [Color.pink, story.color]), startPoint: .top, endPoint: .bottomTrailing)
                            .cornerRadius(10)
                        
                        Image(story.story)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal)
                        VStack(alignment: .leading, spacing: 12) {
                            
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                                
                                Capsule()
                                    .fill(Color.black.opacity(0.3))
                                    .frame(height: 2.5)
                                
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: story.offset, height: 2.5)
                            })
                            
                            HStack(spacing: 12) {
                                
                                Image(story.story)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                Text(story.name)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)
                                
                                Text(story.time)
                                    .foregroundColor(.white)
                                
                            }
                            
                            Spacer()
                        }
                        .padding(.all)
                        
                    }
                    .frame(width: g.frame(in: .global).width, height: g.frame(in: .global).height)
                  
                    
                    // rotating view for animation
                    
                    .rotation3DEffect(.init(degrees: getAngle(offset: g.frame(in: .global).minX)), axis: (x: 0.0, y: 1.0, z: 0.0),
                                      // anchoring view based on user drag
                                      anchor: g.frame(in: .global).minX > 0 ? .leading : .trailing, perspective: 2.5)
                    
                    
                    
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.pink).edgesIgnoringSafeArea(.all)
    }
    
    func getAngle(offset: CGFloat) -> Double {
        
        // since each view is placed at the center
        // so half of the width is used to calculate the degree
        
        let tempAngle = offset / (width / 2 )
        let rotationEffect: CGFloat = 25
        
        return Double(tempAngle * rotationEffect)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Story : Identifiable {
    
    var id = UUID().uuidString
    var story: String
    var name : String
    var time: String
    var offset: CGFloat
    var color: Color
}

var data = [ Story(story: "1", name: "Temi", time: "11h", offset: 100, color: .purple),
             Story(story: "2", name: "Temi", time: "1h", offset: 200, color: .red),
             Story(story: "3", name: "Temi", time: "3h", offset: 50, color: .yellow),
             Story(story: "4", name: "Temi", time: "8h", offset: 250, color: .green),
             Story(story: "5", name: "Temi", time: "22h", offset: 80, color: .orange)
]
