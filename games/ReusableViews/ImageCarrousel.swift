//
//  ImageCarrousel.swift
//  games
//
//  Created by Christian Leon on 18/07/23.
//

import SwiftUI
import Combine

struct ImageCarouselView: View {
    private var images: [IdentifiableURL]
    @State private var currentIndex: Int = 0
    
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    init(images: [URL]) {
        self.images = images.map { IdentifiableURL(url: $0) }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack{
                HStack(spacing: 0) {
                    ForEach(images) { identifiableURL in
                        AsyncImage(url: identifiableURL.url) { image in
                            image
                                .resizable()
                        } placeholder: {
                            Color.gray.opacity(0.1)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                .animation(.spring())
                .onReceive(self.timer) { _ in
                    self.currentIndex = (self.currentIndex + 1) % images.count
                }
                ZStack(alignment: .bottom) {
                    HStack(spacing: 3) {
                        ForEach(0..<self.images.count, id: \.self) { index in
                            Circle()
                                .frame(width: index == self.currentIndex ? 10 : 8,
                                       height: index == self.currentIndex ? 10 : 8)
                                .foregroundColor(index == self.currentIndex ? Color.blue : .white)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                .animation(.spring())
                                .clipped()
                        }
                    }
                    .padding(.bottom, 16)
                }
            }
        }
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hola")
        /*GeometryReader { geometry in
                    ScrollView {
                        VStack {
                            Spacer()
                            // ... Rest of the code ...
                            
                            ImageCarouselView(images: ["https://www.freetogame.com/g/521/diablo-immortal-1.jpg", "https://www.freetogame.com/g/521/diablo-immortal-2.jpg", "https://www.freetogame.com/g/521/diablo-immortal-3.jpg"])
                                .frame(height: 300, alignment: .center)
                            
                            // ... Rest of the code ...
                        }
                        .onAppear {
                            self.viewModel.obtenerDetalleJuego(id: self.id)
                        }
                        .lineSpacing(8.0)
                    }
                    .padding()
                }
        */
    }
}
