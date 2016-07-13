//
//  ToneScore.swift
//  BluemixMobileServicesDemoApp
//
//  Created by Conan Gammel on 7/8/16.
//  Copyright © 2016 Conan Gammel. All rights reserved.
//

import Foundation
import SwiftyJSON
import BMSCore


public class ToneScore{
    private var emotionScore: [Emotions:Double] = [:]
    private var socialScore: [Social:Double] = [:]
    private var writingScore: [Writing:Double] = [:]
    
    private var runningEmotionScore:[Emotions:Double] = [:]
    private var runningSocialScore:[Social:Double] = [:]
    private var runningWritingScore:[Writing:Double] = [:]
    
    //used for average calculation
    private var count:Double = 0
    
    
    //lists used for forLoops
    private let EmotionList = [Emotions.Anger, Emotions.Disgust, Emotions.Fear, Emotions.Joy, Emotions.Sadness]
    private let SocialList = [Social.Agreeableness, Social.Conscientiousness, Social.Extraversion, Social.Openness, Social.Neuroticism]
    private let WritingList = [Writing.Analytical, Writing.Confident, Writing.Tentative]
    
    private let blueLogger: Logger = Logger.logger(forName: "DemoAppViewController")

    
    public init (){
        for e:Emotions in self.EmotionList{
            self.emotionScore[e] = 0
            self.runningEmotionScore[e] = 0
        }
        for s:Social in self.SocialList{
            self.socialScore[s] = 0
            self.runningSocialScore[s] = 0
        }
        for l:Writing in self.WritingList{
            self.writingScore[l] = 0
            self.runningWritingScore[l] = 0
        }
        
        self.count = 0
    }
    
    //Take a raw json doc and add the scores to the running calculation for average
    public func addToAverage(raw:JSON){
        let categories = raw["document_tone"]["tone_categories"]
        
        for (_,tone):(String, JSON) in categories{
            let id = tone["category_id"]
            
            if id.string == Emotions.tone.rawValue{
                addJSONToEmotionAverage(tone)
                
            }else if id.string == Social.tone.rawValue{
                addJSONToSocialAverage(tone)
                
            }else if id.string == Writing.tone.rawValue{
                addJSONToLangAverage(tone)
                
            }else{
                blueLogger.debug("Unrecognized Tone Category: \(id.string)")
            }
        }
        self.count = self.count + 1
    }
    
    private func addJSONToEmotionAverage(cat:JSON){
        var angerScore:Double = 0
        var disgustScore:Double = 0
        var fearScore:Double = 0
        var joyScore:Double = 0
        var sadScore:Double = 0
        
        let tones = cat["tones"]
        
        for (_,tone):(String, JSON) in tones{
            let id = tone["tone_id"]
            
            if id.string == Emotions.Anger.rawValue{
                angerScore = tone["score"].double!
                
            } else if id.string == Emotions.Disgust.rawValue{
                disgustScore = tone["score"].double!
                
            } else if id.string == Emotions.Fear.rawValue{
                fearScore = tone["score"].double!
                
            }else if id.string == Emotions.Joy.rawValue{
                joyScore = tone["score"].double!
                
            }else if id.string == Emotions.Sadness.rawValue{
                sadScore = tone["score"].double!
                
            }else{
                blueLogger.warn("Unrecognized Emotion Tone \(id.string)")
            }
            
        }
        
        self.runningEmotionScore[Emotions.Anger] = self.runningEmotionScore[Emotions.Anger]! + angerScore
        self.runningEmotionScore[Emotions.Disgust] = self.runningEmotionScore[Emotions.Disgust]! + disgustScore
        self.runningEmotionScore[Emotions.Fear] = self.runningEmotionScore[Emotions.Fear]! + fearScore
        self.runningEmotionScore[Emotions.Joy] = self.runningEmotionScore[Emotions.Joy]! + joyScore
        self.runningEmotionScore[Emotions.Sadness] = self.runningEmotionScore[Emotions.Sadness]! + sadScore
    }
    
