//
//  singleton.swift
//  LJM
//
//  Created by denys pashkov on 05/10/21.
//

import Foundation

class profile_Singleton{
    static let shared = profile_Singleton()
    var profile_data : profile = profile()
}
