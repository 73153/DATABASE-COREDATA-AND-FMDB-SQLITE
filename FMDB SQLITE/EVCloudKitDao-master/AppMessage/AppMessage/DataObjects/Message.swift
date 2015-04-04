//
//  Message.swift
//
//  Created by Edwin Vermeer on 01-07-14.
//  Copyright (c) 2014 EVICT BV. All rights reserved.
//

import CloudKit

enum MessageTypeEnum : String {
    case Text = "T",
    Picture = "P",
    Location = "L"
}

class Message : EVCloudKitDataObject {
    // From which Channel is this message
    var From : CKReference? // = CKReference(recordID: CKRecordID(recordName: "N/A"), action: CKReferenceAction.None)
    var From_ID : String = ""
    func setFrom(id:String) {
        self.From_ID = id
        self.From = CKReference(recordID: CKRecordID(recordName: id), action: CKReferenceAction.None)
    }
    var FromFirstName : String = ""
    var FromLastName : String = ""
    
    // To what Channel or Group is this message
    var To : CKReference? // = CKReference(recordID: CKRecordID(recordName: "N/A"), action: CKReferenceAction.None)
    var To_ID : String = ""
    func setTo(id:String) {
        self.To_ID = id
        self.To = CKReference(recordID: CKRecordID(recordName: id), action: CKReferenceAction.None)
    }
    var ToFirstName : String = ""
    var ToLastName :String = ""
    
    // Message text
    var Text : String = ""
    
    // is there a (media) attachment
    var MessageType : String = MessageTypeEnum.Text.rawValue

    // From which Channel is this message
    var Asset : CKReference? // = CKReference(recordID: CKRecordID(recordName: "N/A"), action: CKReferenceAction.None)
    var Asset_ID : String = ""
    func setAsset(id:String) {
        self.Asset_ID = id
        self.Asset = CKReference(recordID: CKRecordID(recordName: id), action: CKReferenceAction.None)
    }

    var Latitude : Double = 52.8350711
    var Longitude : Double = 4.8653827
}