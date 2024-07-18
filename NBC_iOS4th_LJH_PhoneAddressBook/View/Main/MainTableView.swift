//
//  MainTableView.swift
//  NBC_iOS4th_LJH_PhoneAddressBook
//
//  Created by t2023-m0023 on 7/16/24.
//

import UIKit
import SnapKit

class MainTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    //userData 배열
    var userData: [Contact] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
        updateUserData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //tableView 생성
    private func setupTableView() {
            self.rowHeight = 100
            self.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
            self.delegate = self
            self.dataSource = self
        }
    func updateUserData() {
           userData = DataManager.shared.readAllData()
           reloadData() // 테이블뷰 리로드
       }

        //tableView 제약조건
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return userData.count
           }

           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
               let user = userData[indexPath.row]
               cell.configure(image: UIImage(data: user.userImage!)!, name: user.userName!, phone: user.userNum!)
               return cell
           }
       }
