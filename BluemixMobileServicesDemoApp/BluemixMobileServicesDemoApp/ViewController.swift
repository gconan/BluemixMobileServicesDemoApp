//
//  ViewController.swift
//  BluemixMobileServicesDemoApp
//
//  Created by Conan Gammel on 7/5/16.
//  Copyright © 2016 Conan Gammel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /* We ran the tone analysis on each character before hand
        to get an average. This way we can speed up the comparison
        between the characters to a live voice */
    let RonB_AverageScore = []
    let DarthV_AverageScore = []
    let EllenD_AverageScore = []
    let JackS_AverageScore = []
    let JamesB_AverageScore = []
    
    //quotes
    let RonB_Quotes: [String] = ["What? You pooped in the refrigerator? And you ate the whole wheel of cheese? How’d you do that? Heck, I’m not even mad; that’s amazing.","I don't know how to put this but I'm kind of a big deal. People know me. I'm very important. I have many leather-bound books and my apartment smells of rich mahogany.", "Mmm. I look good. I mean, really good. Hey, everyone! Come and see how good I look!", "You know how to cut to the core of me, Baxter. You're so wise. You're like a miniature Buddha covered in hair.", "Guess what, I do. I know that one day Veronica and I are gonna to get married on top of a mountain, and there’s going to be flutes playing and trombones and flowers and garlands of fresh herbs. And we will dance till the sun rises. And then our children will form a family band. And we will tour the countryside and you won’t be invited."]
    
    let DarthV_Quotes: [String] = ["No, I am your father.","Don’t be too proud of this technological terror you’ve constructed. The ability to destroy a planet is insignificant next to the power of the Force. I find your lack of faith disturbing.","I am altering the deal. Pray I don’t alter it any further.","I see through the lies of the Jedi. I do not fear the dark side as you do. I have brought peace, freedom, justice, and security to my new empire.","Luke, you can destroy the Emperor. He has foreseen this. It is your destiny. Join me, and together we can rule the galaxy as father and son."]
    
    let EllenD_Quotes: [String] = ["You have to stay in shape. My grandmother, she started walking five miles a day when she was 60. She's 97 today and we don't know where the hell she is.","Sometimes you can't see yourself clearly until you see yourself through the eyes of others.","In the beginning there was nothing. God said, 'Let there be light!' And there was light. There was still nothing, but you could see it a whole lot better.", "If we're destroying our trees and destroying our environment and hurting animals and hurting one another and all that stuff, there's got to be a very powerful energy to fight that. I think we need more love in the world. We need more kindness, more compassion, more joy, more laughter. I definitely want to contribute to that.", "Here are the values that I stand for: honesty, equality, kindness, compassion, treating people the way you want to be treated and helping those in need. To me, those are traditional values."]
    
    let JackS_Quotes: [String] = ["Why is the rum always gone?", "Why fight when you can negotiate?", "This is the day you will always remember as the day you almost caught me.", "The seas may be rough, but I am the captain!", "No matter how difficult, I will always prevail.", "Me? I'm dishonest, and a dishonest man you can always trust to be dishonest. Honestly. It's the honest ones you want to watch out for.", "You're the one in need of resucing and I'm not sure if I'm in the mood.", "Why should I sail with any of you? Four of you tried to kill me in the past, one of you succeeded."]
    
    let JamesB_Quotes: [String] = ["I don't stop when I'm tired, I stop when I'm done","It takes a certain kind of woman to wear a backless dress and a gun strapped to her thigh", "A Martini. Shaken, not stirred", "Be polite, be courteous, show professionalism, and have a plan to kill everyone in the room", "Killing and dying, it's all a matter of perspective", "My name is Bond, James Bond", "I don’t know, I’ve never lost.", "My dear girl, there are some things that just aren’t done. Such as, drinking Dom Perignon ’53 above the temperature of 38 degrees Fahrenheit. That’s just as bad as listening to the Beatles without earmuffs."]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ronBurgandy(sender: AnyObject) {
    }
    @IBAction func darthVader(sender: AnyObject) {
    }
    @IBAction func ellenD(sender: AnyObject) {
    }
    @IBAction func jackSparrow(sender: AnyObject) {
    }
    @IBAction func bondJamesBond(sender: AnyObject) {
    }
    @IBAction func compareUserToCharacters(sender: AnyObject) {
    }
}