# 30-iOS-swift-projects-in-100-days
30 iOS projects with Swift in my next 100 days

***
## 06.Photo Picker

*Date: 2017-10-05*

![ProjectPhotoPicker.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/06.Photo%20Picker/ProjectPhotoPicker.gif)

What I learned from this demo:

* Work with static cells in static table view
* Use container view (UIContainerView) to embed other view
* Specify user permissions in the Info.plist file
* Deal with the focus of UITextField, with `becomeFirstResponder()` and the implementation of `UITextFieldDelegate` protocol, return `true` in `textFieldShouldReturn(_ textField: UITextField) -> Bool` method
* Try to use camera and photo library with image picker

***
## 05.Detail Table View

*Date: 2017-09-03*

![ProjectDetailTableView.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/05.Detail%20Table%20View/ProjectDetailTableView.gif)

What I learned from this demo:

* Pass data from one view to another through segue
* Work with custom view controller and embed them in the navigation controller
* Customize the swipe action menus of table view cells
* Multiple lines for `UILabel` (set lins to 0 in storyboard), customize the navigation bar item (the code should be placed in main `ViewController`, not the detail view controller), and remove the blanks between top bar and table view (uncheck the **Adjust Scroll View Insets** in view controller)

***
## 04.Basic Table View

*Date: 2017-09-02*

![ProjectBasicTableView.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/04.Basic%20Table%20View/ProjectBasicTableView.gif)

What I learned from this demo:

* Basic table view and the simple custom cell
* Display local data, add or edit local data and refresh the table
* Use `UIAlertController` with text field and deal with the response of alert actions
* Change the constrains of the table view in the view container by storyboard

***
## 03.Tip Calculator

*Date: 2017-08-26*

![ProjectTipCalculator.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/03.Tip%20Calculator/ProjectTipCalculator.gif)

What I learned from this demo:

* Swift extensions, double to string format, computed values
* Multiple stack view to build more flexible layout
* Use the slider, and give it the value change response handler
* Add custom UIToolBar to the number keyboard, set clear button and keyboard type
* Deal with the focus of UITextField, and enable or disable the other elements

***
## 02.Tap Hold Counter

*Date: 2017-08-20*

![ProjectTapHoldCounter.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/02.Tap%20Hold%20Counter/ProjectTapHoldCounter.gif)

What I learned from this demo:

* Swift property delegations: willSet/didSet
* Detect Tap and Long Press Gestures on buttons
* Multiple actions on one button: `addGestureRecognizer`

***
## 01.Tap Counter

*Date: 2017-08-17*

![ProjectTapCounter.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/01.Tap%20Counter/ProjectTapCounter.gif)

What I learned from this demo:

* Build a basic interface with Button/Label/NavigationBar/BarButtomItem
* AutoLayout basics: Stack View and Constrains
* The keywords: @IBOutlet/@IBAction/weak
* I now upload the projects to Github via git on my Macbook

**What inspires me is the project: [100 Days of Swift](http://samvlu.com/)**
