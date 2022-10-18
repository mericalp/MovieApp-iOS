//
//  CollectionViewTableViewCell.swift
//  MovieApp
//
//  Created by Meric on 27.09.2022.
//

import UIKit

// MARK: -
protocol HomeCollectionViewTableViewCellDelegate: AnyObject {
    func homeCollectionViewTableViewCellDidTapCell(_ cell: HomeCollectionViewTableViewCell, viewmodel: MoviePreviewViewModel)
}

class HomeCollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    weak var delegate: HomeCollectionViewTableViewCellDelegate?
    private var movie: [Movie] = [Movie]()
    
    // MARK: Poster Image
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MoviePosterCollectionViewCell.self, forCellWithReuseIdentifier: MoviePosterCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with movies: [Movie]) {
        self.movie = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    //
    private func downloadTitleAt(indexPath: IndexPath) {
        DataPersistenceManager.shared.downloadTitleWith(model: movie[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case . failure(let error):
                print(error.localizedDescription)
            }
        }
        print("downloading \(movie[indexPath.row].original_title)")
    }
}

extension HomeCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCollectionViewCell.identifier, for: indexPath) as? MoviePosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = movie[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let poster = movie[indexPath.row]
        guard let posterName = poster.original_title ?? poster.original_name else {
            return
        }
        
        //  API caller  Youtube
        APICaller.shared.getYoutubeVideos(with: posterName + "trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                let title = self?.movie[indexPath.row]
                guard let movieOverview = title?.overview else {
                    return
                }
                guard let strongSelf = self else {
                    return
                }
                let viewModel = MoviePreviewViewModel(title: posterName, youtubeView: videoElement, titleOver: movieOverview)
                self?.delegate?.homeCollectionViewTableViewCellDidTapCell(strongSelf, viewmodel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Download Action
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
            let downloadAction = UIAction(title: "Download", image: nil, identifier: nil,  state: .off) { _ in
                self?.downloadTitleAt(indexPath: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction] )
         }
        return config
    }
    
}
