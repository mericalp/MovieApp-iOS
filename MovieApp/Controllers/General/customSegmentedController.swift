//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Meric on 10.10.2022.
//


import UIKit
import SkeletonView

protocol CustomSegmentedControlDelegate: AnyObject {
    func change(to index:Int)
}

class CustomSegmentedControl: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect(x: 0, y: 56, width: UIScreen.main.bounds.width, height: 923), collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
        
    }()
    let brandId = "brandId"

    private var categoryView: UIView = {
        let view = UIView(frame: CGRect(x:0, y: 56, width:UIScreen.main.bounds.width   , height: 50))
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .green
        return view
    }()
    
    private let downloadedTable: UITableView = {
        let table = UITableView(frame: CGRect(x:0, y: 56, width:UIScreen.main.bounds.width   , height: 923) )
        table.backgroundColor = .systemBackground
        table.register(segmentedTable.self, forCellReuseIdentifier: segmentedTable.identifier)
        return table
    }()
    
    private var buttonTitles:[String]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    
    var textColor:UIColor = .gray
    var selectorViewColor: UIColor = .white
    var selectorTextColor: UIColor = .white
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.tintColor = .red
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This is the best movie ever to watch as kid!"
        return label
    }()
    
    weak var delegate:CustomSegmentedControlDelegate?
    public private(set) var selectedIndex : Int = 1
    
    convenience init(frame:CGRect,buttonTitle:[String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
        addSubview(overviewLabel)
        addSubview(collectionView)
        addSubview(downloadedTable)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(brandcell.self, forCellWithReuseIdentifier: brandId)
      
        downloadedTable.frame = CGRect(x:0, y: 60, width:UIScreen.main.bounds.width   , height: 550)
        let headerView = segmentedTableHeader(frame: CGRect(x: 0, y: -30, width:  bounds.width, height: 50))
        downloadedTable.tableHeaderView = headerView
      
        downloadedTable.dataSource = self
        downloadedTable.delegate = self
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -315),
            overviewLabel.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: 120),
            overviewLabel.trailingAnchor.constraint(equalTo:  trailingAnchor)
        ]
        let categoryConstraints = [
            downloadedTable.topAnchor.constraint(equalTo: bottomAnchor, constant: -615),
            downloadedTable.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: 120),
            downloadedTable.trailingAnchor.constraint(equalTo:  trailingAnchor)
        ]
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(categoryConstraints)
        
        self.downloadedTable.reloadData()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
    func setIndex(index:Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == sender {
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                selectedIndex = buttonIndex
                delegate?.change(to: selectedIndex)
                UIView.animate(withDuration: 0.3) {

                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        switch selectedIndex {
        case 0:
            backgroundColor = .systemBackground
        case 1:
            addSubview(collectionView)
        case 2:
            addSubview(downloadedTable)
        default:
           print("")
        }
    }
}

//Configuration View
extension CustomSegmentedControl {
    
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action:#selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
            
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
    
}


extension CustomSegmentedControl: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let xx = collectionView.dequeueReusableCell(withReuseIdentifier: brandId, for: indexPath) as! brandcell
           return xx
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (frame.width / 3) + 40 , height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
}

class brandcell: UICollectionViewCell {
    
      override init(frame: CGRect) {
        super.init(frame: frame)
          backgroundColor = .systemPink
          isSkeletonable = true
          skeletonCornerRadius = 17
          showAnimatedSkeleton(usingColor: .lightText)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomSegmentedControl: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "Unknown"
//        return cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: segmentedTable.identifier, for: indexPath) as? segmentedTable else {
            return UITableViewCell()
        }
          return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     
    }
    

    
}
