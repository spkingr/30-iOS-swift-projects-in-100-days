//
// Created by 刘庆文 on 2-7.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import Foundation
import UIKit

class PageViewController:UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource
{
    static let STORYBOARD_ID = "IDUIPageViewController"
    
    @IBOutlet weak var pageControl:UIPageControl!
    @IBOutlet weak var buttonNext:UIButton!
    
    var pageData:[PageData]!
    
    private var pageViewController: UIPageViewController!
    private var currentIndex = 0
    private var pendingIndex:Int? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        self.view.addSubview(self.pageViewController.view)
        self.view.sendSubview(toBack: self.pageViewController.view)
        
        self.pageControl.currentPage = self.currentIndex
        self.pageControl.numberOfPages = self.pageData.count
        self.buttonNext.setTitle("NEXT", for: .normal)
        
        if let startViewController = self.createPageContent(at: self.currentIndex) {
            self.pageViewController.setViewControllers([startViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func pageForward(at index: Int)
    {
        if index >= self.pageData.count || index < 0 {
            return
        }
        
        if let startViewController = self.createPageContent(at: index) {
            self.pageViewController.setViewControllers([startViewController], direction: .forward, animated: true, completion: nil)
            
            self.currentIndex = index
            self.pageControl.currentPage = index
            self.buttonNext.setTitle(index == self.pageData.count - 1 ? "DONE" : "NEXT", for: .normal)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        return self.createPageContent(at: self.currentIndex + 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        return self.createPageContent(at: self.currentIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [ UIViewController ])
    {
        let pageViewController = pendingViewControllers.first as? PageContentViewController
        self.pendingIndex = pageViewController?.index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [ UIViewController ], transitionCompleted completed: Bool)
    {
        if completed, let index = self.pendingIndex {
            self.currentIndex = index
            self.pageControl.currentPage = index
            self.buttonNext.setTitle(index == self.pageData.count - 1 ? "DONE" : "NEXT", for: .normal)
        }
    }
    
    private func createPageContent(at index: Int) -> PageContentViewController?
    {
        if index < 0 || index >= self.pageData.count {
            return nil
        }
        
        if let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: PageContentViewController.STORYBOARD_ID) as? PageContentViewController {
            //Cannot assign index here, for this action is asynchronized!!
            //self.currentIndex = index
            //self.buttonNext.setTitle(index == self.pageCount - 1 ? "DONE" : "NEXT", for: .normal)
            
            pageContentViewController.index = index
            pageContentViewController.pageContent = self.pageData[index]
    
            return pageContentViewController
        }
        
        return nil
    }
    
    @IBAction func onButtonNextAction(_ sender: AnyObject?)
    {
        if self.currentIndex == self.pageData.count - 1 {
            UserDefaults.standard.set(true, forKey: MainViewController.KEY_HAS_WALK_THROUGH)
            self.dismiss(animated: true)
        } else {
            self.pageForward(at: self.currentIndex + 1)
        }
    }
}

class PageContentViewController:UIViewController
{
    static let STORYBOARD_ID = "IDPageContentViewController"
    
    @IBOutlet weak var labelTitle:UILabel!
    @IBOutlet weak var labelInfo:UILabel!
    @IBOutlet weak var imageContent:UIImageView!
    
    var index:Int? = nil
    var pageContent:PageData!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.labelTitle.text = self.pageContent.title
        self.labelInfo.text = self.pageContent.info
        self.imageContent.image = UIImage(named: self.pageContent.image)
    }
}