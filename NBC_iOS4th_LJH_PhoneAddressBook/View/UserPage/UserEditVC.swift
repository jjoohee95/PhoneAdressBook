import UIKit
import SnapKit

class UserEditVC: UIViewController {
    weak var delegate: UserEditDelegate?

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

    private func UserNaviBarSetup() {
        let okBtn = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(okBtnTapped))
        self.navigationItem.rightBarButtonItem = okBtn
        self.title = "연락처 추가"
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

    @objc private func okBtnTapped() {
        guard let userName = nameTextView.text,
              let userNum = numTextView.text,
              let userImage = userProfileImage.image,
              let imageData = userImage.pngData()
        else {
            return
        }
        DataManager.shared.saveUserData(userName: userName, userNum: userNum, userImage: imageData)

        delegate?.didSaveUserData()

        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }

    @objc func randomImageBtntapped(){
        ramdomPokemonImage { [weak self] image in
            DispatchQueue.main.async {
                self?.userProfileImage.image = image
            }
        }
    }
}
