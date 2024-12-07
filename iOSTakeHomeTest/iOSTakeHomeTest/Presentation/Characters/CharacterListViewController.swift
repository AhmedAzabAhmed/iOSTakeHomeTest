//
//  CharacterListViewController.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import UIKit
import Combine
import SwiftUI

class CharacterListViewController: UITableViewController {
    
    private var characters: [CharacterVM] = []
    private let viewModel = CharacterListViewModel(useCase: CharacterUseCase(repository: CharacterRepositoryImplementation()))
    private var cancellable: Set<AnyCancellable> = []
    
    private var loadingIndicator: UIActivityIndicatorView!
    private var selectedButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindObservers()
        viewModel.fetchCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupUI() {
        let headerView = createFilterHeaderView()
        tableView.tableHeaderView = headerView
        
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        navigationItem.title = "Characters"
        
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func createFilterHeaderView() -> UIView {
        let filters = StatusFilter.allCases
        let buttons: [UIButton] = filters.map { filter in
            let button = UIButton(type: .system)
            
            var config = UIButton.Configuration.plain()
            config.title = filter.rawValue
            config.titleAlignment = .center
            config.baseForegroundColor = .black
            config.baseBackgroundColor = .clear
            config.cornerStyle = .capsule
            config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
            
            button.configuration = config
            
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 12
            
            button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
            
            return button
        }

        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 12

        stackView.translatesAutoresizingMaskIntoConstraints = false

        let containerView = UIView()
        containerView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])

        let headerHeight: CGFloat = 50
        containerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: headerHeight)

        return containerView
    }

    @objc private func filterButtonTapped(_ sender: UIButton) {
        guard let title = sender.configuration?.title,
              let filter = StatusFilter(rawValue: title) else { return }
        selectedButton?.backgroundColor = .clear
        selectedButton?.configuration?.baseForegroundColor = .black

        sender.backgroundColor = .blue
        sender.configuration?.baseForegroundColor = .white
        selectedButton = sender
        viewModel.setStatus(filter.rawValue.lowercased())
        viewModel.fetchCharacters()
    }
    
    private func bindObservers() {
        viewModel.charactersSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .loading:
                    loadingIndicator.startAnimating()
                    tableView.backgroundView = nil
                    
                case .success(let list):
                    characters = list
                    tableView.reloadData()
                    loadingIndicator.stopAnimating()
                    if characters.isEmpty {
                        tableView.backgroundView = createEmptyView()
                    } else {
                        tableView.backgroundView = nil
                    }
                    
                case .failure(_):
                    loadingIndicator.stopAnimating()
                    characters.removeAll()
                    tableView.reloadData()
                    tableView.backgroundView = createEmptyView()
                }
            }.store(in: &cancellable)
        
        viewModel.moreCharactersSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .loading:
                    break
                case .success(let list):
                    characters = list
                    tableView.reloadData()
                    
                case .failure(_):
                    break
                }
            }.store(in: &cancellable)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
        let character = characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == characters.count - 1 {
            viewModel.loadMoreCharacters()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = characters[indexPath.row]
        let detailView = CharacterDetailView(character: selectedCharacter)
        let hostingController = UIHostingController(rootView: detailView)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}

// MARK: - Empty View
extension CharacterListViewController {
    func createEmptyView() -> UIView {
        let emptyView = UIView()
        
        let label = UILabel()
        label.text = "No characters available"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .center
        
        emptyView.addSubview(label)
        
        // Set label's constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)
        ])
        
        return emptyView
    }

}
