//
//  UserData.swift
//  NBC_iOS4th_LJH_PhoneAddressBook
//
//  Created by Lee-Juhee on 7/16/24.
//
import Foundation
import UIKit

struct UserData: Decodable {
    let userImage: Data  // 이미지 데이터를 Data 형식으로 저장
    let userName: String
    let userNum: String

    private enum CodingKeys: String, CodingKey {
        case userName, userNum, userImageData
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.userNum = try container.decode(String.self, forKey: .userNum)

        if let imageData = try container.decodeIfPresent(Data.self, forKey: .userImageData) {
            self.userImage = imageData
        } else {
            // 기본 이미지 데이터 설정
            self.userImage = UIImage(named: "defaultImage")?.pngData() ?? Data()
            
        }
    }
}

