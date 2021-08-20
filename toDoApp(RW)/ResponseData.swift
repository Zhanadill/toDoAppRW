//
//  Data.swift
//  toDoApp(RW)
//
//  Created by Жанадил on 8/19/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import Foundation

//Использовали когда считывали данные напрямую из json файла

struct ResponseData: Codable{
    let priority: String
    var tasks = [Task]()
}

struct Task: Codable {
    let id = UUID()
    var name: String
    var completed = false
}