    private func addJSONToSocialAverage(cat:JSON){
        var openScore:Double = 0
        var extraScore:Double = 0
        var agreeScore:Double = 0
        var contScore:Double = 0
        var neuroScore:Double = 0
        
        let tones = cat["tones"]
        
        for (_,tone):(String, JSON) in tones{
            let id = tone["tone_id"]
            
            if id.string == Social.Openness.rawValue{
                openScore = tone["score"].double!
                
            }else if id.string == Social.Extraversion.rawValue{
                extraScore = tone["score"].double!
                
            }else if id.string == Social.Agreeableness.rawValue{
                agreeScore = tone["score"].double!
                
            }else if id.string == Social.Conscientiousness.rawValue{
                contScore = tone["score"].double!
                
            }else if id.string == Social.Neuroticism.rawValue{
                neuroScore = tone["score"].double!
                
            }else{
                blueLogger.warn("Unrecognized Social Tone \(id.string)")
            }
        }
        self.runningSocialScore[Social.Openness] = self.runningSocialScore[Social.Openness]! + openScore
        self.runningSocialScore[Social.Extraversion] = self.runningSocialScore[Social.Extraversion]! + extraScore
        self.runningSocialScore[Social.Agreeableness] = self.runningSocialScore[Social.Agreeableness]! + agreeScore
        self.runningSocialScore[Social.Conscientiousness] = self.runningSocialScore[Social.Conscientiousness]! + contScore
        self.runningSocialScore[Social.Neuroticism] = self.runningSocialScore[Social.Neuroticism]! + neuroScore
    }
    
    private func addJSONToLangAverage(cat:JSON){
        var analyticalScore:Double = 0
        var confScore:Double = 0
        var tentScore:Double = 0
        
        let tones = cat["tones"]
        
        for (_,tone):(String, JSON) in tones{
            let id = tone["tone_id"]
            
            if id.string == Writing.Analytical.rawValue{
                analyticalScore = tone["score"].double!
                
            }else if id.string == Writing.Confident.rawValue{
                confScore = tone["score"].double!
                
            }else if id.string == Writing.Tentative.rawValue{
                tentScore = tone["score"].double!
                
            }else{
                blueLogger.warn("Unrecognized Writing Tone \(id.string)")
            }
            
        }
        
        self.runningWritingScore[Writing.Analytical] = self.runningWritingScore[Writing.Analytical]! + analyticalScore
        self.runningWritingScore[Writing.Confident] = self.runningWritingScore[Writing.Confident]! + confScore
        self.runningWritingScore[Writing.Tentative] = self.runningWritingScore[Writing.Tentative]! + tentScore
    }

    private func calculateEmotionAverage() -> [Emotions:Double]{
        for e:Emotions in self.EmotionList{
            self.emotionScore[e] = self.runningEmotionScore[e]!/self.count
        }
        return self.emotionScore
    }
    
    private func calculateWritingAverage() -> [Writing:Double]{
        for l:Writing in self.WritingList{
            self.writingScore[l] = self.runningWritingScore[l]!/self.count
        }
        return self.writingScore
    }

    private func calculateSocialAverage() -> [Social:Double]{
        for s:Social in self.SocialList{
            self.socialScore[s] = self.runningSocialScore[s]!/self.count
        }
        return self.socialScore
    }
    
