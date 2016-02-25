//
//  Message.swift
//  FirebaseChat
//
//  Created by Alexander Blokhin on 25.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import Foundation
import JSQMessagesViewController


class Message : NSObject, JSQMessageData {
    var text_: String
    var sender_: String
    var date_: NSDate
    var imageUrl_: String?
    
    convenience init(text: String?, sender: String?) {
        self.init(text: text, sender: sender, imageUrl: nil)
    }
    
    init(text: String?, sender: String?, imageUrl: String?) {
        self.text_ = text!
        self.sender_ = sender!
        self.date_ = NSDate()
        self.imageUrl_ = imageUrl
    }
    
    func text() -> String! {
        return text_;
    }
    
    func sender() -> String! {
        return sender_;
    }
    
    func date() -> NSDate! {
        return date_;
    }
    
    func imageUrl() -> String? {
        return imageUrl_;
    }
    
    
    func senderId() -> String! {
        return NSProcessInfo.processInfo().globallyUniqueString // ??????????
        
    }
    

    func senderDisplayName() -> String! {
        return "test"
    }
    

    func isMediaMessage() -> Bool {
        return false
    }
    
    /**
     *  @return An integer that can be used as a table address in a hash table structure.
     *
     *  @discussion This value must be unique for each message with distinct contents.
     *  This value is used to cache layout information in the collection view.
     */
    func messageHash() -> UInt {
        return 0 /// ?????????????????
    }
}





