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
    private var languageScore: [Language:Double] = [:]
    
    private var runningEmotionScore:[Emotions:Double] = [:]
    private var runningSocialScore:[Social:Double] = [:]
    private var runningLanguageScore:[Language:Double] = [:]
    
    private var count:Double = 0
    
    private let EmotionList = [Emotions.Anger, Emotions.Disgust, Emotions.Fear, Emotions.Joy, Emotions.Sadness]
    private let SocialList = [Social.Agreeableness, Social.Conscientiousness, Social.Extraversion, Social.Openness]
    private let LanguageList = [Language.Analytical, Language.Confident, Language.Tentative]
    
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
        for l:Language in self.LanguageList{
            self.languageScore[l] = 0
            self.runningLanguageScore[l] = 0
        }
        
        self.count = 0
    }
    
    public func addToAverage(raw:JSON){
        let categories = raw["document_tone"]["tone_categories"]
        
        for (_,tone):(String, JSON) in categories{
            let id = tone["category_id"]
            
            if id.string == Emotions.tone.rawValue{
                addJSONToEmotionAverage(tone)
            }else if id.string == Social.tone.rawValue{
                addJSONToSocialAverage(tone)
            }else if id.string == Language.tone.rawValue{
                addJSONToLangAverage(tone)
            }else{
                blueLogger.debug("Unrecognized Tone Category: \(id.string)")
            }
        }
        self.count = self.count + 1
    }
    
    private func addJSONToEmotionAverage(tones:JSON){
        var angerScore:Double = 0
        var disgustScore:Double = 0
        var fearScore:Double = 0
        var joyScore:Double = 0
        var sadScore:Double = 0
        
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
    
    private func addJSONToSocialAverage(tones:JSON){
        var openScore:Double = 0
        var extraScore:Double = 0
        var agreeScore:Double = 0
        
        
        for (_,tone):(String, JSON) in tones{
            let id = tone["tone_id"]
            
            if id.string == Social.Openness.rawValue{
                openScore = tone["score"].double!
                
            }else if id.string == Social.Extraversion.rawValue{
                extraScore = tone["score"].double!
                
            }else if id.string == Social.Agreeableness.rawValue{
                agreeScore = tone["score"].double!
            }else{
                blueLogger.warn("Unrecognized Social Tone \(id.string)")
            }
        }
        self.runningSocialScore[Social.Openness] = self.runningSocialScore[Social.Openness]! + openScore
        self.runningSocialScore[Social.Extraversion] = self.runningSocialScore[Social.Extraversion]! + extraScore
        self.runningSocialScore[Social.Agreeableness] = self.runningSocialScore[Social.Agreeableness]! + agreeScore
    }
    
    private func addJSONToLangAverage(tones:JSON){
        var analyticalScore:Double = 0
        var confScore:Double = 0
        var tentScore:Double = 0
        
        
        for (_,tone):(String, JSON) in tones{
            let id = tone["tone_id"]
            
            if id.string == Language.Analytical.rawValue{
                analyticalScore = tone["score"].double!
                
            }else if id.string == Language.Confident.rawValue{
                confScore = tone["score"].double!
                
            }else if id.string == Language.Tentative.rawValue{
                tentScore = tone["score"].double!
            }else{
                blueLogger.warn("Unrecognized Language Tone \(id.string)")
            }
            
        }
        
        self.runningLanguageScore[Language.Analytical] = self.runningLanguageScore[Language.Analytical]! + analyticalScore
        self.runningLanguageScore[Language.Confident] = self.runningLanguageScore[Language.Confident]! + confScore
        self.runningLanguageScore[Language.Tentative] = self.runningLanguageScore[Language.Tentative]! + tentScore
    }

    public func getEmotionAverage() -> [Emotions:Double]{
        for e:Emotions in self.EmotionList{
            self.emotionScore[e] = self.runningEmotionScore[e]!/self.count
        }
        return self.emotionScore
    }
    
    public func getLanguageAverage() -> [Language:Double]{
        for l:Language in self.LanguageList{
            self.languageScore[l] = self.runningLanguageScore[l]!/self.count
        }
        return self.languageScore
    }

    public func getSocialAverage() -> [Social:Double]{
        for s:Social in self.SocialList{
            self.socialScore[s] = self.runningSocialScore[s]!/self.count
        }
        return self.socialScore
    }

   public enum Emotions:String{
        case tone = "emotion_tone"
        case Anger = "anger"
        case Disgust = "disgust"
        case Fear = "fear"
        case Joy = "joy"
        case Sadness = "sadness"
    }
    
    public enum Language:String{
        case tone = "language_tone"
        case Analytical = "analytical"
        case Confident = "confident"
        case Tentative = "tentative"
    }
    
    public enum Social:String{
        case tone = "social_tone"
        case Openness = "openness"
        case Conscientiousness = "conscientiousness"
        case Extraversion = "extraversion"
        case Agreeableness = "agreeableness"
    }    
    
}