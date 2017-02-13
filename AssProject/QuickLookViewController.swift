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
    let book = ["Book.pdf","AppCoda-Word.docx","AppCoda-Keynote.key","AppCoda-Text.txt","AppCoda-Image.jpeg"]
    let color = UIColor.blue

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "PDF Reader"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.quickLookController.delegate = self
        self.quickLookController.dataSource = self
        prepareFileURLs()
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
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        let currentFileParts = extractAndBreakFilenameInComponents(fileURL: fileURLs[indexPath.row])
        
        cell.textLabel?.text = currentFileParts.fileName
        
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
