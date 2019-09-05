//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Vici Shaweddy on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    // MARK: - Properties
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Private Function
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
        if let unwrappedRecipe = recipe {
            self.titleLabel.text = unwrappedRecipe.name
            self.instructionsTextView.text = unwrappedRecipe.instructions
        } else {
            print("No recipe")
        }

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
