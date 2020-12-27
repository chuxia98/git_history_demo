//
//  HistoryViewController.swift
//  GitHistory
//
//  Created by chenyh on 2020/12/27.
//

import UIKit
import MJRefresh

class HistoryViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(CXTableViewCell.self, forCellReuseIdentifier: CXTableViewCell.cellID)
        return tableView
    }()
    
    private lazy var items: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History"

        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setupRefresh()
    }
    
    private func setupRefresh() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        tableView.mj_header?.beginRefreshing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.map = items[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: CXTableViewCell.cellID, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.green.withAlphaComponent(0.3): UIColor.red.withAlphaComponent(0.3)
        let data = items[indexPath.row]
        cell.textLabel?.text = data["time"] ?? ""
    }
}


extension HistoryViewController {
    @objc func loadNewData() {
        items = Cache.shared.queryList()
        tableView.reloadData()
        tableView.mj_header?.endRefreshing()
    }
}
