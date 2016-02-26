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
    var senderId_: String
    var senderDisplayName_: String
    var date_: NSDate
    var imageUrl_: String?
    
    convenience init(text: String?, senderId: String?, senderDisplayName: String?) {
        self.init(text: text, senderId: senderId, senderDisplayName: senderDisplayName, imageUrl: nil)
    }
    
    init(text: String?, senderId: String?, senderDisplayName: String?, imageUrl: String?) {
        self.text_ = text!
        self.senderId_ = senderId!
        self.senderDisplayName_ = senderDisplayName!
        self.date_ = NSDate()
        self.imageUrl_ = imageUrl
    }
    
    func text() -> String! {
        return text_;
    }
    
    func date() -> NSDate! {
        return date_;
    }
    
    func imageUrl() -> String? {
        return imageUrl_;
    }
    
    
    func senderId() -> String! {
        return senderId_
        
    }
    

    func senderDisplayName() -> String! {
        return senderDisplayName_
    }
    

    func isMediaMessage() -> Bool {
        return false
    }
    
    
    func messageHash() -> UInt {
        //let contentHash = self.isMediaMessage() ? self.image_?.hash : self.text_.hash
        let contentHash = self.text_.hash
        return UInt(abs(self.senderId_.hash ^ self.date_.hash ^ contentHash))
    }
}





