//
//  StorageManager.swift
//
//  Created by D K on 05.12.2024.
//

import Foundation
import RealmSwift


class StorageManager {
    static let shared = StorageManager()
    let realm = try! Realm()
    private init(){}
    
    @ObservedResults(RealmPerson.self) var persons
    @ObservedResults(RealmReservation.self) var reservations
    
    func saveReserv(date: String, room: String, persons: Int, time: String) {
        do {
            try realm.write {
                let reserv = RealmReservation()
                reserv.date = date
                reserv.room = room
                reserv.persons = persons
                reserv.time = time
                realm.add(reserv)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveOrUpdateUser(_ user: RealmPerson) {
        do {
            if let firstPerson = persons.first {
                try realm.write {
                    firstPerson.name = user.name
                    firstPerson.surname = user.surname
                    firstPerson.email = user.email
                    firstPerson.birthday = user.birthday
                    firstPerson.number = user.number
                    firstPerson.image = user.image
                }
            } else {
                let newPerson = RealmPerson()
                newPerson.name = user.name
                newPerson.surname = user.surname
                newPerson.email = user.email
                newPerson.birthday = user.birthday
                newPerson.number = user.number
                newPerson.image = user.image
                
                try realm.write {
                    realm.add(newPerson)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getFirstUser() -> RealmPerson? {
        return realm.objects(RealmPerson.self).first
    }
}
