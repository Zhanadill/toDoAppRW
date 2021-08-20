//
//  DataLoader.swift
//  toDoApp(RW)
//
//  Created by Жанадил on 8/19/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import Foundation


//We use that when we load data directly from JSON file
/*public class DataLoader {
    @Published var userData = [ResponseData]()
    
    init(){
        load()
    }
    
    func load(){
        if let fileLocation = Bundle.main.url(forResource: "PrioritizedTasks", withExtension: "json"){
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([ResponseData].self, from: data)
                
                self.userData = dataFromJson
            }catch{
                print(error)
            }
        }
    }
}*/
