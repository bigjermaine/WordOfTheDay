//
//  WordOfTheDayViewModel.swift
//  WordOfTheDay
//
//  Created by Kyle Dold on 04/02/2021.
//

import NetworkKit
import SwiftUI

class WordOfTheDayViewModel: ObservableObject {
    
    let title = LocalizedStringKey("app.title")
    let definitionText = LocalizedStringKey("word_of_the_day.definition")
    let exampleText = LocalizedStringKey("word_of_the_day.example")
    let originText = LocalizedStringKey("word_of_the_day.origin")
    
    @Published var word = ""
    @Published var wordDescription = ""
    @Published var wordExample = ""
    @Published var origin = ""
    
    func fetchData() {
        
        API.getWordOfTheDay(for: Date()) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let wordOfTheDayResponse):
                self.word = wordOfTheDayResponse.word  ?? ""
                self.wordDescription = wordOfTheDayResponse.definitions?.first?.text ?? ""
                self.wordExample = wordOfTheDayResponse.examples?.first?.text ?? ""
                self.origin = wordOfTheDayResponse.note  ?? ""
                
            case .failure:
                break
            }
        }
    }
}

