//
//  Model.swift
//
//  Created by D K on 05.12.2024.
//

import Foundation
import RealmSwift


class RealmPerson: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var image = ""
    @Persisted var name = ""
    @Persisted var surname = ""
    @Persisted var email = ""
    @Persisted var birthday = ""
    @Persisted var number = ""
}


class RealmReservation: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var date = ""
    @Persisted var time = ""
    @Persisted var persons = 0
    @Persisted var room = ""
    
}
