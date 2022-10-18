//
//  EditProfileViewController.swift
//  MovieApp
//
//  Created by Meric on 01.10.2022.
//
 
import UIKit

class editprofile: UIViewController {
    
    let sectionTitle: [String] = ["Recommended For You","Hit Movies","CurrentlyPlaying","Upcoming Movies","Top rated"]
    let imagesArray2 = ["starwars1","starwars2","starwars3"]
    let imagesArray = ["panda","penguen","fil"]
    let brandId = "cell"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect(x: 0, y: 56, width: UIScreen.main.bounds.width, height: 923), collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
        
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "asdasd"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EditProfileCollectionViewCell.self, forCellWithReuseIdentifier: EditProfileCollectionViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
 
 }

extension editprofile: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditProfileCollectionViewCell.identifier, for: indexPath) as! EditProfileCollectionViewCell
                cell.images = imagesArray2
                return cell
        }
        titleLabel.text = " Profile Avatar"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditProfileCollectionViewCell.identifier, for: indexPath) as! EditProfileCollectionViewCell
            cell.images = imagesArray
            return cell

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3) + 360 , height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 114, bottom: 10, right: 8)
    }
    
}



