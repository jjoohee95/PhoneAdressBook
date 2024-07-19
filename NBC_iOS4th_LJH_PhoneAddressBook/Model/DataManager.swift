//
//  DataManager.swift
//  NBC_iOS4th_LJH_PhoneAddressBook
//
//  Created by Lee-Juhee on 7/18/24.
//

import UIKit
import CoreData

class DataManager {

    static let shared = DataManager()

    // Core Data를 이용한 사용자 데이터 저장
    func saveUserData(userName: String, userNum: String, userImage: Data) {
        guard !userName.isEmpty, !userNum.isEmpty else {
                    print("이름이나 번호가 비어 있어 저장하지 않습니다.")
                    return
                }

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        guard let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context) else {
            print("Failed to find entity 'Contact'")
            return
        }

        let userDataManagedObject = Contact(entity: entity, insertInto: context)

        userDataManagedObject.userName = userName
        userDataManagedObject.userNum = userNum

        // 이미지 저장
        userDataManagedObject.userImage = userImage

        do {
            try context.save()
            print("사용자 데이터 저장 성공")
        } catch {
            print("사용자 데이터 저장 실패: \(error.localizedDescription)")
        }
    }

    func readAllData() -> [Contact] {
        var list: [Contact] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return list }
        let context = appDelegate.persistentContainer.viewContext
                do {
                    // 모든 'Contact' 객체 가져오기
                    let contacts = try context.fetch(Contact.fetchRequest()) as! [Contact]
                    // 유효한 데이터만 필터링
                    list = contacts.filter { !($0.userName?.isEmpty ?? true) && !($0.userNum?.isEmpty ?? true) }
                    // 이름 기준으로 정렬
                    list.sort { ($0.userName ?? "") < ($1.userName ?? "") }

        } catch {
            print("데이터 읽기 실패")
        }
        return list
    }

}
