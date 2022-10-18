//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Meric on 27.09.2022.
//

import UIKit


class userModal {
    
    var settings: String?
    var settingsIcon: UIImage?
    
    init(settings: String, settingsIcon: UIImage) {
        self.settings = settings
        self.settingsIcon = settingsIcon
    }
}


class userProfileImage {
    var image: UIImage?
    
    init(image: UIImage ) {
        self.image = image
    }
}


class ProfileViewController: UIViewController {

    var settingsArr = [userModal]()
    

    
    private var tableView :UITableView = {
        let tableView = UITableView()
       // tableView.backgroundColor = UIColor.red
        
        return tableView
    }()
    
    private let downloadButton: UIButton = {
        
        let button = UIButton(frame: CGRect(x: 110, y: 250, width: 190, height: 52))
        
        button.setTitle("Add Profile +", for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        view.addSubview(downloadButton)
        settingsArr.append(userModal(settings: "Watchlist", settingsIcon: UIImage(systemName: "chevron.right")!))
        settingsArr.append(userModal(settings: "App Settings", settingsIcon: UIImage(systemName: "chevron.right")!))
        settingsArr.append(userModal(settings: "Account", settingsIcon: UIImage(systemName: "chevron.right")!))
        settingsArr.append(userModal(settings: "Help", settingsIcon: UIImage(systemName: "chevron.right")!))
        settingsArr.append(userModal(settings: "Log Out", settingsIcon: UIImage(systemName: "chevron.right")!))
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            presentationController.prefersGrabberVisible = true
        }
    }
       
    @objc private func selectButtonTapped(_ sender: UIButton) {
        showMyViewControllerInACustomizedSheet()
    }

    func showMyViewControllerInACustomizedSheet() {
        let viewControllerToPresent = editprofile()
        if let sheet = viewControllerToPresent.sheetPresentationController {
//            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func setup () {
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
 
        view.addSubview(tableView)
        tableView.separatorColor = UIColor.white
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
 
        tableView.tableHeaderView = ProfileHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 220))
        
    }
 
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { fatalError("") }
        cell.settingsImage.image = settingsArr[indexPath.row].settingsIcon
        cell.settingsLabel.text = settingsArr[indexPath.row].settings
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    
}

//
//  CustomTableViewCell.swift
//  UIViewTraining
//
//  Created by Meric on 27.09.2022.
//

 

class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomTableViewCell"
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x:0, y: 6, width:UIScreen.main.bounds.width   , height: 50))
        
        view.layer.cornerRadius = 10
        
        view.clipsToBounds = true
        return view
    }()
    
    lazy var settingsLabel: UILabel = {
        let settingsLabel = UILabel(frame: CGRect(x: 20, y: 22, width: 100, height: 30))
        settingsLabel.textAlignment = .left
        settingsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        return settingsLabel
        
    }()
    
    lazy var settingsImage: UIImageView = {
        let settingsIcon = UIImageView(frame: CGRect(x: 360, y: 30, width: 11, height: 16))
        settingsIcon.contentMode = .scaleAspectFill
        settingsIcon.tintColor = .white
        return settingsIcon
        
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:   reuseIdentifier)
        contentView.addSubview(backView)
        contentView.addSubview(settingsLabel)
        contentView.addSubview(settingsImage)
       // contentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // backView.frame = contentView.bounds
        
    }
     

}
