import UIKit
import CoreData

class DataManager {

    static let shared = DataManager()

    // Core Data를 이용한 사용자 데이터 저장
    func saveUserData(userName: String, userNum: String, userImage: Data) {
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
            let contacts = try context.fetch(Contact.fetchRequest())
            for i in contacts {
                list.append(i)
            }

        } catch {
            print("데이터 읽기 실패")
        }
        return list
    }

}
