# BluemixMobileServicesDemoApp
A demo iOS app that shows Mobile Analytics, Watson, and OpenWhisk used to analyze tone and post to a slack channel.


## About the App

I created the app for BlueChasm's Developer Day in Houston on July 14, 2016. The app is meant to show how easy it is to creat powerful apps using microservices found on [Bluemix](https://new-console.ng.bluemix.net/)


### The app contains these frameworks:
 * [Bluemix Mobile Analytics](https://new-console.ng.bluemix.net/docs/services/mobileanalytics/index.html) (Beta Coming Soon!)
    * Shows Analytics related to app usage and logging
    * [Analytics Documentation](https://new-console.ng.bluemix.net/docs/services/mobileanalytics/index.html)
 * [Watson Speech to Text](https://new-console.ng.bluemix.net/catalog/services/speech-to-text/)
    * Transcribes speech input to the device to text
    * [Speech to Text Documentation](http://www.ibm.com/watson/developercloud/speech-to-text/api/v1/)
 * [Watson Tone Analysis](https://new-console.ng.bluemix.net/catalog/services/tone-analyzer/)
    * Analyzes the tone of text provided to the service
    * [Tone Analysis Documentation](http://www.ibm.com/watson/developercloud/tone-analyzer/api/v3/#introduction)
 * [Swifty JSON](https://github.com/SwiftyJSON/SwiftyJSON)
    * Makes working with JSON in Swift easier

### The app also uses these Bluemix services:
 * [Open Whisk](https://new-console.ng.bluemix.net/openwhisk/?cm_mmc=developerWorks-_-dWdevcenter-_-open-_-lp)
    * Used to detect Cloudant Database changes and post the changes to [Slack](https://slack.com/)
    * [Open Whisk Documentation](https://developer.ibm.com/open/openwhisk/)
 * [Cloudant](https://new-console.ng.bluemix.net/catalog/services/cloudant-nosql-db/)
    * A NoSQL database to store Tone Analysis results
    * [Cloudant Documentation](https://docs.cloudant.com/authorization.html)


## To Run the App
 * clone or fork this repository
 * `cd BluemixMobileServicesDemoApp/`
 * Ensure that you have [Carthage](https://github.com/Carthage/Carthage#installing-carthage)
 * `carthage update --platform iOS`
 * Once carthage finishes (can take a while to build all the Watson SDKs), open the project
 * Run the app
   * You must enter all of your Bluemix credentials where  you see tags like \<enter your username here\>
   * **Note:** the microphone only works with a physical device, which requires an Apple Developer License to install an app on real phone. But you can still enter a message using the text box.
 * Click on any of the movie characters to have their tone analyzed(will save to your Cloudant DB)
 * Send a custom message(by voice or text) for analyzation then see which character your tone most aligns with