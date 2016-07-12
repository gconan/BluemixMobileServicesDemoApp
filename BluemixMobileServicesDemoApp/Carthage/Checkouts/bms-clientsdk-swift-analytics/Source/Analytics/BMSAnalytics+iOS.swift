/*
*     Copyright 2016 IBM Corp.
*     Licensed under the Apache License, Version 2.0 (the "License");
*     you may not use this file except in compliance with the License.
*     You may obtain a copy of the License at
*     http://www.apache.org/licenses/LICENSE-2.0
*     Unless required by applicable law or agreed to in writing, software
*     distributed under the License is distributed on an "AS IS" BASIS,
*     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*     See the License for the specific language governing permissions and
*     limitations under the License.
*/


import Foundation
import UIKit


public extension BMSAnalytics {
    
    
    // Records the duration of the app's lifecycle from when it enters the foreground to when it goes to the background.
    internal static func startRecordingApplicationLifecycle() {
        
        // By now, the app will have already passed the "will enter foreground" event. Therefore, we must manually start the timer for the current session.
        logSessionStart()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logSessionStart", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logSessionEnd", name: UIApplicationDidEnterBackgroundNotification, object: nil)
    }
    
    
    // General information about the device that the app is running on.
    // This data gets sent in every network request to the Analytics server
    internal static func getiOSDeviceInfo() -> (String, String, String) {
        
        var osVersion = "", model = "", deviceId = ""
        
        let device = UIDevice.currentDevice()
        osVersion = device.systemVersion
        deviceId = device.identifierForVendor?.UUIDString ?? "unknown"
        model = device.modelName
        
        return (osVersion, model, deviceId)
    }
    
}



// MARK: -

// Get the device type as a human-readable string
// http://stackoverflow.com/questions/26028918/ios-how-to-determine-iphone-model-in-swift
internal extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":       return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                   return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                   return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                   return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":  return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":            return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":            return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":            return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":            return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":            return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":            return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                       return identifier
        }
    }
}

