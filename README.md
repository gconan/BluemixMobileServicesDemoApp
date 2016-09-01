# BluemixMobileServicesDemoApp
[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A demo iOS Swift app that shows Mobile Analytics, Watson, and OpenWhisk used to analyze tone and post to a slack channel.


## About the App

I created the app for BlueChasm's Developer Day in Houston on July 14, 2016. The app is meant to show how easy it is to creat powerful apps using various microservices found on [Bluemix](https://new-console.ng.bluemix.net/)

### Required Bluemix services:
 * [Open Whisk](https://new-console.ng.bluemix.net/openwhisk/?cm_mmc=developerWorks-_-dWdevcenter-_-open-_-lp)
    * Used to detect Cloudant Database changes and post the changes to [Slack](https://slack.com/)
    * [Open Whisk Documentation](https://developer.ibm.com/open/openwhisk/)
 * [Cloudant](https://new-console.ng.bluemix.net/catalog/services/cloudant-nosql-db/)
    * A NoSQL database to store Tone Analysis results
    * [Cloudant Documentation](https://docs.cloudant.com/authorization.html)
 * [Watson Speech to Text](https://new-console.ng.bluemix.net/catalog/services/speech-to-text/)
    * Uses cognitive knowledge of the composition of an audio signal to generate an accurate transcription
    * [Documentation](https://www.ibm.com/watson/developercloud/speech-to-text.html)
 * [Watson Tone Analyzer](https://new-console.ng.bluemix.net/catalog/services/tone-analyzer/)
    * Uses cognitive linguistic analysis to detect three types of tones from text: emotion, social tendencies, and language style
    * [Documentation](https://www.ibm.com/watson/developercloud/tone-analyzer/api/v3/)
 * [Bluemix Mobile Analytics](https://new-console.ng.bluemix.net/docs/services/mobileanalytics/index.html) (Beta Coming Soon!)
    * Shows Analytics related to app usage and logging
    * [Analytics Documentation](https://new-console.ng.bluemix.net/docs/services/mobileanalytics/index.html)

## To Run the App
 * Provision each of the services above in Bluemix
    * Click the service title links above
    * Give your service a name, then click create
    * **Note:** Analytics is not in Beta yet, you will not be able to use analytics until then
 * Clone or fork this repository
 * `cd BluemixMobileServicesDemoApp/`
 * Ensure that you have [Carthage](https://github.com/Carthage/Carthage#installing-carthage)
 * `carthage update --platform iOS`
    * Will install the SDKs associated with the Bluemix services listed above.
    * Will also install [Swifty JSON](https://github.com/SwiftyJSON/SwiftyJSON) to make working with JSON in Swift easier
 * Once carthage finishes (can take a while (~20min) to build all the Watson SDKs), open the project
 * Run the app
   * You must enter all of your Bluemix credentials where you see the old credentials
      * On each service page, there is a credentials tab, which will contain the necessary credentials for your app to run properly
   * **Note:** the microphone only works with a physical device, which requires an Apple Developer License to install an app on real phone. But you can still enter a message using the text box.
 * Click on any of the movie characters to have their tone analyzed(will save to your Cloudant DB)
 * Send a custom message(by voice or text) for analyzation then see which character your tone most aligns with
