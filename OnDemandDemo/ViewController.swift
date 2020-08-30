//
//  ViewController.swift
//  OnDemandDemo
//
//  Created by Yogesh Padekar on 21/08/20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import UIKit
import QuickLook

class ViewController: UIViewController {
    private var previewController: QLPreviewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            //Download the movie resource
            ResourceRequestManager.shared.requestResourceWith(tag: "Sample", onSuccess: {
                //If download succeeds then show QLPreviewController
                DispatchQueue.main.async {
                    self.previewController = QLPreviewController()
                    self.previewController?.dataSource = self
                    self.present(self.previewController ?? QLPreviewController(), animated: true, completion: nil)
                }
                
            }, onFailure: {(error) in
                print("Error in downloading the on demand video = \(error.debugDescription)")
            })
    }
}

extension ViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let path = Bundle.main.path(forResource: "SampleVideo", ofType: "mp4") else {
            fatalError("Couldn't find the specified usdz file.")
        }
        let url = URL(fileURLWithPath: path)
        return url as QLPreviewItem
    }
}

