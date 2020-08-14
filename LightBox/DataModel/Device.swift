//
//  Device.swift
//  LightBox
//
//  Created by Dmitry Kostyuchenko on 14.08.2020.
//  Copyright © 2020 Dmitry Kostyuchenko. All rights reserved.
//

import Foundation

struct Device {
    let id = UUID()
    var model = "DevKit"
    var title = "Device Name"
    var ip = [192,168,0,1]
    var inPort: UInt16 = 6666
    var outPort: UInt16 = 6667
}
