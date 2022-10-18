//
//  ProfileHeaderUIView.swift
//  MovieApp
//
//  Created by Meric on 01.10.2022.
//
 
import UIKit

class ProfileHeaderUIView: UIView {

    var userProfileArr = [userProfileImage]()

    
    private let headerCollectionView: UICollectionView = {
   
       let layout = UICollectionViewFlowLayout()
       layout.itemSize = CGSize(width: 85, height: 88)
       layout.scrollDirection = .horizontal
       let headerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       headerCollectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.identifier)
       return headerCollectionView
    }()
    
//    private let downloadButton: UIButton = {
//        let button = UIButton(frame: CGRect(x: 110, y: 140, width: 190, height: 52))
//        button.setTitle("Edit Profiles", for: .normal)
//        button.backgroundColor = .gray
//        button.layer.cornerRadius = 3
//        return button
//
//    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerCollectionView)
//        addSubview(downloadButton)
        userProfileArr.append(userProfileImage(image:UIImage(named: "micky")! ))
     
        
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        
      
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerCollectionView.frame = CGRect(x:160, y: 0, width: 400, height: 88)
    }
    
 
    
}

extension ProfileHeaderUIView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: Collection
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.identifier, for: indexPath) as? HeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.profileImage.image = userProfileArr[indexPath.row].image
        return cell
    }

    
}



class HeaderCollectionViewCell: UICollectionViewCell {

    static let identifier = "HeaderCollectionViewCell"
 
    lazy var profileImage: UIImageView = {
        let profileImage = UIImageView(frame: CGRect(x: 10, y: 0, width: 33, height: 33))
        profileImage.layer.cornerRadius = 44
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.tintColor = .white
        return profileImage
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(profileImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.frame = contentView.bounds
    }
    
    
    
    
}




