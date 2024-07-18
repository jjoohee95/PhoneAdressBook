//
//  UserData.swift
//  NBC_iOS4th_LJH_PhoneAddressBook
//
//  Created by Lee-Juhee on 7/16/24.
//
import Foundation
import UIKit

struct UserData: Decodable {
    let userImage: UIImage
    let userName: String
    let userNum: String

    private enum CodingKeys: String, CodingKey {
        case userName, userNum, userImageData
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.userNum = try container.decode(String.self, forKey: .userNum)

        if let imageData = try container.decodeIfPresent(Data.self, forKey: .userImageData),
           let image = UIImage(data: imageData) {
            self.userImage = image
        } else {
            self.userImage = UIImage(named: "defaultImage") ?? UIImage()
        }
    }
}
