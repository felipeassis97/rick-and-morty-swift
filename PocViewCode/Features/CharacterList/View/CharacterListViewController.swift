//
//  ViewController.swift
//  PocViewCode
//
//  Created by Felipe Assis on 02/12/23.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    private let viewModel: CharacterListViewModel
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
        setupConstraints()
        loadCharacters()
    }
    
    func loadCharacters(){
        self.viewModel.fetchCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characterList = characters
                self?.listView.reloadData();
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private lazy var listView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self,
                           forCellReuseIdentifier: CharacterTableViewCell.identifier)
        return tableView
    }()
    
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private lazy var loading: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView(style: .large)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.hidesWhenStopped = true
        return progress
    }()
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
}

