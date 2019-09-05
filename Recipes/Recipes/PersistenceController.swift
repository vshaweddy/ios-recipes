//
//  PersistenceController.swift
//  Recipes
//
//  Created by Vici Shaweddy on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation

class PersistenceController {
    private var recipeListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("RecipeList.plist")
    }
    
    func saveToPersistentStore(recipes: [Recipe]?) {
        guard let url = recipeListURL, let recipes = recipes else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let recipeData = try encoder.encode(recipes)
            try recipeData.write(to: url)
        } catch {
            print("Error saving recipe data: \(error)")
        }
    }
    
    func loadFromPersistentStore(completion: ([Recipe]?, Error?) -> Void)  {
        let fileManager = FileManager.default
        guard let url = recipeListURL, fileManager.fileExists(atPath: url.path) else {
            completion(nil, nil)
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let recipes = try decoder.decode([Recipe].self, from: data)
            completion(recipes, nil)
        } catch {
            print("Error loading recipe data: \(error)")
            completion(nil, error)
        }
    }
}
