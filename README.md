# Vapor Stripe Provider

![Swift](https://img.shields.io/badge/swift-5-lightgrey.svg?style=for-the-badge)
![Vapor](https://img.shields.io/badge/vapor-4-lightgrey.svg?style=for-the-badge)
[![CircleCI](https://circleci.com/gh/vapor-community/stripe-provider.svg?style=svg)](https://circleci.com/gh/vapor-community/stripe-provider)

[Stripe][stripe_home] is a payment platform that handles credit cards, bitcoin and ACH transfers. They have become one of the best platforms for handling payments for projects, services or products.

## Getting Started
In your `Package.swift` file, add the following

~~~~swift
.package(url: "https://github.com/vapor-community/stripe-provider.git", from: "2.2.0")
~~~~

Register the config and the provider in `configure.swift`
~~~~swift
let config = StripeConfig(productionKey: "sk_live_1234", testKey: "sk_test_1234")

services.register(config)
try services.register(StripeProvider())
~~~~

And you are all set. Interacting with the API is quite easy from any route handler.
~~~~swift

struct ChargeToken: Content {
    var stripeToken: String
}

func chargeCustomer(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
    return try req.content.decode(ChargeToken.self).flatMap { charge in
        return try req.make(StripeClient.self).charge.create(amount: 2500, currency: .usd, source: charge.stripeToken).map { stripeCharge in
            if stripeCharge.status == .success {
                return .ok
            } else {
                print("Stripe charge status: \(stripeCharge.status.rawValue)")
                return .badRequest
            }
        }
    }
}
~~~~

And you can always check the documentation to see the required paramaters for specific API calls.

## JS Stripe integration

Also make sure to check out stripes documenation to add the client JS magic [here]( https://stripe.com/docs/checkout#integration-simple) or [here](https://stripe.com/docs/checkout#integration-custom)

## Whats Implemented

### Core Resources
* [x] Balance
* [x] Charges
* [x] Customers
* [x] Customer Tax IDs
* [x] Disputes  
* [ ] Events
* [x] File Links
* [x] File Uploads
* [x] PaymentIntents
* [x] Payouts
* [x] Products
* [x] Refunds
* [x] Tokens
---
### Payment Methods
* [x] Payment Methods
* [x] Bank Accounts
* [x] Cards
* [x] Sources
---
### Checkout
* [x] Sessions
---
### Billing
* [x] Coupons
* [x] Discounts
* [x] Invoices
* [x] Invoice Items
* [x] Tax Rates
* [x] Credit Notes
* [x] Products
* [x] Plans
* [x] Subscriptions
* [x] Subscription items
* [x] Usage Records
---
### Connect
* [x] Account
* [x] Application Fee Refunds
* [x] Application Fees
* [x] Country Specs
* [x] External Accounts
* [x] Persons
* [x] Top-ups
* [x] Transfers
* [x] Transfer Reversals
---
### Fraud
* [x] Reviews
* [x] Value Lists
* [x] Value List Items
---
### Issuing
* [x] Authorizations
* [x] Cardholders
* [x] Cards
* [x] Disputes
* [x] Transactions
---
### Terminal
* [x] Connection Tokens
* [x] Locations
* [x] Readers
---
### Orders
* [x] Orders
* [x] Order Items
* [x] Returns
* [x] SKUs
* [x] Ephemeral Keys
---
### Sigma
* [x] Scheduled Queries
---
### Webhooks
* [ ] Webhook Endpoints

[stripe_home]: http://stripe.com "Stripe"
[stripe_api]: https://stripe.com/docs/api "Stripe API Endpoints"

## License

Vapor Stripe Provider is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Want to help?
Feel free to submit a pull request whether it's a clean up, a new approach to handling things, adding a new part of the API, or even if it's just a typo. All help is welcomed! 😀
