//
//  SearchFindTableViewCell.swift
//  MovieApp
//
//  Created by Meric on 05.10.2022.
//

import UIKit

class SearchFindTableViewCell: UITableViewCell {

    static let identifier = "SearchFindTableViewCell"
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 20) )
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
        label.image = UIImage(named: "18")
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
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let titlePosterUIImageViewConstraint = [
            titlePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlePosterUIImageView.heightAnchor.constraint(equalToConstant: 8),
            titlePosterUIImageView.widthAnchor.constraint(equalToConstant: 180),
        ]
        
        let titleLabelConstraint = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -40)
        ]
        
        let titleLabel2Constraint = [
            titleLabel2.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor, constant: 20),
            titleLabel2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -4),
            titleLabel2.heightAnchor.constraint(equalToConstant: 22),
            titleLabel2.widthAnchor.constraint(equalToConstant: 22),
        ]
        
        let titleLabel3Constraint = [
            titleLabel3.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor, constant: 44),
            titleLabel3.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -2),
        ]
        
        let playTitleButton = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 40)
        ]
   
        NSLayoutConstraint.activate(titlePosterUIImageViewConstraint)
        NSLayoutConstraint.activate(titleLabelConstraint)
        NSLayoutConstraint.activate(playTitleButton)
        NSLayoutConstraint.activate(titleLabel2Constraint)
        NSLayoutConstraint.activate(titleLabel3Constraint)
    }
    
    public func configure(with model: MovieViewModel ) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        titlePosterUIImageView.sd_setImage(with: url,completed: nil)
    }

}
