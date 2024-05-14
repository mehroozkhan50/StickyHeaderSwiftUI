//
//  Home.swift
//  stickyHeader
//
//  Created by Emblem Technologies on 4/24/24.
//

import SwiftUI

struct Home: View {
    var size : CGSize
    var safeArea : EdgeInsets
    
    @State private var offsetY : CGFloat = 0
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 0){
                HeaderView()
                    .zIndex(1000)
                
                SampleCardsView()
            }
            .background{
                ScrollDetector { offset in
                    offsetY = -offset
                } onDraggingEnd: { offset, velocity in
                    
                }
            }
        }
    }
    @ViewBuilder func HeaderView() -> some View{
        let headerHeight = (size.height * 0.3) + safeArea.top
        let minmumHeaderHeight = 65 + safeArea.top
        
        let progress = max(min(-offsetY / (headerHeight - minmumHeaderHeight), 1), 0)
        GeometryReader{_ in
            ZStack{
                Rectangle()
                    .fill(Color.pink)
                
                VStack(spacing: 15){
                    GeometryReader{
                        let rect = $0.frame(in: .global)
                        let halfScaleHeight = (rect.height * 0.3) * 0.5
                        let midY = rect.midY
                        let bottomPadding : CGFloat = 15
                        let resizeOffsetY = (midY - (minmumHeaderHeight - halfScaleHeight - bottomPadding))
                        
                        Image("dummy_image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: rect.width, height: rect.height)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .scaleEffect(1 - (progress * 0.7), anchor: .leading)
                            .offset(x: -(rect.minX - 15) * progress, y: -resizeOffsetY * progress)
                    }
                    .frame(width: headerHeight * 0.5, height: headerHeight * 0.5)
                    
                    
                    Text("Mehrooz Khan")
                        .foregroundColor(.white)
                        .scaleEffect(1 - (progress *  0.15))
                        .offset(y : -4.5 * progress)
                }
                .padding(.top, safeArea.top)
                .padding(.bottom , 15)
            }
            .frame(height: (headerHeight + offsetY) < minmumHeaderHeight ? minmumHeaderHeight : (headerHeight + offsetY), alignment: .bottom)
            .offset(y: -offsetY)
        }
        .frame(height: headerHeight)
    }
    
    //simple cards
    @ViewBuilder
    func SampleCardsView() -> some View{
        VStack(spacing: 15){
            ForEach(1...25, id: \.self){ _ in
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.black)
                    .frame(height: 75)
            }
        }
    }
}

struct Home_previews : PreviewProvider{
    static var previews: some View{
        ContentView()
    }
    
}