    //retrieve information and form JSON
    public func toJSON()->JSON{
        var result: JSON = [:]
        result["document_tone"] = [:]
        
        var categoryArray: [JSON] = [JSON]()
        
        //EMOTIONS
        var emotions: JSON = [:]
        var emotionTones: [JSON] = [JSON]()
        self.calculateEmotionAverage()
        for e:Emotions in self.EmotionList{
            var tone: JSON = [:]
            tone["score"] = JSON(self.emotionScore[e]!)
            tone["tone_id"] = JSON(e.rawValue)
            tone["tone_name"] = JSON(e.toUpperCaseName())
            emotionTones.append(tone)
        }
        emotions["category_id"] = "emotion_tone"
        emotions["category_name"] = "Emotion Tone"
        emotions["tones"] = JSON(emotionTones)
        
        //SOCIAL
        var social: JSON = [:]
        var socialTones: [JSON] = [JSON]()
        self.calculateSocialAverage()
        for s:Social in self.SocialList{
            var tone: JSON = [:]
            tone["score"] = JSON(self.socialScore[s]!)
            tone["tone_id"] = JSON(s.rawValue)
            tone["tone_name"] = JSON(s.toUpperCaseName())
            socialTones.append(tone)
        }
        social["category_id"] = "social_tone"
        social["category_name"] = "Social Tone"
        social["tones"] = JSON(socialTones)
        
        
        //Writing
        var lang: JSON = [:]
        var langTones: [JSON] = [JSON]()
        self.calculateWritingAverage()
        for l:Writing in self.WritingList{
            var tone: JSON = [:]
            tone["score"] = JSON(self.writingScore[l]!)
            tone["tone_id"] = JSON(l.rawValue)
            tone["tone_name"] = JSON(l.toUpperCaseName())
            langTones.append(tone)
        }
        lang["category_id"] = "Writing_tone"
        lang["category_name"] = "Writing Tone"
        lang["tones"] = JSON(langTones)
        
        
        categoryArray.append(emotions)
        categoryArray.append(social)
        categoryArray.append(lang)
        
        result["document_tone"]["tone_categories"] = JSON(categoryArray)
        return result
    }

    //enum for emotion's tone IDs
   public enum Emotions:String{
        case tone = "emotion_tone"
        case name = "Emotion Tone"
        case Anger = "anger"
        case Disgust = "disgust"
        case Fear = "fear"
        case Joy = "joy"
        case Sadness = "sadness"
    }
    
    //enum for writing's tone ids
    public enum Writing:String{
        case tone = "writing_tone"
        case name = "Writing Tone"
        case Analytical = "analytical"
        case Confident = "confident"
        case Tentative = "tentative"
    }
    
    //enum for social's tone ids
    public enum Social:String{
        case tone = "social_tone"
        case name = "Social Tone"
        case Openness = "openness_big5"
        case Conscientiousness = "conscientiousness_big5"
        case Extraversion = "extraversion_big5"
        case Agreeableness = "agreeableness_big5"
        case Neuroticism = "neuroticism_big5"
    }    
    
}

//extensions for the enums to get the tone name from the tone id



extension ToneScore.Emotions{
    func toUpperCaseName()->String{
        switch (self){
        case ToneScore.Emotions.Anger:
            return "Anger"
        case ToneScore.Emotions.Disgust:
            return "Disgust"
        case ToneScore.Emotions.Fear:
            return "Fear"
        case ToneScore.Emotions.Joy:
            return "Joy"
        case ToneScore.Emotions.Sadness:
            return "Sadness"
        default:
            return""
        }
    }
}

extension ToneScore.Social{
    func toUpperCaseName()->String{
        switch (self){
        case ToneScore.Social.Openness:
            return "Openness"
        case ToneScore.Social.Conscientiousness:
            return "Conscientiousness"
        case ToneScore.Social.Extraversion:
            return "Extraversion"
        case ToneScore.Social.Agreeableness:
            return "Agreeableness"
        case ToneScore.Social.Neuroticism:
            return "Neuroticism"
        default:
            return""
        }
    }
}

extension ToneScore.Writing{
    func toUpperCaseName()->String{
        switch (self){
        case ToneScore.Writing.Analytical:
            return "Analytical"
        case ToneScore.Writing.Confident:
            return"Confident"
        case ToneScore.Writing.Tentative:
            return"Tentative"
        default:
            return""
        }
    }
}