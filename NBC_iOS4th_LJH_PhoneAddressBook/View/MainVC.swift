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

class MainVC: UIViewController {
    //네비게이션 바 생성
    let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        return navigationBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.view.addSubview(navigationBar)

        navigationBarSetup()
        setupConstraints()

    }

    private func navigationBarSetup() {
        let navigationItem = UINavigationItem(title: "친구 목록")
        let addBtn = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addBtnTapped))

        navigationItem.setRightBarButtonItems([addBtn], animated: true)
        navigationBar.setItems([navigationItem], animated: false)
    }

    private func setupConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }

    // addBtnTapped 메서드 생성
    @objc func addBtnTapped() {

    }
}
