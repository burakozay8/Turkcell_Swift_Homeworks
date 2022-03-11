//
//  LifeCyclesViewController.swift
//  Week-5
//
//  Created by Burak Ozay on 7.02.2022.
//

import UIKit

class LifeCyclesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("ViewController - viewDidLoad")
        
//        You Can do Some common task in this method :
//        1.Network call which need Once.
//        2.User Interface
//        3.Others Task Those are Need to do Once
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ViewController - viewWillAppear")
        
//        This Method is called every time before the view are visible to and before any animation are configured .In this method view has bound but orientation not set yet.You can override this method to perform custom tasks associated with displaying the view such as to hide fields or disable actions before the view becomes visible.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("ViewController - viewDidAppear")
        
//        This Method is called after the view present on the screen. Usually save data to core data or start animation or start playing a video or a sound, or to start collecting data from the network This type of task good for this method.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("ViewController - viewWillDisappearAppear")
        
//        This method called before the view are remove from the view hierarchy.The View are Still on view hierarchy but not removed yet . any unload animations haven’t been configured yet. Add code here to handle timers, hide the keyboard, cancel network requests, revert any changes to the parent UI. Also, this is an ideal place to save state.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("ViewController - viewDidDisappear")
        
//        This method is called after the VC’s view has been removed from the view hierarchy. Use this method to stop listening for notifications or device sensors.
    }
    

}
