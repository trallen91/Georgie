//
//  ViewController.swift
//  Georgie2
//
//  Created by Travis Allen on 4/11/19.
//  Copyright © 2019 Travis Allen. All rights reserved.
//

import UIKit
import MessageKit
import MessageInputBar
import ApiAI
import AVFoundation

class ViewController: MessagesViewController {
    
    var messages: [Message] = []
    var member: Member!
    var georgie: Member!
    var chatService: ChatService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        member = Member(name: "Danielle", color: .blue, imgName: "Danielle")
        georgie = Member(name: "Georgie", color: .lightGray, imgName: "Blue_Georgie")
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        let welcomeMessage = Message(
            member: georgie,
            text: "Hi " + member.name + ", can I help with you budgeting, spending analysis, debt planning or something else?",
            messageId: UUID().uuidString)
        
        messages.append(welcomeMessage)
        self.messagesCollectionView.reloadData()
        
        self.navigationItem.title = "Georgie"
        self.navigationItem.backBarButtonItem?.title = "Home"
        
    }


}

extension ViewController: MessagesDataSource {
    func numberOfSections(
        in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func currentSender() -> Sender {
        return Sender(id: member.name, displayName: member.name)
    }
    
    func messageForItem(
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
    }
    
    func messageTopLabelHeight(
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 12
    }
    
    func messageTopLabelAttributedText(
        for message: MessageType,
        at indexPath: IndexPath) -> NSAttributedString? {
        
        return NSAttributedString(
            string: message.sender.displayName,
            attributes: [.font: UIFont.systemFont(ofSize: 12)])
    }
}

extension ViewController: MessagesLayoutDelegate {
    func heightForLocation(message: MessageType,
                           at indexPath: IndexPath,
                           with maxWidth: CGFloat,
                           in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
}

extension ViewController: MessagesDisplayDelegate {
    func configureAvatarView(
        _ avatarView: AvatarView,
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) {
        
        let message = messages[indexPath.section]
        let color = message.member.color
        let imgName = message.member.imgName
        avatarView.backgroundColor = color
        avatarView.image = UIImage(named: imgName)
    }
}

extension ViewController: MessageInputBarDelegate {
    func messageInputBar(
        _ inputBar: MessageInputBar,
        didPressSendButtonWith text: String) {
        
        let newMessage = Message(
            member: member,
            text: text,
            messageId: UUID().uuidString)
        
        messages.append(newMessage)
        let request = ApiAI.shared().textRequest()
        request?.query = newMessage.text
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as! AIResponse
            
            
            print(response.result.fulfillment.speech)
            if let textResponse = response.result.fulfillment.speech {
                print(response.result.fulfillment.speech)
                let responseMessage = Message(
                    member: self.georgie,
                    text:textResponse,
                    messageId: UUID().uuidString
                )
                self.messages.append(responseMessage)
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToBottom(animated: true)
            }

            

        }, failure: { (request, error) in
            print(error!)
        })
        
        ApiAI.shared().enqueue(request)
        
        inputBar.inputTextView.text = ""
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToBottom(animated: true)

    }
}

