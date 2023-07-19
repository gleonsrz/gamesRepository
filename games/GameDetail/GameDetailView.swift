//
//  GameDetailView.swift
//  games
//
//  Created by Christian Leon on 18/07/23.
//
import RealmSwift
import SwiftUI

struct GameDetailView: View {
    @ObservedObject var viewModel = GameDetailViewModel()
    @ObservedResults(GameDetail.self) var favourites
    @State var presentedGame: GameDetail?
    var id: Int
    @State private var isFavourite: Bool
    
    init(id: Int, isFavourite: Bool) {
        self.id = id
        self._isFavourite = State(initialValue: isFavourite)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Spacer()
                    AsyncImage(url: URL(string: presentedGame != nil ? presentedGame!.thumbnail : viewModel.detalleJuego.thumbnail)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.gray.opacity(0.1)
                            .frame(width: 350, height: 200)
                    }
                    
                    Text(presentedGame != nil ? presentedGame!.title : viewModel.detalleJuego.title)
                        .font(.system(size: 32))
                        .foregroundColor(Color.blue)
                    
                    Spacer()
                    
                    HStack {
                        VStack(spacing: 8) {
                            HStack {
                                Text("Género: ")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color.blue)
                                Text(presentedGame != nil ? presentedGame!.genre : viewModel.detalleJuego.genre)
                                    .font(.system(size: 18))
                                Spacer()
                            }
                            
                            HStack {
                                Text("Editor: ")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color.blue)
                                Text(presentedGame != nil ? presentedGame!.publisher : viewModel.detalleJuego.publisher)
                                    .font(.system(size: 18))
                                Spacer()
                            }
                            
                            HStack {
                                Text("Fecha de lanzamiento: ")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color.blue)
                                Text(DateUtil.formatDate(presentedGame != nil ? presentedGame!.release_date : viewModel.detalleJuego.release_date))
                                    .font(.system(size: 18))
                                Spacer()
                            }
                        }
                        
                        Image(systemName: self.isGameAlreadyInFavourites() ? "heart.fill" : "heart")
                            .foregroundColor(.accentColor)
                            .imageScale(.large)
                            .onTapGesture {
                                if !self.isGameAlreadyInFavourites() {
                                    addFavourite()
                                } else {
                                    deleteFavourite()
                                }
                            }
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack(spacing: 8) {
                        HStack {
                            Text("Requisitos mínimos del sistema")
                                .font(.system(size: 24))
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.bottom, 16)
                        
                        
                        HStack {
                            Text("Sistema operativo: ")
                                .font(.system(size: 18))
                                .foregroundColor(Color.blue)
                            Text(presentedGame != nil ? presentedGame!.minimum_system_requirements?.os ?? "" : viewModel.detalleJuego.minimum_system_requirements?.os ?? "")
                                .font(.system(size: 18))
                            Spacer()
                        }
                        
                        HStack {
                            Text("Gráficos: ")
                                .font(.system(size: 18))
                                .foregroundColor(Color.blue)
                            Text(presentedGame != nil ? presentedGame!.minimum_system_requirements?.graphics ?? "" : viewModel.detalleJuego.minimum_system_requirements?.graphics ?? "")
                                .font(.system(size: 18))
                            Spacer()
                        }
                        
                        HStack {
                            Text("Memoria: ")
                                .font(.system(size: 18))
                                .foregroundColor(Color.blue)
                            Text(presentedGame != nil ? presentedGame!.minimum_system_requirements?.memory ?? "" : viewModel.detalleJuego.minimum_system_requirements?.memory ?? "")
                                .font(.system(size: 18))
                            Spacer()
                        }
                        
                        HStack {
                            Text("Procesador: ")
                                .font(.system(size: 18))
                                .foregroundColor(Color.blue)
                            Text(presentedGame != nil ? presentedGame!.minimum_system_requirements?.processor ?? "" : viewModel.detalleJuego.minimum_system_requirements?.processor ?? "")
                                .font(.system(size: 18))
                            Spacer()
                        }
                        
                        HStack {
                            Text("Almacenamiento: ")
                                .font(.system(size: 18))
                                .foregroundColor(Color.blue)
                            Text(presentedGame != nil ? presentedGame!.minimum_system_requirements?.storage ?? "" : viewModel.detalleJuego.minimum_system_requirements?.storage ?? "")
                                .font(.system(size: 18))
                            Spacer()
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Text(presentedGame != nil ? presentedGame!.gameDescriptionText : viewModel.detalleJuego.gameDescriptionText)
                        .font(.system(size: 20))
                        .padding()
                    
                    
                    ImageCarouselView(images: returnURLArray(screenshots: presentedGame != nil ? presentedGame!.screenshots : viewModel.detalleJuego.screenshots))
                        .frame(height: 220, alignment: .center)
                        .padding()
                    
                }
                .onAppear {
                    self.viewModel.obtenerDetalleJuego(id: self.id)
                }
                .padding(.bottom, 16)
                .lineSpacing(8.0)
            }
            .padding()
        }
            
    }
    
    func isGameAlreadyInFavourites() -> Bool {
        if let _ = favourites.firstIndex(where: { $0.id == self.id }) {
            return true
        }
        
        return false
    }
    
    func returnURLArray(screenshots: RealmSwift.List<Screenshot>) -> [URL] {
        let screenshotArray = Array(screenshots)
        var finalArray: [URL] = []
        for screenshot in screenshotArray {
            if let imageString = screenshot.image, let url = URL(string: imageString) {
                finalArray.append(url)
            }
        }
        return finalArray
    }
    
    func addFavourite() {
        self.presentedGame = self.presentedGame != nil ? self.presentedGame: viewModel.detalleJuego
        let newFavourite = GameDetail()
        newFavourite.id = self.presentedGame != nil ? self.presentedGame!.id :viewModel.detalleJuego.id
        newFavourite.title = self.presentedGame != nil ? self.presentedGame!.title : viewModel.detalleJuego.title
        newFavourite.thumbnail = self.presentedGame != nil ? self.presentedGame!.thumbnail : viewModel.detalleJuego.thumbnail
        newFavourite.short_description = self.presentedGame != nil ? self.presentedGame!.short_description : viewModel.detalleJuego.short_description
        newFavourite.game_url = self.presentedGame != nil ? self.presentedGame!.game_url : viewModel.detalleJuego.game_url
        newFavourite.genre = self.presentedGame != nil ? self.presentedGame!.genre : viewModel.detalleJuego.genre
        newFavourite.platform = self.presentedGame != nil ? self.presentedGame!.platform : viewModel.detalleJuego.platform
        newFavourite.publisher = self.presentedGame != nil ? self.presentedGame!.publisher : viewModel.detalleJuego.publisher
        newFavourite.developer = self.presentedGame != nil ? self.presentedGame!.developer : viewModel.detalleJuego.developer
        newFavourite.release_date = self.presentedGame != nil ? self.presentedGame!.release_date : viewModel.detalleJuego.release_date
        newFavourite.freetogame_profile_url = self.presentedGame != nil ? self.presentedGame!.freetogame_profile_url : viewModel.detalleJuego.freetogame_profile_url
        newFavourite.gameDescriptionText = self.presentedGame != nil ? self.presentedGame!.gameDescriptionText : viewModel.detalleJuego.gameDescriptionText
        //newFavourite.screenshots = self.presentedGame != nil ? self.presentedGame!.screenshots : viewModel.detalleJuego.screenshots
        newFavourite.status = self.presentedGame != nil ? self.presentedGame!.status : viewModel.detalleJuego.status
        //newFavourite.minimum_system_requirements = self.presentedGame != nil ? self.presentedGame!.minimum_system_requirements : viewModel.detalleJuego.minimum_system_requirements
        newFavourite.minimum_system_requirements?.id = UUID()
        newFavourite.isFavourite = true
        $favourites.append(newFavourite)
        self.isFavourite = true
        viewModel.detalleJuego.isFavourite = true
    }
    
    func deleteFavourite() {
        self.presentedGame = self.presentedGame != nil ? self.presentedGame: viewModel.detalleJuego
        if let index = favourites.firstIndex(where: { $0.id == self.id }) {
            let game = favourites[index]
            let thawedGame = game.thaw()
            
            if let realm = thawedGame?.realm {
                try? realm.write {
                    /*for screenshot in thawedGame!.screenshots {
                        realm.delete(screenshot)
                    }
                    
                    if let requirements = thawedGame!.minimum_system_requirements {
                        realm.delete(requirements)
                    }*/
                    
                    realm.delete(thawedGame!)
                }
            }
            
        }
        self.isFavourite = false
        viewModel.detalleJuego.isFavourite = false
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(id: 339, isFavourite: true)
    }
}
