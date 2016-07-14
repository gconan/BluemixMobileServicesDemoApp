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

//extract information from the ToneAnalysis and make a swiftyJson object
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
    
    public func getResultsInDictionary(userID:Int)->[String:Double]{
        var result:[String:Double] = [String:Double]()
        for cat in self.documentTone{
            for tone in cat.tones {
                result[tone.name] = Double(round(tone.score * 1000)/1000)
            }
        }
        result["Person"] = Double(userID)
        return result
    }
}

extension JSON{
    public func getToneScore(toneId:String)->Double{
        let categories = self["document_tone"]["tone_categories"]
        
        for (_,cat):(String, JSON) in categories{
            let tones = cat["tones"]
            
            for (_,tone):(String, JSON) in tones{
                if toneId == tone["tone_id"].stringValue{
                    return tone["score"].double!
                }
            }
        }
        return -1.0
    }
}