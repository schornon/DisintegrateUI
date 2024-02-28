//
//  ContentView.swift
//  DisintegrateUISandbox
//
//  Created by Serhii Chornonoh on 28.02.2024.
//

import SwiftUI
import DisintegrateUI

struct ContentView: View {
    
    enum Hero: String, Identifiable, CaseIterable {
        var id: String { rawValue }
        
        case blackPanther, blackWidow, bruceBanner, captainAmerica, doctorStrange, drax, rocket, scarletWitch, spiderMan, starLord, strongestAvenger, tonyStark
    }
    
    @State var fallenHeroes: Set<Hero> = .init()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 16) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Hero.allCases) { hero in
                    let fallen = fallenHeroes.contains(hero)
                    HeroView(hero: hero, fallen: fallen)
                }
            }
            
            Button("Thanos: Snap!") {
                disintegrateHero()
            }
        }
        .padding()
        .onReceive(timer) { _ in
            disintegrateHero()
        }
    }
    
    func disintegrateHero() {
        let heroes = Set(Hero.allCases).subtracting(fallenHeroes)
        if let hero = heroes.first {
            fallenHeroes.insert(hero)
        }
    }
    
    struct HeroView: View {
        let hero: Hero
        let fallen: Bool
        
        var body: some View {
            Image(hero.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipped()
                .disintegrate(snap: fallen, completion: {})
        }
    }
}

#Preview {
    ContentView()
}
