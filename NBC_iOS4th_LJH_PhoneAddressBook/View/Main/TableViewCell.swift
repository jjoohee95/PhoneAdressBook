//
//  TableViewCell.swift
//  NBC_iOS4th_LJH_PhoneAddressBook
//
//  Created by t2023-m0023 on 7/16/24.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {

    private  let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()

    private let userNameLabel = UILabel()

    private let userNumLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(userImageView)
        addSubview(userNameLabel)
        addSubview(userNumLabel)

        setupLayout()

    }
    func setupLayout() {
        // userImageView 제약조건
        userImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.width.height.equalTo(80)
            $0.centerY.equalToSuperview()
        }

        // userNameLabel 제약조건
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(userImageView.snp.trailing).offset(50)
            $0.centerY.equalTo(userImageView.snp.centerY)
        }

        // userNumLabel 제약조건
        userNumLabel.snp.makeConstraints {
            $0.leading.equalTo(userNameLabel.snp.trailing).offset(30)
            $0.centerY.equalTo(userImageView.snp.centerY)
        }
    }

    func configure(image: UIImage, name: String, phone: String) {
        userImageView.image = image
        userNameLabel.text = name
        userNumLabel.text = phone
    }
}
