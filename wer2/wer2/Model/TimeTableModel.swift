//
//  TimeTableModel.swift
//  wer2
//
//  Created by Alexandr Romantsov on 11/10/2019.
//  Copyright © 2019 Alexandr Romantsov. All rights reserved.
//

import Foundation
import UIKit

struct TimeTableModel {
    var mainImage: UIImage;
    var className: String;
    //var TimeImage: UIImage;
    
    static func fetchTimeTable() -> [TimeTableModel] {
        
        let A11 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "11 A ТЕХ")
        let B11 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "11 Б ТЕХ")
        let V11 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "11 ХБП")
        let G11 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "11 СЕП")
        
        let A10 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "10 A ТЕХ")
        let B10 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "10 Б ТЕХ")
        let V10 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "10 ХБП")
        let G10 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "10 СЕП")
        
        let A9 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "9 A ТЕХ")
        let B9 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "9 Б ТЕХ")
        let V9 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "9 ХБП")
        let G9 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "9 СЕП")
        
        let A8 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "8 A ТЕХ")
        let B8 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "8 Б ТЕХ")
        let V8 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "8 ХБП")
        let G8 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "8 СЕП")
        
        let A7 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "7 A ТЕХ")
        let B7 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "7 Б ТЕХ")
        let V7 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "7 ХБП")
        let G7 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "7 СЕП")
        
        let A6 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "6 A ТЕХ")
        let B6 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "6 Б ТЕХ")
        let V6 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "6 ХБП")
        let G6 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "6 СЕП")
        
        let A5 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "5 A ТЕХ")
        let B5 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "5 Б ТЕХ")
        let V5 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "5 ХБП")
        let G5 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "5 СЕП")
        
        return [A11, B11, V11, G11, A10, B10, V10, G10, A9, B9, V9, G9, A8, B8, V8, G8, A7, B7, V7, G7, A6, B6, V6, G6, A5, B5, V5,     G5]
        
        /*
        let i11 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "11 Классы", TimeImage: UIImage(named: "Far1")!)
        let i10 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "10 Классы", TimeImage: UIImage(named: "Far1")!)
        let i9 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "9 Классы", TimeImage: UIImage(named: "Far1")!)
        let i8 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "8 Классы", TimeImage: UIImage(named: "Far1")!)
        let i7 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "7 Классы", TimeImage: UIImage(named: "Far1")!)
        let i6 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "6 Классы", TimeImage: UIImage(named: "Far1")!)
        let i5 = TimeTableModel(mainImage: UIImage(named: "Class")!, className: "5 Классы", TimeImage: UIImage(named: "Far1")!)
        
        return [i11, i10, i9, i8, i7, i6, i5]
         */
    }
}
