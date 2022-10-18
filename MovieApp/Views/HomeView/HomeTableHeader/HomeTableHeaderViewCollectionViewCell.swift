//
//  HomeTableHeaderCollectionViewCell.swift
//  MovieApp
//
//  Created by Meric on 27.09.2022.
//

import UIKit

class HomeTableHeaderViewCollectionViewCell: UICollectionViewCell {
    
    let imagesArray = ["starwarsPoster","nationalPoster","oldmanPoster","image4","image5"]
    let imagesArray2 = ["disney","national","starwars","marvel","pixar"]
    
    var images: [String]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        collectionView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomePosterCollectionViewCell.self, forCellWithReuseIdentifier: HomePosterCollectionViewCell.identifier)
        collectionView.register(HomeBrandCollectionViewCell.self, forCellWithReuseIdentifier: HomeBrandCollectionViewCell.identifier)

    }
    
}

extension HomeTableHeaderViewCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBrandCollectionViewCell.identifier, for: indexPath) as! HomeBrandCollectionViewCell
            cell.images = imagesArray2
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePosterCollectionViewCell.identifier, for: indexPath) as! HomePosterCollectionViewCell
        cell.images = imagesArray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: frame.height, height: 100)
        }
        return CGSize(width: frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: -5, left: 8, bottom: 10, right: 8)
        }
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
}

