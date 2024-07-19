//
//  MainVC.swift
//  NBC_iOS4th_LJH_PhoneAddressBook
//
//  Created by Lee-Juhee on 7/16/24.
//
// 네비게이션바: 친구목록 타이틀, 추가 버틍 생성
// 테이블 뷰: 이미지 이름 번호

import UIKit
import SnapKit

class MainVC: UIViewController, UITableViewDelegate, UserEditDelegate, UITableViewDataSource {

    let mainTableView = MainTableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(mainTableView)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        navigationBarSetup()
        setupConstraints()
    }

    private func navigationBarSetup() {
        let addBtn = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addBtnTapped))
        self.navigationItem.rightBarButtonItem = addBtn
        self.title = "친구 목록"
    }

    private func setupConstraints() {
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    @objc private func addBtnTapped() {
        let userEditVC = UserEditVC()
        userEditVC.delegate = self
        let backBtn = UIBarButtonItem()
        backBtn.title = "Back"
        self.navigationItem.backBarButtonItem = backBtn
        self.navigationController?.pushViewController(userEditVC, animated: true)
    }

    func didSaveUserData() {
        mainTableView.updateUserData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = mainTableView.userData[indexPath.row]
        print("\(user.userName!) 클릭")

        // UserEditVC의 인스턴스가 네비게이션 스택에 있는지 확인합니다.
        if let existingUserEditVC = self.navigationController?.viewControllers.first(where: { $0 is UserEditVC }) as? UserEditVC {
            // 기존 인스턴스를 업데이트합니다.
            existingUserEditVC.user = user
            existingUserEditVC.title = user.userName // 타이틀을 사용자 이름으로 변경

            // 네비게이션 스택에서 해당 뷰 컨트롤러로 이동합니다.
            self.navigationController?.popToViewController(existingUserEditVC, animated: true)
        } else {
            // 기존 인스턴스가 없으면 새로 생성합니다.
            let userEditVC = UserEditVC()
            userEditVC.user = user
            userEditVC.delegate = self
            userEditVC.title = user.userName // 타이틀을 사용자 이름으로 변경

            self.navigationController?.pushViewController(userEditVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTableView.userData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let user = mainTableView.userData[indexPath.row]
        cell.configure(image: UIImage(data: user.userImage!)!, name: user.userName!, phone: user.userNum!)
        return cell
    }
}
