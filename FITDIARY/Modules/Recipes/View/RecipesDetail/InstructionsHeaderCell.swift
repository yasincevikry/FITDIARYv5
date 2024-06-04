//
//  InstructionsHeaderCell.swift
//  FITDIARY
//

import UIKit

class InstructionsHeaderCell: UIView {
    
    //MARK: - Setup UI Items
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = ThemeColors.colorLightOrange.associatedColor
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ThemeColors.colorLightOrange.associatedColor
        addSubview(ingredientsLabel)
        setupView()
    }
    
    //MARK: - Setup SubView Constraints
    private func setupView() {
        setupIngredientsLabel()
    }

    private func setupIngredientsLabel() {
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 19).isActive = true
        ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        ingredientsLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        ingredientsLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
