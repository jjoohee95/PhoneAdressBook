//
//  UserEditVC.swift
//  NBC_iOS4th_LJH_PhoneAddressBook
//
//  Created by Lee-Juhee on 7/16/24.
//
// 네비게이션 바 (뒤로, 타이틀, 적용)
// 프로필 이미지
// 랜덤 이미지 생성 버튼
// 이름 텍스트필드
// 번호 텍스트 필드

import UIKit
import SnapKit

class UserEditVC: UIViewController {

    let userProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 80
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var randomImageBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.addTarget(self, action: #selector(randomImageBtntapped), for: .touchUpInside)
        return button
    }()

    let nameTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        return textView
    }()

    let numTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(userProfileImage)
        view.addSubview(randomImageBtn)
        view.addSubview(nameTextView)
        view.addSubview(numTextView)


        UserNaviBarSetup()
        UserSetupConstraints()
    }

    //navigationBarSetup 설정
    private func UserNaviBarSetup() {
//        let navigationItem = UINavigationItem(title: "친구 목록")
        let okBtn = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(btnTapped))
        self.navigationItem.rightBarButtonItem = okBtn
        self.title = "연락처 추가"
    }
    func UserSetupConstraints() {
        //userProfileImage 제약조건
        userProfileImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(160)
        }
        //randomImageBtn 제약조건
        randomImageBtn.snp.makeConstraints {
            $0.top.equalTo(userProfileImage.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        //nameTextView 제약조건
        nameTextView.snp.makeConstraints {
            $0.top.equalTo(randomImageBtn.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        //numTextView 제약조건
        numTextView.snp.makeConstraints {
            $0.top.equalTo(nameTextView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
    }

    // addBtnTapped 메서드 생성
    @objc func btnTapped() {

    }
    @objc  func backBtnTapped() {

    }

    @objc func randomImageBtntapped(){

    }
}

