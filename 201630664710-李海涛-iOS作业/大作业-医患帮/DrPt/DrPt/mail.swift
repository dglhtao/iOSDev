//
//  mail.swift
///  TableView
//
//  Created by 李海涛 on 2018/11/6.
//  Copyright © 2019年 李海涛. All rights reserved.
//


import os.log
//此为swift文件，非cocotouchfile
import UIKit

//NSCoding用于持久化数据，是一种协议protocol
class mail: NSObject, NSCoding {
    
    var name: String?
    var mail: String?
    var photo: UIImage?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("maillList")
    
    init(inputName: String?, inputMail: String?, inputPhoto: UIImage?){
        self.name = inputName
        self.mail = inputMail
        self.photo = inputPhoto
    }
    
    // MARK:NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(mail, forKey: PropertyKey.mail)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
    
    //The required modifier means this initializer must be implemented on every subclass, if the subclass defines its own initializers.
    //The convenience modifier means that this is a secondary initializer, and that it must call a designated initializer from the same class.
    //The question mark (?) means that this is a failable initializer that might return nil.
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Mail object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let mail = aDecoder.decodeObject(forKey: PropertyKey.mail) as? String else {
            os_log("Unable to decode the name for a Mail object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        // Must call designated initializer.
        self.init(inputName: name, inputMail: mail, inputPhoto: photo)
        
    }
    
    
    struct PropertyKey {
        
        static let name = "nameKey"
        static let mail = "mailKey"
        static let photo = "photoKey"
        
    }
    
    
}
