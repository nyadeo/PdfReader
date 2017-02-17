//
//  QuickLookViewController.swift
//  AssProject
//
//  Created by DEO NYAMPETA on 2/12/17.
//  Copyright © 2017 DEO NYAMPETA. All rights reserved.
//

import UIKit
import QuickLook
class QuickLookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,QLPreviewControllerDelegate,QLPreviewControllerDataSource {

    @IBOutlet weak var tableView: UITableView!
    var fileURLs = [NSURL]()
    let quickLookController = QLPreviewController()
    let book =  ["Designing and Implementing Linux Firewalls and QoS.pdf","Expert_Python_programming.pdf","exploit-writing-tutorial-part-9-introduction-to-win32-shellcoding.pdf","Foundations of Python Network Programming, 2nd Edition.pdf","Gray_hat_Python.pdf","Hacking Exposed Malware and Rootkits.pdf","Advanced Network Programming - Principles and Techniques.pdf","An Introduction to Network Programming with Java.pdf","Apress.Beginning.Android.ADK.with.Arduino.Mar.2012.pdf","Arduino - Reference.pdf","Beginning Linux Programming, 4th Edition.pdf","beginning_java_ee_6_with_glassfish_3_2nd_edition.pdf","Building Android Accessories using the Open Accessory Development Kit and Arduino Presentation 1.pdf","Capture_Troubleshooting.pdf","cprogramming_tutorial.pdf","obj.pdf"]
    let color = UIColor.blue

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "PDF Reader"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.quickLookController.delegate = self
        self.quickLookController.dataSource = self
        prepareFileURLs()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    
    func setInteriorColor(_ color: UIColor!){
    
    
    }

    func prepareFileURLs() {
        for file in book {
            let fileParts = file.components(separatedBy: ".")
            if let fileURL = Bundle.main.url(forResource: fileParts[0], withExtension: fileParts[1]) {
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    fileURLs.append(fileURL as NSURL)
                }
            }
        }
    }

    func extractAndBreakFilenameInComponents(fileURL: NSURL) -> (fileName: String, fileExtension: String) {
        let fileURLParts = fileURL.path!.components(separatedBy: "/")
        let fileName = fileURLParts.last
        let filenameParts = fileName?.components(separatedBy: ".")
        
        return (filenameParts![0], filenameParts![1])
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int{
    
        return fileURLs.count;
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem{
    
        return fileURLs[index];
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileURLs.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "read", for: indexPath) as! CustomerCellTableViewCell
        let currentFileParts = extractAndBreakFilenameInComponents(fileURL: fileURLs[indexPath.row])
        
        
        cell.costomizeCell(title: currentFileParts.fileName, image: currentFileParts.fileName)
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if QLPreviewController.canPreview(fileURLs[indexPath.row]) {
            quickLookController.currentPreviewItemIndex = indexPath.row
            //navigationController?.pushViewController(quickLookController, animated: true)
            present(quickLookController, animated: true, completion: nil)
        }
    }
}
