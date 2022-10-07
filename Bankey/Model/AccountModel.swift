//
//  AccountModel.swift
//  Bankey
//
//  Created by HanaTI on 2022/10/07.
//

import Foundation

enum AccountType: String, Codable {
    case Banking
    case CreditCard
    case Investment
}

struct AccountModel: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
}
