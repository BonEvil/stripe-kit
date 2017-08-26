//
//  Coupon.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

import Foundation
import Vapor
import Helpers

/**
 Coupon Model
 https://stripe.com/docs/api/curl#coupon_object
 */
public final class Coupon: StripeModelProtocol {
    public private(set) var id: String?
    public private(set) var amountOff: Int?
    public private(set) var currency: StripeCurrency?
    public private(set) var duration: StripeDuration?
    public private(set) var durationInMonths: Int?
    public private(set) var maxRedemptions: Int?
    public private(set) var percentOff: Int?
    public private(set) var redeemBy: Date?
    public private(set) var object: String?
    public private(set) var created: Date?
    public private(set) var timesRedeemed: Int?
    public private(set) var isValid: Bool?
    public private(set) var isLive: Bool?
    
    /**
     Only metadata is mutable/updatable.
     https://stripe.com/docs/api/curl#update_coupon
     */
    public private(set) var metadata: Node?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.amountOff = try node.get("amount_off")
        self.created = try node.get("created")
        
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        
        if let duration = node["duration"]?.string {
            self.duration = StripeDuration(rawValue: duration)
        }
        self.object = try node.get("object")
        self.durationInMonths = try node.get("duration_in_months")
        self.isLive = try node.get("livemode")
        self.maxRedemptions = try node.get("max_redemptions")
        self.metadata = try node.get("metadata")
        self.percentOff = try node.get("percent_off")
        self.redeemBy = try node.get("redeem_by")
        self.timesRedeemed = try node.get("times_redeemed")
        self.isValid = try node.get("valid")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "amount_off": self.amountOff,
            "created": self.created,
            "currency": self.currency,
            "duration": self.duration,
            "duration_in_months": self.durationInMonths,
            "livemode": self.isLive,
            "max_redemptions": self.maxRedemptions,
            "metadata": self.metadata,
            "percent_off": self.percentOff,
            "redeem_by": self.redeemBy,
            "times_redeemed": self.timesRedeemed,
            "valid": self.isValid
        ]
        
        return try Node(node: object)
    }
}
