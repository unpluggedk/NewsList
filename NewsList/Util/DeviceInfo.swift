//
//  DeviceInfo.swift
//  NewsList
//
//  Created by Jason Kim on 12/3/20.
//

import UIKit


import UIKit

struct DeviceInfo {
    
    static var isTablet: Bool {
        get {
            return UIDevice.current.userInterfaceIdiom == .pad
        }
    }
    
    static var isPhone: Bool {
        get {
            return UIDevice.current.userInterfaceIdiom == .phone
        }
    }
}
