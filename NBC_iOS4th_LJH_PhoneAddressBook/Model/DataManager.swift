
//  DataManager.swift
//  NBC_iOS4th_LJH_PhoneAddressBook
//
//  Created by Lee-Juhee on 7/18/24.

// DataManager.swift

// DataManager.swift

import UIKit
import CoreData

class DataManager {

    static let shared = DataManager()

    // Core Data를 이용한 사용자 데이터 저장
    func saveUserData(userName: String, userNum: String, userImage: UIImage) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        guard let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context) else {
            print("Failed to find entity 'Contact'")
            return
        }

        let userDataManagedObject = Contact(entity: entity, insertInto: context)

        userDataManagedObject.userName = userName
        userDataManagedObject.userNum = userNum

        if let imageData = userImage.jpegData(compressionQuality: 1.0) {
                    userDataManagedObject.userImage = imageData 
                }

        do {
            try context.save()
            print("사용자 데이터 저장 성공")
        } catch {
            print("사용자 데이터 저장 실패: \(error.localizedDescription)")
        }
    }

    // JSON 데이터 디코딩
    func loadUsers(from jsonData: Data) -> [UserData]? {
        let decoder = JSONDecoder()
        do {
            let users = try decoder.decode([UserData].self, from: jsonData)
            return users
        } catch {
            print("JSON 디코딩 실패: \(error.localizedDescription)")
            return nil
        }
    }

    // 파일에서 JSON 데이터 로드
    func loadJSONFromFile(named fileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            return try? Data(contentsOf: URL(fileURLWithPath: path))
        }
        return nil
    }
}
