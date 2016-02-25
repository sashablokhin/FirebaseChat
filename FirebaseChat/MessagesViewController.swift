//
//  MessagesViewController.swift
//  FirebaseChat
//
//  Created by Alexander Blokhin on 25.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class MessagesViewController: JSQMessagesViewController {
    
    var user: FAuthData?
    
    var messages = [Message]()
    var avatars = Dictionary<String, UIImage>()
    
    var outgoingBubbleImageView = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    
    var incomingBubbleImageView = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
    
    var senderImageUrl: String!
    var batchMessages = true
    var ref: Firebase!
    
    /*
    func setup() {
        self.senderId = UIDevice.currentDevice().identifierForVendor?.UUIDString
        self.senderDisplayName = UIDevice.currentDevice().identifierForVendor?.UUIDString
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        senderId = user?.uid
        senderDisplayName = user?.providerData["email"] as! String
        
        inputToolbar!.contentView!.leftBarButtonItem = nil
        automaticallyScrollsToMostRecentMessage = true
        navigationController?.navigationBar.topItem?.title = "Logout"
        
        /*
        sender = (sender != nil) ? sender : "Anonymous"
        let profileImageUrl = user?.providerData["cachedUserProfile"]?["profile_image_url_https"] as? NSString
        if let urlString = profileImageUrl {
            setupAvatarImage(sender, imageUrl: urlString as String, incoming: false)
            senderImageUrl = urlString as String
        } else {
            setupAvatarColor(sender, incoming: false)
            senderImageUrl = ""
        }
        
        setupFirebase()*/
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionView!.collectionViewLayout.springinessEnabled = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if ref != nil {
            ref.unauth()
        }
    }

}
