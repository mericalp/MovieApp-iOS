//
//  DownloadViewController.swift
//  MovieApp
//
//  Created by Meric on 27.09.2022.
//

import UIKit

class DownloadViewController: UIViewController {

    private var movie: [MoviesItem] = [MoviesItem]()

    private let downloadedTable: UITableView = {
        let table = UITableView()
        table.register(SearchFindTableViewCell.self, forCellReuseIdentifier: SearchFindTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(downloadedTable)
        setup()
    }
        
    func setup()  {
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
        fetchLocalStorageForDownload()
        //
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
    }
    
    private func fetchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchingTitlesFromDataBase { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movie = movies
                DispatchQueue.main.async {
                    self?.downloadedTable.reloadData()
                 }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedTable.frame = view.bounds
    }
}

extension DownloadViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchFindTableViewCell.identifier, for: indexPath) as? SearchFindTableViewCell else {
            return UITableViewCell()
        }
        let movies = movie[indexPath.row]
        cell.configure(with: MovieViewModel(titleName: (movies.original_title ?? movies.original_name) ?? "Unknown title name", posterURL: movies.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteTitleWith(model: movie[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("deleted From the database")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.movie.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movies = movie[indexPath.row]
        guard let movieName = movies.original_title ?? movies.original_name else {
            return
        }
        APICaller.shared.getYoutubeVideos(with: movieName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = MoviePreviewViewController()
                    vc.configure(with: MoviePreviewViewModel(title: movieName, youtubeView: videoElement, titleOver: movies.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
             case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
