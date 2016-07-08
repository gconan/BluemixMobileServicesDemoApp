//
//  ToneScore.swift
//  BluemixMobileServicesDemoApp
//
//  Created by Conan Gammel on 7/8/16.
//  Copyright © 2016 Conan Gammel. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ToneScore{
    private var emotionScore: [Emotions:Double]
    private var socialScore: [Social:Double]
    private var languageScore: [Language:Double]
    
    private var runningEmotionScore:[Emotions:Double]
    private var runningSocialScore:[Social:Double]
    private var runningLanguageScore:[Language:Double]
    
    private var count:Double
    
    private let EmotionList = [Emotions.Anger, Emotions.Disgust, Emotions.Fear, Emotions.Joy, Emotions.Sadness]
    private let SocialList = [Social.Agreeableness, Social.Conscientiousness, Social.Extraversion, Social.Openness]
    private let LanguageList = [Language.Analytical, Language.Confident, Language.Tentative]
    
    
    public init (){
        self.initEmotions()
        self.initSocial()
        self.initLanguage()
        
        self.count = 0
    }
    
    public init(emotion:JSON, social:JSON, language:JSON){
        self.initEmotions(emotion)
        self.initSocial(social)
        self.initLanguage(language)
        
        self.count = 1
    }
    
    private func initEmotions(){
        for e:Emotions in self.EmotionList{
            self.emotionScore[e] = 0
        }
    }
    
    private func initSocial(){
        for s:Social in self.SocialList{
            self.socialScore[s] = 0
        }
    }
    
    private func initLanguage(){
        for l:Language in self.LanguageList{
            self.languageScore[l] = 0
        }
    }
    
    private func initEmotions(score:JSON){
//        for e:Emotions in self.EmotionList{
//            self.emotionScore[e] = score.dictionary[e.rawValue]
//        }
    }
    
    private func initSocial(score:JSON){
        for s:Social in self.SocialList{
            self.socialScore[s] = 0
        }
    }
    
    private func initLanguage(score:JSON){
        for l:Language in self.LanguageList{
            self.languageScore[l] = 0
        }
    }
    
    public func addToEmotionAverage(anger:Double, disgust:Double, fear:Double, joy:Double, sadness:Double){
        self.runningEmotionScore[Emotions.Anger] += anger
        self.runningEmotionScore[Emotions.Disgust] += disgust
        self.runningEmotionScore[Emotions.Fear] += fear
        self.runningEmotionScore[Emotions.Joy] += joy
        self.runningEmotionScore[Emotions.Sadness] += sadness
    }
    
    public func getEmotionAverage() -> Double{
        return self.runningEmotionScore/self.count
    }
    
    public func getSocialAverage() ->Double{
        return self.runningSocialScore/self.count
    }
    
    public func getLanguageAverage() -> Double{
        return self.runningLanguageScore/self.count
    }
    
    public func getEmotion() -> Double{
        return self.emotionScore
    }
    
    public func getSocial() ->Double{
        return self.socialScore
    }
    
    public func getLanguage() -> Double{
        return self.languageScore
    }
    
    enum Emotions:String{
        case tone = "emotion_tone"
        case Anger = "anger"
        case Disgust = "disgust"
        case Fear = "fear"
        case Joy = "joy"
        case Sadness = "sadness"
    }
    
    enum Language:String{
        case tone = "language_tone"
        case Analytical = "analytical"
        case Confident = "confident"
        case Tentative = "tentative"
    }
    
    enum Social:String{
        case tone = "social_tone"
        case Openness = "openness"
        case Conscientiousness = "conscientiousness"
        case Extraversion = "extraversion"
        case Agreeableness = "agreeableness"
    }    
    
}