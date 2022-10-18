//
//  MoviePreviewViewController.swift
//  MovieApp
//
//  Created by Meric on 08.10.2022.
//

import UIKit
import WebKit

class MoviePreviewViewController: UIViewController {

    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["DETAIL","SUGGESTED","EPISODES"])
            interfaceSegmented.selectorViewColor = .wetAsphalt
            interfaceSegmented.selectorTextColor = .wetAsphalt
        }
    }
    
    
    private var categoryView: UIView = {
        let view = UIView(frame: CGRect(x:0, y: 6, width:UIScreen.main.bounds.width   , height: 50))
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .green
        return view
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "harry potter"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This is the best movie ever to watch as kid!"
        return label
    }()
    
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.imageView?.tintColor = .black
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 9
        button.layer.masksToBounds = true
        return button
    }()
    
    private let watchListLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = .systemFont(ofSize: 12, weight: .bold)
       label.tintColor = .white
       label.text = "Watchlist"
       return label
   }()
    
    private let watchListButton: UIButton =   {
        let button = UIButton()
        let imageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        var image = imageView.image
        image = UIImage(systemName: "plus")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(image, for: .normal)
       // button.setTitle("Watchlist", for: .normal)
       // button.imageView?.tintColor = .gray
        button.layer.masksToBounds = true
        
        return button
        
    }()
    
    private let GroupWatchLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = .systemFont(ofSize: 12, weight: .bold)
       label.tintColor = .white
       label.text = "GroupWatch"
       return label
   }()
    
    private let GroupWatchButton: UIButton =   {
        let button = UIButton()
        let imageView = UIImageView(frame: CGRectMake(0, 0, 33, 33))
        var image = imageView.image
        image = UIImage(named: "group")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(image, for: .normal)
       // button.setTitle("Watchlist", for: .normal)
       // button.imageView?.tintColor = .gray
        button.layer.masksToBounds = true
        
        return button
        
    }()
    
    
    private let webView: WKWebView =  {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
        
    }()
    
    
    private let scroolView: UIScrollView = {
       
        let scroolView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 800))
     
        return scroolView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scroolView)
  
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 600, width: self.view.frame.width, height: 50), buttonTitle: ["DETAIL","EPISODES","SUGGESTED"])
        codeSegmented.backgroundColor = .clear
     
        scroolView.addSubview(webView)
        scroolView.addSubview(titleLabel)
        scroolView.addSubview(overviewLabel)
        scroolView.addSubview(downloadButton)
        scroolView.addSubview(watchListButton)
        scroolView.addSubview(watchListLabel)
        scroolView.addSubview(GroupWatchLabel)
        scroolView.addSubview(GroupWatchButton)
        scroolView.addSubview(codeSegmented)
      
        configureConstraints()
        
        
    }
    
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scroolView.frame = view.bounds
        scroolView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: self.view.bounds.height * 1.5)
       
    }
    
    func configureConstraints()  {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: scroolView.topAnchor,constant: 5),
            webView.leadingAnchor.constraint(equalTo: scroolView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: scroolView.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300),
            webView.widthAnchor.constraint(equalToConstant: 380)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: scroolView.leadingAnchor, constant: 20)
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: scroolView.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: scroolView.trailingAnchor)
            
        ]
        
        let downloadButtonConstraints =  [
            downloadButton.centerXAnchor.constraint(equalTo: scroolView.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor,constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 360),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let WatchlistConstraints =  [
            watchListButton.centerXAnchor.constraint(equalTo: scroolView.centerXAnchor,constant: -50),
            watchListButton.topAnchor.constraint(equalTo: downloadButton.bottomAnchor,constant: 25),
            watchListButton.widthAnchor.constraint(equalToConstant: 200),
            watchListButton.heightAnchor.constraint(equalToConstant: 40),
        ]
        
        let WatchListLabelConstraints = [
            watchListLabel.centerXAnchor.constraint(equalTo: scroolView.centerXAnchor,constant: -50),
            watchListLabel.topAnchor.constraint(equalTo: watchListButton.topAnchor,constant: 25),
            watchListLabel.widthAnchor.constraint(equalToConstant: 60),
            watchListLabel.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let GroupWatchButtonConstraints =  [
            GroupWatchButton.centerXAnchor.constraint(equalTo: scroolView.centerXAnchor,constant: 45),
            GroupWatchButton.topAnchor.constraint(equalTo: downloadButton.bottomAnchor,constant: 25),
            GroupWatchButton.widthAnchor.constraint(equalToConstant: 35),
            GroupWatchButton.heightAnchor.constraint(equalToConstant: 38),
        ]
        
        let GroupWatchLabelConstraints = [
            GroupWatchLabel.centerXAnchor.constraint(equalTo: scroolView.centerXAnchor,constant: 86),
            GroupWatchLabel.topAnchor.constraint(equalTo: GroupWatchButton.topAnchor,constant: 25),
            GroupWatchLabel.widthAnchor.constraint(equalToConstant: 150),
            GroupWatchLabel.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        NSLayoutConstraint.activate(WatchlistConstraints)
        NSLayoutConstraint.activate(WatchListLabelConstraints)
        NSLayoutConstraint.activate(GroupWatchLabelConstraints)
        NSLayoutConstraint.activate(GroupWatchButtonConstraints)

        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
    }
 
    
    func configure(with model: MoviePreviewViewModel)  {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOver
         
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else { return }
        
        webView.load(URLRequest(url: url))
        
    }

  

}
