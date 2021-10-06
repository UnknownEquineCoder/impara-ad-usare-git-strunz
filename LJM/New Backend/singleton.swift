//
//  singleton.swift
//  LJM
//
//  Created by denys pashkov on 05/10/21.
//

import Foundation

class singleton_Shared{
    static let shared = singleton_Shared()
    var profile_data : profile = profile()
    var learning_Objectives : [learning_Objective] = []
    
}

