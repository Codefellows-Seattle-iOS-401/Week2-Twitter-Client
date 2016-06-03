#Week 2 - Class 3
##Homework
* Setup your cells with auto layout so you can see the entire tweets text. If you get any .... at the end that is probably twitters API being stupid
* Create a 2nd view controller that shows an individual tweet in detail
* Upon clicking a tweet, your interface should push (which means you need a navigation controller) to the 2nd view controller and display the tweet selected, but with a few caveats:
* If the tweet that was selected is a retweet, show the original tweet and the original user
* All of this information is available in the original JSON, you just have to go digging for it, and then add properties to your Tweet class accordingly.
* Create a ProfileViewController that when presented, shows the logged in user's profile information. Utilize the NavigationBar to add a button to present this new viewController.

###Reading Assignment:
* Apple Documentation:
  * [Auto Layout](https://developer.apple.com/library/watchos/documentation/UserExperience/Conceptual/AutolayoutPG/Introduction/Introduction.html)
  * [UIActivityIndicator](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIActivityIndicatorView_Class/index.html)
  * [UINavigationController](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UINavigationController_Class/index.html)
  * [UIStoryboardSegue](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIStoryboardSegue_Class/)
  * [NSLayoutConstraint](https://developer.apple.com/library/mac/documentation/AppKit/Reference/NSLayoutConstraint_Class/index.html)

##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/000rVCPV9Ae_QmwKtCm-I-XHw#Week2-Class3)
