//
//  ViewController.swift
//  PocViewCode
//
//  Created by Felipe Assis on 02/12/23.
//

import UIKit




class CharacterListViewController: UIViewController {
    
    private let viewModel: CharacterListViewModel
    private let refreshControll = UIRefreshControl()
    
    var characterList : [CharacterModel]?
    
    init(_ viewModel:CharacterListViewModel = CharacterListViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(listView)
        listView.addSubview(loading)
        customRefreshIndicator()
        setupConstraints()
        loadCharacters()
        setupSearch()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loading.centerXAnchor.constraint(equalTo: listView.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: listView.centerYAnchor),
        ])
    }
    

    func customRefreshIndicator() {
        refreshControll.tintColor = .purple
        refreshControll.attributedTitle = NSAttributedString(string: "Reloading characters")
    }
    
    @objc private func reloadButton() {
        handleRefreshControl()
    }
    
    @objc func handleRefreshControl() {
        refreshControll.beginRefreshing()
        self.viewModel.fetchCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characterList = characters
                self?.listView.reloadData();
                self?.refreshControll.endRefreshing()
                break
            case .failure(let error):
                print(error)
                self?.refreshControll.endRefreshing()
                break
            }
        }
    }
    
    func loadCharacters(){
        loading.startAnimating()
        self.viewModel.fetchCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characterList = characters
                self?.listView.reloadData();
                break
            case .failure(let error):
                print("ERROR: \(error)")
                self?.listView.reloadData();
                break
            }
        }
        loading.stopAnimating()
    }
    
    func loadCharactersByName(name: String) {
        loading.startAnimating()
        self.viewModel.fetchCharactersByName(name: name) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characterList = characters
                self?.listView.reloadData();
                break
            case .failure(let error):
                print("HERE: \(error)")
                self?.characterList = []
                self?.listView.reloadData();
                break
            }
        }
        loading.stopAnimating()
    }
    
    // MARK: Components
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "goforward")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(reloadButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var logo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        image.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return image
    }()
    
    private lazy var listView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self,
                           forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.refreshControl = refreshControll
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return tableView
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView(style: .large)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.center = view.center
        progress.hidesWhenStopped = true
        progress.color = .purple
        return progress
    }()
    
    // MARK: Search characters
    private let searchController = UISearchController(searchResultsController: nil)
    private func setupSearch() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = true
        
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = "Search characters"
        self.searchController.searchBar.showsBookmarkButton = true
        self.searchController.searchBar.tintColor = .systemGreen
        self.searchController.searchBar.barTintColor = .systemGreen
                
        self.searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .bookmark, state: .normal)
        self.navigationItem.titleView = logo
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false

    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characterList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier,
                                                       for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        
        let characterIndex = characterList?[indexPath.row]
        cell.loadData(character: characterIndex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterIndex = characterList?[indexPath.row]
        let controller = CharacterDetailsViewController()
        controller.character = characterIndex
        
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    
}

extension CharacterListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else { return }
        loadCharactersByName(name: query)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        loadCharacters()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadCharacters()
    }
}




