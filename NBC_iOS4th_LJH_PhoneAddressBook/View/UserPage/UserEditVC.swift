//
//  UserEditVC.swift
//  NBC_iOS4th_LJH_PhoneAddressBook
//
//  Created by Lee-Juhee on 7/16/24.
//

import UIKit
import SnapKit

class UserEditVC: UIViewController {
    
    weak var delegate: UserEditDelegate?
    var user: Contact?

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

        if let user = user {
            userProfileImage.image = UIImage(data: user.userImage!)
            nameTextView.text = user.userName
            numTextView.text = user.userNum
        }

        // Set delegate for nameTextView
        nameTextView.delegate = self

        // Initial title setup
        updateTitle()
    }

    private func UserNaviBarSetup() {
        let okBtn = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(saveBtnTapped))
        self.navigationItem.rightBarButtonItem = okBtn
        // Title will be set dynamically based on textView content
    }

    private func UserSetupConstraints() {
        userProfileImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(160)
        }
        randomImageBtn.snp.makeConstraints {
            $0.top.equalTo(userProfileImage.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        nameTextView.snp.makeConstraints {
            $0.top.equalTo(randomImageBtn.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        numTextView.snp.makeConstraints {
            $0.top.equalTo(nameTextView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
    }

    @objc private func saveBtnTapped() {
        guard let userName = nameTextView.text,
              let userNum = numTextView.text,
              let userImage = userProfileImage.image,
              let imageData = userImage.pngData()
        else {
            return
        }
        if let user = user {
            // 기존 사용자 데이터 업데이트
            user.userName = userName
            user.userNum = userNum
            user.userImage = imageData

            do {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                try context.save()
                print("User data updated successfully")
            } catch {
                print("Failed to update user data: \(error.localizedDescription)")
            }
        } else {
            // 새 사용자 데이터 저장
            DataManager.shared.saveUserData(userName: userName, userNum: userNum, userImage: imageData)
        }

        delegate?.didSaveUserData()
        navigationController?.popViewController(animated: true)
    }
    // 랜덤 이미지 버튼 클릭 시 호출되는 메서드
    @objc func randomImageBtntapped() {
        ramdomPokemonImage { [weak self] image in
            DispatchQueue.main.async {
                self?.userProfileImage.image = image
            }
        }
    }
    // 텍스트 뷰 변경 시 타이틀 업데이트
    private func updateTitle() {
        self.title = nameTextView.text.isEmpty ? "연락처 추가" : nameTextView.text
    }
}

// UITextViewDelegate 프로토콜 구현
extension UserEditVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == nameTextView {
            updateTitle()
        }
    }
}
