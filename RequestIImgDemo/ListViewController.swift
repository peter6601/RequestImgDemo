//
//  ListViewController.swift
//  RequestIImgDemo
//
//  Created by PeterDing on 2018/3/19.
//  Copyright © 2018年 DinDin. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var mainTableView: UITableView!  {
        didSet {
            mainTableView.dataSource = self
            mainTableView.delegate = self
            mainTableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
            mainTableView.estimatedRowHeight = 300
            mainTableView.rowHeight = 300
        }
    }
    
   fileprivate var photoList: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestAPI()
    }

}


extension ListViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as! ImageTableViewCell
        let photo = photoList[indexPath.row]
            cell.bind(photo: photo )
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension ListViewController {
    
    func requestAPI() {
        APIManager.shared.getSearchRequest(url: TestURL.getSearch.rawValue) { (data, err) in
            guard let photos = data else { return }
            
            DispatchQueue.main.async {[weak self] in
                self?.photoList = photos
                self?.mainTableView.reloadData()
            }
        }
    }
}



