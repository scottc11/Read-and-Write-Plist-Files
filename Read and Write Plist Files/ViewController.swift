//
//  ViewController.swift
//  Read and Write Plist Files
//
//  Created by Scott Campbell on 2015-04-16.
//  Copyright (c) 2015 Apress. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    // TUTORIAL:  http://rebeloper.com/read-write-plist-file-swift/
    
    // THE KEY THING TO NOTE ABOUT SAVING TO A PLIST IS YOU CAN'T ACTUALLY CHANGE AN EXISTING PLIST FILE, YOU CAN ONLY VIEW IT.  SO TO CHANGE IT, YOU HAVE TO COPY THAT PLIST FILES CONTENTS, AND THEN CREATE A NEW PLIST FILE WITH THE SAME FILE PATH / NAME
    
    
    let BedroomFloorKey: NSString = "BedroomFloor"
    let BedroomWallKey: NSString = "BedroomWall"
    let addThisKey: NSString = "addThis"
    
    var addThisID: AnyObject = 81
    var bedroomFloorID: AnyObject = 101
    var bedroomWallID: AnyObject = 101

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadGameData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGameData() {
        // Getting Path to GameData.plist
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as String
        let path = documentsDirectory.stringByAppendingPathComponent("GameData.plist")
        let fileManager = NSFileManager.defaultManager()
        
        // Check if file exists
        
        if (!fileManager.fileExistsAtPath(path)) {
            // if file doesn't exist, copy it from the default file in the bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("GameData", ofType: "plist") {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath) // assigning constant as the dictionary in plist
                println("Bundle GameData.plist is --> \(resultDictionary?.description)")
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
                println("copy")
                
            } else {
                println("GameData.plist not found. Please make sure it is part of the bundle")
            }
            
        } else {
            println("GameData.plist already exits at path.")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }
        
        // THIS IS WHERE YOU ACCESS THE PLIST FILES CONTENTS
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Loaded GameData.plist file is --> \(resultDictionary?.description)")
        var myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict {
            // loading values of plist into variables
            
            bedroomFloorID = dict.objectForKey(BedroomFloorKey)!// same as next line of code (i think)
            bedroomWallID = dict.objectForKey(BedroomWallKey)!
            
        }
    }
    
    // SAVE BUTTON
    @IBAction func saveButtonTapped(sender: AnyObject) {
        bedroomFloorID = 881
        saveGameData()
    }

    //CODE FOR SAVING THE VALUES INTO THE PLIST
    func saveGameData() {
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as NSString // same as paths[0]
        let path = documentsDirectory.stringByAppendingPathComponent("GameData.plist")
        var dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]

        // SAVING VALUES - (add your own code here)
        println("-----the dictionary-----")
        println(dict)

        dict.setObject(bedroomFloorID, forKey: BedroomFloorKey)
        dict.setObject(bedroomWallID, forKey: BedroomWallKey)
        
        // WRITING TO PLIST FILE
        dict.writeToFile(path, atomically: false)
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Saved GameData.plist file is --> \(resultDictionary?.description)")
        
        
    }

}

