//
//  ViewController.swift
//  ContainerViewExam
//
//  Created by Beaconyx Corp. on 2018. 2. 8..
//  Copyright © 2018년 Beaconyx Corp. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var subView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupView()
        updateView()
    }
    
    private func setupView(){
        setupSegmentedControl()
    }
    
    private func setupSegmentedControl(){
        self.segmentedControl.removeAllSegments()
        self.segmentedControl.insertSegment(withTitle: "Summary", at: 0, animated: false)
        self.segmentedControl.insertSegment(withTitle: "Sessions", at: 1, animated: false)
        self.segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
        self.segmentedControl.selectedSegmentIndex = 0
    }
    
    private lazy var summaryViewController: SummaryViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SummaryVC") as! SummaryViewController
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var sessionsViewController: SessionsViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SessionsVC") as! SessionsViewController
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    //segment 값이 변경되었을때
    @objc func selectionDidChange(_ sender: UISegmentedControl){
        updateView()
    }
    
    private func add(asChildViewController viewController: UIViewController){
        addChildViewController(viewController)
        subView.addSubview(viewController.view)
        
        viewController.view.frame = self.subView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController){
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    private func updateView(){
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: sessionsViewController)
            add(asChildViewController: summaryViewController)
        }
        else{
            remove(asChildViewController: summaryViewController)
            add(asChildViewController: sessionsViewController)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

