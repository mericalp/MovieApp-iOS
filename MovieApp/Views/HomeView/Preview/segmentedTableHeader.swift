//
//  tableheader.swift
//  Disney++ CloneApp
//
//  Created by Meric on 10.10.2022.
//

import Foundation
import UIKit


class segmentedTableHeader: UIView {
    
    let label1: UIButton =  {
        let label1 = UIButton(frame: CGRect(x: 15, y: 0, width: 130, height: 25))
         label1.setTitle("  Season 1", for: .normal)
        label1.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        label1.backgroundColor = UIColor(red: 48/255, green: 51/255, blue: 64/255, alpha: 250/255)
        label1.frame = CGRect(x: 15, y: 0, width: 130, height: 25)
        label1.titleLabel?.font = .systemFont(ofSize: 13)
        label1.imageView?.tintColor = .white
        label1.layer.cornerRadius = 25
        return label1
    }()
    
    let label2: UIButton =  {
        let label2 = UIButton(frame: CGRect(x: 0, y: 0, width: 130, height: 25))
        label2.setTitle("  Season", for: .normal)
        label2.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        label2.titleLabel?.font = .systemFont(ofSize: 13)
        label2.imageView?.tintColor = .white
        label2.layer.cornerRadius = 35
        return label2
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
  
        let stackView = UIStackView(arrangedSubviews: [label1,label2])
        stackView.frame = CGRect(x: 6, y: 0, width: 380, height: 50)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 137
        label1.frame = CGRect(x: 0, y: 0, width: 120, height: 20)
        addSubview(stackView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  
    
}
