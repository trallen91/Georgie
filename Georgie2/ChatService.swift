//
//  ChatService.swift
//  Georgie2
//
//  Created by Travis Allen on 4/11/19.
//  Copyright © 2019 Travis Allen. All rights reserved.
//

import Foundation
import Scaledrone

class ChatService {
//    private let scaledrone: Scaledrone
    private let messageCallback: (Message)-> Void
    
//    private var room: ScaledroneRoom?
    
    init(member: Member, onRecievedMessage: @escaping (Message)-> Void) {
        self.messageCallback = onRecievedMessage
//        self.scaledrone = Scaledrone(
//            channelID: "YOUR-CHANNEL-ID",
//            data: member.toJSON)
//        scaledrone.delegate = self
    }
//
//    func connect() {
//        scaledrone.connect()
//    }
}
