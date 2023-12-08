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
        setupTopBar()
    }
    
    func setupTopBar() {
        self.navigationItem.titleView = logo
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "goforward"), target: self, action: #selector(onTapBack))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "goforward")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(reloadButton), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func reloadButton() {
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

    private lazy var logo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleToFill
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.widthAnchor.constraint(equalToConstant: 200).isActive = true
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterIndex = characterList?[indexPath.row]
        let controller = CharacterDetailsViewController()
        controller.character = characterIndex
    
        self.navigationController?.pushViewController(controller, animated: false)
    }
}

