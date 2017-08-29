//
//  DisputeList.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/12/17.
//
//

import Foundation
import Vapor

public final class DisputeList: StripeModelProtocol {
    
    public private(set) var object: String?
    public private(set) var url: String?
    public private(set) var hasMore: Bool?
    public private(set) var items: [Dispute]?
    
    public init(node: Node) throws {
        self.object = try node.get("object")
        self.url = try node.get("url")
        self.hasMore = try node.get("has_more")
        self.items = try node.get("data")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "object": self.object,
            "url": self.url,
            "has_more": self.hasMore,
            "data": self.items
        ]
        return try Node(node: object)
    }
}
