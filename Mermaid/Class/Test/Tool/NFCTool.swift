//
//  NFCTool.swift
//  Mermaid
//
//  Created by 蔡晓东 on 2020/9/11.
//  Copyright © 2020 claudechoi. All rights reserved.
//

import UIKit
import CoreNFC

class NFCTool: NSObject {
    
    // timeout:60s , limit:only single one session
    var session: NFCNDEFReaderSession?
    
    override init() {
        super.init()
        
    }
    
    func startup() {
        self.session?.invalidate()
        
        if NFCNDEFReaderSession.readingAvailable {
            session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
            session!.alertMessage = "把卡放到手机后面"
            session!.begin()
        } else {
            print("此设备不支持NFC")
        }
    }
    
}

extension NFCTool: NFCNDEFReaderSessionDelegate {
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        guard !messages.isEmpty else { return }
        
        for message in messages {
            for payload in message.records {
                let typeName = payload.typeNameFormat
                let data = payload.payload
                let type = payload.type
                let identifier = payload.identifier
                print("TypeName:\(typeName) data:\(data) type:\(type) identifier:\(identifier)")
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("读取NFC失败  \(error.localizedDescription)")
    }
    
}
