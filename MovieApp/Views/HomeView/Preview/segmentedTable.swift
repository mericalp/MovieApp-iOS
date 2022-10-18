//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Meric on 10.10.2022.
//

import UIKit
import SkeletonView

class segmentedTable: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "square.and.arrow.down",withConfiguration: UIImage.SymbolConfiguration(pointSize: 22) )
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel2: UIImageView = {
        let label = UIImageView()
        label.image = UIImage(named: "13")
      
        label.contentMode = .scaleAspectFill
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
     
        return label
    }()
    
    private let titleLabel3: UILabel = {
        let label = UILabel()
        label.text = "..hour"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let titlePosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightText
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterUIImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        contentView.addSubview(titleLabel2)
        contentView.addSubview(titleLabel3)
    

        applyConstraint()
        
        self.titlePosterUIImageView.isSkeletonable = true
        self.titleLabel2.isSkeletonable = true
        self.titleLabel3.isSkeletonable = true
        
        titleLabel3.showAnimatedSkeleton(usingColor: .lightText)
        titleLabel2.showAnimatedSkeleton(usingColor: .lightText)
        titlePosterUIImageView.showAnimatedSkeleton(usingColor: .lightText)

//
    }
 
    
    private func applyConstraint() {
        let titlePosterUIImageViewConstraint = [
            titlePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlePosterUIImageView.heightAnchor.constraint(equalToConstant: 100),
            titlePosterUIImageView.widthAnchor.constraint(equalToConstant: 160),
          
        ]
        
        let titleLabelConstraint = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -40)
        ]
        
        let titleLabel2Constraint = [
            titleLabel2.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor, constant: 20),
            titleLabel2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -4),
            titleLabel2.heightAnchor.constraint(equalToConstant: 21),
            titleLabel2.widthAnchor.constraint(equalToConstant: 21),
        ]
        let titleLabel3Constraint = [
            titleLabel3.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor, constant: 49),
            titleLabel3.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            titleLabel3.heightAnchor.constraint(equalToConstant: 1),
            titleLabel3.widthAnchor.constraint(equalToConstant: 50),

        ]
        
        
        let playTitleButton = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0)
        ]
   
        NSLayoutConstraint.activate(titlePosterUIImageViewConstraint)
        NSLayoutConstraint.activate(titleLabelConstraint)
        NSLayoutConstraint.activate(playTitleButton)
        NSLayoutConstraint.activate(titleLabel2Constraint)
        NSLayoutConstraint.activate(titleLabel3Constraint)
        
        
        
        
        
    }
    

    
    
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    
}
