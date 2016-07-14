# BluemixMobileServicesDemoApp
[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A demo iOS Swift app that shows Mobile Analytics, Watson, and OpenWhisk used to analyze tone and post to a slack channel.


## About the App

I created the app for BlueChasm's Developer Day in Houston on July 14, 2016. The app is meant to show how easy it is to creat powerful apps using microservices found on [Bluemix](https://new-console.ng.bluemix.net/)


### The app contains these frameworks:
 * [Bluemix Mobile Analytics](https://new-console.ng.bluemix.net/docs/services/mobileanalytics/index.html) (Beta Coming Soon!) [(Documentation)](https://new-console.ng.bluemix.net/docs/services/mobileanalytics/index.html)
    * Shows Analytics related to app usage and logging
 * [Watson Speech to Text](https://new-console.ng.bluemix.net/catalog/services/speech-to-text/) [(Documentation)](http://www.ibm.com/watson/developercloud/speech-to-text/api/v1/)
    * Transcribes speech input to the device to text
 * [Watson Tone Analysis](https://new-console.ng.bluemix.net/catalog/services/tone-analyzer/) [(Documentation)](http://www.ibm.com/watson/developercloud/tone-analyzer/api/v3/#introduction)
    * Analyzes the tone of text provided to the service
 * [Swifty JSON](https://github.com/SwiftyJSON/SwiftyJSON)
    * Makes working with JSON in Swift easier

### Required Bluemix services:
 * [Open Whisk](https://new-console.ng.bluemix.net/openwhisk/?cm_mmc=developerWorks-_-dWdevcenter-_-open-_-lp) [(Documentation)](https://developer.ibm.com/open/openwhisk/)
    * Used to detect Cloudant Database changes and post the changes to [Slack](https://slack.com/)
 * [Cloudant](https://new-console.ng.bluemix.net/catalog/services/cloudant-nosql-db/) [(Documentation)] (https://docs.cloudant.com/authorization.html)
    * A NoSQL database to store Tone Analysis results
 * [Watson Speech to Text](https://new-console.ng.bluemix.net/catalog/services/speech-to-text/) [(Documentation)](https://www.ibm.com/watson/developercloud/speech-to-text.html)
    * Uses cognitive knowledge of the composition of an audio signal to generate an accurate transcription
 * [Watson Tone Analyzer](https://new-console.ng.bluemix.net/catalog/services/tone-analyzer/) [(Documentation)](https://www.ibm.com/watson/developercloud/tone-analyzer/api/v3/)
    * Uses cognitive linguistic analysis to detect three types of tones from text: emotion, social tendencies, and language style

## To Run the App
 * Clone or fork this repository
 * `cd BluemixMobileServicesDemoApp/`
 * Ensure that you have [Carthage](https://github.com/Carthage/Carthage#installing-carthage)
 * `carthage update --platform iOS`
 * Once carthage finishes (can take a while to build all the Watson SDKs), open the project
 * Run the app
   * You must enter all of your Bluemix credentials where  you see tags like \<enter your username here\>
   * **Note:** the microphone only works with a physical device, which requires an Apple Developer License to install an app on real phone. But you can still enter a message using the text box.
 * Click on any of the movie characters to have their tone analyzed(will save to your Cloudant DB)
 * Send a custom message(by voice or text) for analyzation then see which character your tone most aligns with
