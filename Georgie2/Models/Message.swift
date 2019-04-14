//
//  Message.swift
//  Georgie2
//
//  Created by Travis Allen on 4/11/19.
//  Copyright © 2019 Travis Allen. All rights reserved.
//

import Foundation
import UIKit
import MessageKit

struct Member {
    let name: String
    let color: UIColor
    let imgName: String
}

struct Message {
    let member: Member
    let text: String
    let messageId: String
}

extension Message: MessageType {
    var sender: Sender {
        return Sender(id: member.name, displayName: member.name)
    }
    
    var sentDate: Date {
        return Date()
    }
    
    var kind: MessageKind {
        return .text(text)
    }
}
