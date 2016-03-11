//
//  PrestingHistory.swift
//  SmashTag
//
//  Created by abdelrahman mohamed on 3/5/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import Foundation

class PrestingHistory {
    private struct History {
        static let defaultsKey = "searchWords"
        static let numberOfSearches = 100
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var searchHistory: [String]{
        set{
            defaults.setObject(newValue, forKey: History.defaultsKey)
        }
        get{
            return defaults.objectForKey(History.defaultsKey) as? [String] ?? []
        }
    }
    
    func addWord(search: String){
        
        var currentSearches = searchHistory
        
        if let index = currentSearches.indexOf(search){
            currentSearches.removeAtIndex(index)
        }
        
        currentSearches.insert(search, atIndex: 0)
        
        while currentSearches.count > History.numberOfSearches {
            currentSearches.removeLast()
        }
        
        searchHistory = currentSearches
    }
    
    func deleteWord(index: Int) {
        var currentSearches = searchHistory
        currentSearches.removeAtIndex(index)
        searchHistory = currentSearches
    }
    
   
}
