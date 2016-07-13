//
//  ToneToJSONConverter.swift
//  BluemixMobileServicesDemoApp
//
//  Created by Conan Gammel on 7/12/16.
//  Copyright © 2016 Conan Gammel. All rights reserved.
//

import Foundation
import SwiftyJSON
import ToneAnalyzerV3

private let docTone:String = "document_tone"
private let toneCat:String = "tone_categories"
private let tones:String = "tones"
private let score:String = "score"
private let toneID:String = "tone_id"
private let toneName:String = "tone_name"
private let categoryID:String = "category_id"
private let categoryName:String = "category_name"


extension ToneAnalysis{
    
    public func convertToSwiftyJSON()->JSON{
        var json:JSON = JSON([:])
        json[docTone] = JSON([:])
        json[docTone][toneCat] = JSON([self.documentTone.count])
        
        
        var bigTemp:[JSON] = [JSON]()
        for cat in self.documentTone{
            var tonesJSON:JSON = JSON([:])
            
            let catID:String = cat.categoryID
            let catName:String = cat.name
            
            tonesJSON[categoryID] = JSON(catID)
            tonesJSON[categoryName] = JSON(catName)
            
            
            var temp:[JSON] = [JSON]()
            for tone in cat.tones {
                var scoreJSON:JSON = ([:])
                scoreJSON[score] = JSON(tone.score)
                scoreJSON[toneID] = JSON(tone.id)
                scoreJSON[toneName] = JSON(tone.name)
                
                
                temp.append(scoreJSON)
                
            }
            tonesJSON[tones] = JSON(temp)
            
            bigTemp.append(tonesJSON)
            
        }
        json[docTone][toneCat] = JSON(bigTemp)
        return json
    }
}