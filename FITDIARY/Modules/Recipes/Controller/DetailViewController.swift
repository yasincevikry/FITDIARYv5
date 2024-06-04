////  DetailViewController.swift
////  FITDIARY
////
//

import UIKit
import CoreData
import Foundation

class DetailViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var recipe: Recipe!
    var ingredientsArray = [String]()
    var ingredients = [Ingredient]()
    var image = UIImage()
    var isSavedRecipe = false
    var foodRecipe: FoodRecipe!
    let instructionsButton = UIButton()
    let addToDiaryButton = UIButton()
    let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
    var isFav = false
    var favoriteRecipes: [FoodRecipe] = []

    //MARK: - View Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ThemeColors.colorLightOrange.associatedColor
        tableView.separatorColor = .white

        if foodRecipe != nil {
            isSavedRecipe = true
            setupFetchRequest()
            return
        }
        if let ingredients = recipe.ingredients {
            self.ingredientsArray = ingredients
        }
        getFavorites()
        favoriteAction()
    }

    private func getFavorites() {
        let fetchRequest: NSFetchRequest<FoodRecipe> = FoodRecipe.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.sortDescriptors = []
        if let result = try? appDelegate.persistentContainer.viewContext.fetch(fetchRequest) {
            favoriteRecipes = result
        }
    }

    private func setupFetchRequest() {
        let fetchRequest: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "foodRecipe == %@", foodRecipe)
        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = predicate
        if let result = try? appDelegate.persistentContainer.viewContext.fetch(fetchRequest) {
            ingredients = result
            tableView.reloadData()
        }
    }

    func favoriteAction() {
        for fav in favoriteRecipes {
            if fav.title == recipe.title {
                isFav = true
            }
        }
        if isFav {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorited", style: .plain, target: self, action: #selector(self.unfavorite(_:)))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(self.favorite(_:)))
        }
    }

    @objc func favorite(_ sender: UITapGestureRecognizer) {
        isFav = true
        navigationItem.rightBarButtonItem?.title = "Favorited"
        saveAction()
        navigationItem.rightBarButtonItem?.action = #selector(self.unfavorite(_:))
    }

    @objc func unfavorite(_ sender: UITapGestureRecognizer) {
        isFav = false
        navigationItem.rightBarButtonItem?.title = "Favorite"
        getFavorites()
        for fav in favoriteRecipes {
            if fav.title == recipe.title {
                self.appDelegate.persistentContainer.viewContext.delete(fav)
                try? self.appDelegate.persistentContainer.viewContext.save()
                self.favoriteRecipes.remove(at: favoriteRecipes.firstIndex(of: fav)!)
            }
        }
        navigationItem.rightBarButtonItem?.action = #selector(self.favorite(_:))
    }

    //MARK: - Setup View
    override func loadView() {
        super.loadView()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = ThemeColors.colorLightOrange.associatedColor
        setupAddToDiaryButton()
        setupInstructionButton()
        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: instructionsButton.topAnchor, constant: 0).isActive = true
        tableView.backgroundColor = ThemeColors.colorLightOrange.associatedColor
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.separatorColor = ThemeColors.colorLightGreen.associatedColor
    }

    private func setupInstructionButton() {
        view.addSubview(instructionsButton)
        instructionsButton.translatesAutoresizingMaskIntoConstraints = false
        instructionsButton.trailingAnchor.constraint(equalTo: addToDiaryButton.trailingAnchor, constant: -54).isActive = true
        instructionsButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        instructionsButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -4).isActive = true
        instructionsButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        instructionsButton.layer.cornerRadius = 11
        instructionsButton.layer.borderWidth = 0.3
        instructionsButton.setTitle("Instructions", for: .normal)
        instructionsButton.setTitleColor(.black, for: .normal)
        instructionsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.5)
        instructionsButton.backgroundColor = ThemeColors.colorLightOrange.associatedColor
        instructionsButton.addTarget(self, action: #selector(showInstructionsAction), for: .touchUpInside)
    }

    private func setupAddToDiaryButton() {
        view.addSubview(addToDiaryButton)
        addToDiaryButton.translatesAutoresizingMaskIntoConstraints = false
        addToDiaryButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        addToDiaryButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -4).isActive = true
        addToDiaryButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        addToDiaryButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addToDiaryButton.layer.cornerRadius = 11
        addToDiaryButton.layer.borderWidth = 0.3
        addToDiaryButton.setTitle("➕", for: .normal)
        addToDiaryButton.setTitleColor(.white, for: .normal)
        addToDiaryButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.5)
        addToDiaryButton.backgroundColor = ThemeColors.colorLightOrange.associatedColor
        addToDiaryButton.addTarget(self, action: #selector(addToDiaryAction), for: .touchUpInside)
    }

    @objc func saveAction() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let imageData = image.pngData()
        let foodRecipe = FoodRecipe(context: appDelegate.persistentContainer.viewContext)
        foodRecipe.title = recipe.title
        foodRecipe.sourceURL = recipe.sourceURL
        foodRecipe.timeRequired = Int64(recipe.timeRequired!)
        foodRecipe.calories = Int64(recipe.calories!)
        foodRecipe.carbs = Int64(recipe.carbs!)
        foodRecipe.fats = Int64(recipe.fat!)
        foodRecipe.proteins = Int64(recipe.protein!)
        foodRecipe.image = imageData

        if ingredientsArray.count != 0 {
            for ingredientString in ingredientsArray {
                let ingredient = Ingredient(context: appDelegate.persistentContainer.viewContext)
                ingredient.ingredient = ingredientString
                ingredient.foodRecipe = foodRecipe
            }
        } else {
            foodRecipe.ingredients = []
        }

        if let instructions = recipe.instructions {
            if instructions.count != 0 {
                var count = 1
                for instructionString in instructions {
                    let instruction = Instruction(context: appDelegate.persistentContainer.viewContext)
                    instruction.instruction = instructionString
                    instruction.foodRecipe = foodRecipe
                    instruction.stepNumber = Int64(count)
                    count += 1
                }
            } else {
                foodRecipe.instructions = []
            }
        }
        do {
            try appDelegate.persistentContainer.viewContext.save()
            presentAlert(title: "Recipe Favorited 🤩", message: "")
        } catch {
            presentAlert(title: "Unable to Save the Recipe", message: "")
        }
    }

    func fitTheFood(recipeTarget: FoodRecipe) -> FoodStruct {
        let food = FoodStruct(label: recipeTarget.title, calorie: Float(recipeTarget.calories), image: UIImage(data: foodRecipe.image!), carbs: Float(recipeTarget.carbs), fat: Float(recipeTarget.fats), protein: Float(recipeTarget.proteins), wholeGram: 0.0, measureLabel: "")
        return food
    }

    @objc func addToDiaryAction() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FoodDetailVC") as! FoodDetailVC
        nextViewController.isRecipe = true
        if !isSavedRecipe {
            nextViewController.food = FoodStruct(label: recipe.title, calorie: Float(recipe.calories!), image: image, carbs: Float(recipe.carbs!), fat: Float(recipe.fat!), protein: Float(recipe.protein!), wholeGram: 1.0, measureLabel: "")
        } else {
            nextViewController.food = fitTheFood(recipeTarget: foodRecipe)
        }
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    @objc func showInstructionsAction() {
        if isSavedRecipe {
            if foodRecipe.instructions?.count == 0 {
                if let url = URL(string: foodRecipe.sourceURL ?? "") {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        self.presentAlert(title: "Instructions Unavailable", message: "")
                    }
                } else {
                    self.presentAlert(title: "Instructions Unavailable", message: "")
                }
            } else {
                let instructionsVC = InstructionsViewController()
                instructionsVC.foodRecipe = foodRecipe
                self.navigationController?.pushViewController(instructionsVC, animated: true)
            }
            return
        }
        if let instructions = recipe.instructions {
            if instructions.count == 0 {
                if let url = URL(string: recipe.sourceURL ?? "") {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        self.presentAlert(title: "Instructions Unavailable", message: "")
                    }
                } else {
                    self.presentAlert(title: "Instructions Unavailable", message: "")
                }
            } else {
                let instructionsVC = InstructionsViewController()
                instructionsVC.recipe = recipe
                self.navigationController?.pushViewController(instructionsVC, animated: true)
            }
        } else {
            presentAlert(title: "Instructions Unavailable", message: "")
        }
    }

    private func createHeaderView() -> CustomHeaderCell {
        let headerView = CustomHeaderCell()
        if isSavedRecipe == false {
            if let title = recipe.title {
                headerView.recipeTitleLabel.text = title
            }
            if let calorie = recipe.calories, let carbs = recipe.carbs, let protein = recipe.protein, let fat = recipe.fat {
                let calInt = Int(calorie.rounded())
                let carbInt = Int(carbs.rounded())
                let protInt = Int(protein.rounded())
                let fatInt = Int(fat.rounded())
                headerView.timingLabel.text = "🔥\(calInt)kcal   🥖Carbs: \(carbInt)g   🥩Protein: \(protInt)g   🧈Fat: \(fatInt)g"
            }
            if let imageURL = recipe.imageURL {
                SpoonacularClient.downloadRecipeImage(imageURL: imageURL) { (image, success) in
                    if success {
                        if let image = image {
                            self.image = image
                        } else {
                            self.image = UIImage(named: "imagePlaceholder")!
                        }
                        headerView.imageView.image = image
                    } else {
                        headerView.imageView.image = UIImage(named: "imagePlaceholder")
                        self.presentAlert(title: "Image not available", message: "")
                    }
                }
            }
            headerView.ingredientsLabel.text = "  Ingredients (\(ingredientsArray.count) items)"
        } else {
            headerView.recipeTitleLabel.text = foodRecipe.title
            let calorie = foodRecipe.calories
            let carbs = foodRecipe.carbs
            let protein = foodRecipe.proteins
            let fat = foodRecipe.fats
            headerView.timingLabel.text = "  🔥\(calorie)kcal   🥖Carbs: \(carbs)g   🥩Protein: \(protein)g   🧈Fat: \(fat)g"
            headerView.imageView.image = UIImage(data: foodRecipe.image!)
            headerView.ingredientsLabel.text = "  Ingredients (\(foodRecipe.ingredients!.count) items)"
        }
        return headerView
    }
}

//MARK: - Setup TableView
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.frame.width
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = createHeaderView()
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSavedRecipe == false {
            return ingredientsArray.count
        } else {
            return ingredients.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.contentView.backgroundColor = ThemeColors.colorLightOrange.associatedColor
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont(name: "Verdana", size: 16)
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        if isSavedRecipe == false {
            let ingredient = ingredientsArray[indexPath.row]
            cell.textLabel?.text = "\(indexPath.row + 1). \(ingredient)"
        } else {
            cell.textLabel?.text = "\(indexPath.row + 1). \(ingredients[indexPath.row].ingredient!)"
        }
        return cell
    }
}
