//
//  File.swift
//  20230119-KunNiu-NYCSchools
//
//  Created by Kun Niu on 2023-01-22.
//

import UIKit

struct Device {
    static var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}
