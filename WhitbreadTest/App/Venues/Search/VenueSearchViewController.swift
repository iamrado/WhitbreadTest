//
//  VenueSearchViewController.swift
//  WhitbreadTest
//
//  Created by Radoslav Blasko on 18/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

class VenueSearchViewController: UIViewController {
    var api: FoursquareAPI!

    private var model: VenueSearchModel!
    private var keyboardOffsetHandler: KeyboardOffsetHandler!

    @IBOutlet weak var tableView: UITableView!

    static func instantiate(api: FoursquareAPI) -> VenueSearchViewController {
        let viewController: VenueSearchViewController = instantiate()
        viewController.api = api
        viewController.model = VenueSearchModel(api: api)

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
        bindSearchModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardOffsetHandler.enabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardOffsetHandler.enabled = false
    }

    private func setupTableView() {
        tableView.registerCell(cell: VenueSearchTableViewCell.self)
        tableView.dataSource = self

        keyboardOffsetHandler = KeyboardOffsetHandler(rootView: view, scrollView: tableView)
    }

    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    private func bindSearchModel() {
        model.onSearchFinished = { [weak self] result in
            self?.tableView.reloadData()
        }
    }
}

extension VenueSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VenueSearchTableViewCell.reuseIdentifier) as! VenueSearchTableViewCell

        let item = model.items[indexPath.row]
        cell.configure(name: item.name, address: item.location.address ?? "")

        return cell
    }
}

extension VenueSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        model.searchTerm = searchBar.text
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        model.searchTerm = nil
    }
}
