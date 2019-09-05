//
//  MainViewController.swift
//  Recipes
//
//  Created by Vici Shaweddy on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Properties
    
    private let networkClient = RecipesNetworkClient()
    
    private var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    private var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    private var filteredRecipes: [Recipe] = [] {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                print("Error loading recipes: \(error)")
                return
            }
            
            // set the value allRecipes
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    // MARK: - Action Handlers
    
    @IBAction func search(_ sender: Any) {
        self.searchTextField.resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Private
    
    func filterRecipes() {
        if let searchTerm = self.searchTextField.text, !searchTerm.isEmpty {
            filteredRecipes = allRecipes.filter({ (recipe: Recipe) -> Bool in
                return recipe.name.lowercased().contains(searchTerm.lowercased()) ||
                       recipe.instructions.lowercased().contains(searchTerm.lowercased()) == true
            })
        } else {
            self.filteredRecipes = self.allRecipes
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            self.recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }

}
