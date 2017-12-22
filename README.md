# 30-iOS-swift-projects-in-100-days
30 iOS projects with Swift in my next 100 days

My wish list:
1. CollectionView with header, edit, rearranges
2. Asynchronized works
3. Sticky section headers and jumpbar
4. Images handler
5. Custom Animations
6. ?


***
## 10.Basic Animation

*Date: 2017-12-22*

![ProjectBasicAnimation.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/10.Basic%20Animation/ProjectBasicAnimation.gif)

What I learned from this demo:

* The basic animation with the controls in iOS
* Show or hide the navigation bar or bar items in code
* Use computed data or properties in swift
* Understand the method `viewWillAppear` and `viewDidAppear` for controlling the animation logic

**I found a problem that the position of controls in `viewWillAppear` cannot move, even thought the value is changed! However if you put the code in `viewDidAppear` then the controls will move, but, the animation looks wried!!! So, I have to hide(set alpha=0.0) and then move them in `viewDidAppear`, why this happens(the auto layout is not the reason!)?**
```swift
override func viewWillAppear(_ animated: Bool)
{
    super.viewWillAppear(animated)

    print(self.labelHeading.center.x) //result is 147.5, all right.
    self.labelHeading.center.x -= self.view.bounds.width //no movement happens!
    print(self.labelHeading.center.x) //is -227.5, OK, but no changes on the screen, why???
}
override func viewDidAppear(_ animated: Bool)
{
    super.viewDidAppear(animated)

    self.labelHeading.center.y -= self.view.bounds.height //the control moves here!
}
```

***
## 09.Editable Table View

*Date: 2017-12-19*

![ProjectEditableTableView.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/09.Editable%20Table%20View/ProjectEditableTableView.gif)

What I learned from this demo:

* Change the edit mode in `UITableView`, use the method `setEditing(_, animated:)`
* Rearrange the table view cell items in edit mode
* Dynamicly change the title of the bar button item
* Add text filed to the alert, and deal with the text result

***
## 08.Basic Collection View

*Date: 2017-10-21*

![ProjectCollectionView.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/08.Collection%20View/ProjectCollectionView.gif)

What I learned from this demo:

* Work with collection view, within more than one columns
* Delete items in collection view through `UILongPressGestureRecognizer` and `UIAlertController` and `IndexPath` in collection view
* Extension with `UICollectionViewDelegateFlowLayout`, override the important **optional** methods
* Try to use circular images in code:

```swift
cell.imageTitle.layer.cornerRadius = cell.imageTitle.bounds.height * 0.5
cell.imageTitle.clipsToBounds = true
```

***
## 07.Pull To Refresh Table View

*Date: 2017-10-14*

![ProjectRefreshTableView.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/07.Refresh%20Table%20View/ProjectRefreshTableView.gif)

What I learned from this demo:

* Add refresh control to achieve pull-to-refresh and reload data in table view
* Override `numberOfSections(in : UITableView)` function to change the default appearance of empty table view
* Set title and add navigation bar items in swift code

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
