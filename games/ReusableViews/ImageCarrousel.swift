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
    var testImages: [IdentifiableURL] = [IdentifiableURL(id: UUID(), url: URL(string: "https://www.freetogame.com/g/540/overwatch-2-1.jpg")!), IdentifiableURL(id: UUID(), url: URL(string: "https://www.freetogame.com/g/540/overwatch-2-2.jpg")!), IdentifiableURL(id: UUID(), url: URL(string: "https://www.freetogame.com/g/540/overwatch-2-3.jpg")!)]
    @State private var currentIndex: Int = 0
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    static var previews: some View {
        let imageCarouselView = ImageCarouselView_Previews()
        GeometryReader { geometry in
            VStack{
                HStack(spacing: 0) {
                    ForEach(imageCarouselView.testImages) { identifiableURL in
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
                .offset(x: CGFloat(imageCarouselView.currentIndex) * -geometry.size.width, y: 0)
                .animation(.spring())
                .onReceive(imageCarouselView.timer) { _ in
                    imageCarouselView.currentIndex = (imageCarouselView.currentIndex + 1) % imageCarouselView.testImages.count
                }
                ZStack(alignment: .bottom) {
                    HStack(spacing: 3) {
                        ForEach(0..<imageCarouselView.testImages.count, id: \.self) { index in
                            Circle()
                                .frame(width: index == imageCarouselView.currentIndex ? 10 : 8,
                                       height: index == imageCarouselView.currentIndex ? 10 : 8)
                                .foregroundColor(index == imageCarouselView.currentIndex ? Color.blue : .white)
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
