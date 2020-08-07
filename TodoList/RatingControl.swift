//
//  RatingControl.swift
//  TodoList
//
//  Created by Eddy R on 06/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButton()
  }
  
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
    setupButton()
  }
  
  private func setupButton(){
    let button = UIButton()
    button.backgroundColor = UIColor.red
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
    addArrangedSubview(button)
  }
}
