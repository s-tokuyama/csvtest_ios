//
//  ViewController.swift
//  csvtest
//
//  Created by 徳山晋一 on 2017/01/07.
//  Copyright © 2017年 徳山晋一. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func TouchDown(_ sender: Any) {
        
        let now = NSDate() // 現在日時の取得
        let fileNameFormat = DateFormatter()
        fileNameFormat.dateFormat = "yyyyMMdd_HHmm" // 日付フォーマットの設定
        let fileNameTimeStr = fileNameFormat.string(from: now as Date)

        var data: String = ""
        let NEWLINE = "\r\n"
        
        data += "あああ,aaa,cc" + NEWLINE
        data += "あああ,aaa,cc" + NEWLINE
        data += "あああ,aaa,cc" + NEWLINE
        data += "あああ,aaa,cc" + NEWLINE
        data += "あああ,aaa,cc" + NEWLINE
        
        let dir : NSString = NSTemporaryDirectory() as NSString
        let csvFile = "aaaa_\(fileNameTimeStr).csv"
        let csvFilePath = dir.appendingPathComponent(csvFile);

        do {
            try data.write(toFile: csvFilePath, atomically: true, encoding: String.Encoding.shiftJIS)
            //try data.write(toFile: csvFilePath, atomically: true, encoding: String.Encoding.utf8)
        } catch {
        }
        
        var urlList: [NSURL] = []
        urlList.append(NSURL(fileURLWithPath: csvFilePath))
        let activityVC = UIActivityViewController(activityItems: urlList, applicationActivities: nil)
        activityVC.completionWithItemsHandler = {
            (s, ok, items, error) in
            do{
                try FileManager.default.removeItem(atPath: csvFilePath)
            } catch {
            }
        }
        
        // 使用しないアクティビティタイプ
        let excludedActivityTypes = [
            UIActivityType.openInIBooks,
            UIActivityType.print,
            UIActivityType.copyToPasteboard,
            UIActivityType.assignToContact,
            UIActivityType.saveToCameraRoll,
            UIActivityType.addToReadingList,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            UIActivityType.postToWeibo,
            UIActivityType.postToTencentWeibo,
        ]
        
        activityVC.excludedActivityTypes = excludedActivityTypes
        
        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)

    }
}

