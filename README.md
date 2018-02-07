# 30-iOS-swift-projects-in-100-days
30 iOS projects with Swift in my next 100 days(next server months or years maybe)


***
## 17.Walkthrough Pages

*Date: 2018-2-7*

![ProjectWalkthroughPages.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/17.Walkthrough%20Pages/ProjectWalkthroughPages.gif)

What I learned from this demo:

* Work with protocals: `UIPageViewControllerDelegate` and `UIPageViewControllerDataSource` to build `UIPageViewController`
* Use `NSLayoutConstraint` to do the animation of controls
* Instantiate view controllers by `UIStoryboard`

**PS. This project supports one solution to the animation problems in the previous project: *10.Basic Animation* by using the `NSLayoutConstraint` in layout.**

***
## 16.Flickr Recent Photos

*Date: 2018-1-26*

![ProjectFlickrRecentPhotos.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/16.Flickr%20Recent%20Photos/ProjectFlickrRecentPhotos.gif)

What I learned from this demo:

* Deal with the errors in Swift with `enum` types and `Error` protocol
* Solve the problem of wrong image place in `UIImageView` while reuse the cells in table view
* Save image file to file system with `UIImageJPEGRepresentation` and `FileManager`
* Use `UIActivityIndicatorView` to preload images

***
## 15.Json Data Presenter

*Date: 2018-1-24*

![ProjectJsonDataTable.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/15.Json%20Data%20Presenter/ProjectJsonDataTable.gif)

What I learned from this demo:

* Load `json` data from server and parse it to local data class
* Work with `URLRequest`, `URLQueryItem` and `URLComponents` to fetch network data
* Initialize data in `AppDelegate` through view controller

**PS: For the reason of reusable of cells, the image will not be correctly presented in the expected `UIImageView`, but I have solved this in my next app.**

***
## 14.Save Data To File

*Date: 2018-1-20*

![ProjectLocalFileData.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/14.Local%20Data%20Saving/ProjectLocalFileData.gif)

What I learned from this demo:

* Create object with `NSObject` and `NSCoding` protocol
* Save encoded object to local file with `FileManager` and `NSKeyedArchiver`
* Understand the basic knowledge of the app's life circle
* Work with `Date`, `DateFormatter`, `tableView.deleteRows`, and `editButtonItem`

***
## 13.Pure Code App

*Date: 2018-1-18*

![ProjectPureCodeApp.png](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/13.Pure%20Code%20Project/ProjectPureCodeApp.png)

What I learned from this demo:

* Delete and get rid of the storyboard, just add code in `AppDelegate` to install views
* Pure code for custom table view cell class, override the `init` function to do initialization
* Add the simple `UILabel` to the content view of the table view cell
* Code for the simplest constrains(**I notice that, you should constrain the label to the `self.view` but not to the content view!**)

***
## 12.Simple Image Viewer

*Date: 2018-1-15*

![ProjectSimpleImageViewer.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/12.Simple%20Image%20Viewer/ProjectSimpleImageViewer.gif)

What I learned from this demo:

* Use the `UIScrollView` with `ImageView` to scale image
* Simple usage of the `NumberFormatter`, and the lazy property definition
* Add Tap Gesture Recogizer to the main view in Interface Builder to deal with keyboard dismiss

***
## 11.Simple Network Image View

*Date: 2017-12-30*

![ProjectNetworkImage.gif](https://github.com/spkingr/30-iOS-swift-projects-in-100-days/raw/master/11.Network%20Image%20View/ProjectNetworkImage.gif)

What I learned from this demo:

* Load and display image from server by using `URLSession`
* Deal with the response, data and error of the network connection result
* Switch from net thread to the main thread to control the UI elements through `DispatchQueue`

**I cannot load image from the `non-https` URL, so add the property `Allow Arbitrary Loads` under `App Transport Security Settings`, set the value as `YES`.**

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
