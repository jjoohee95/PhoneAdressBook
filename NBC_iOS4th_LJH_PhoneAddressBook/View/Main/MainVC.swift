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
    //navigationBar 생성
    let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        return navigationBar
    }()

    let mainTableView = MainTableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.view.addSubview(navigationBar)
        self.view.addSubview(mainTableView)


        navigationBarSetup()
        setupConstraints()
       
        mainTableView.userData = [
                   (userImage: UIImage(named: "image")!, userName: "name", userNum: "010-1234-5678"),
                   (userImage: UIImage(named: "image")!, userName: "name", userNum: "010-8765-4321")
               ]
           }

    //navigationBarSetup 설정
    private func navigationBarSetup() {
        let navigationItem = UINavigationItem(title: "친구 목록")
        let addBtn = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addBtnTapped))

        navigationItem.setRightBarButtonItems([addBtn], animated: true)
        navigationBar.setItems([navigationItem], animated: false)
    }

    private func setupConstraints() {
        //navigationBar 제약조건
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        mainTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    // addBtnTapped 메서드 생성
    @objc func addBtnTapped() {

    }
}
