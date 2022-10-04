//
//  AccountSummaryViewModel.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/30.
//

import Foundation
import UIKit

struct AccountModel {
    enum AccountType: String {
        case Banking
        case CreditCard
        case Investment
    }
    let accountType: AccountType
    let accountName: String
    let balance: Decimal
}


class AccountViewModel {
    
    let balanceFormatter = BalanceFormatter()
    var accounts: [AccountModel] = []
    var count: Int {
        return accounts.count
    }
    
    struct Account {
        let accountType: String
        let accountName: String
        let accountColor: UIColor
        let balnaceName: String
        let balnce: NSAttributedString
    }
    
    func fetchData() {
        let savings = AccountModel(accountType: .Banking, accountName: "Basic Savings", balance: 929466.23)
        let chequing = AccountModel(accountType: .Banking, accountName: "No-Fee All-In Chequing", balance: 17562.44)
        let visa = AccountModel(accountType: .CreditCard, accountName: "Visa Avion Card", balance: 412.83)
        let masterCard = AccountModel(accountType: .CreditCard, accountName: "Student Mastercard", balance: 50.83)
        let investment1 = AccountModel(accountType: .Investment, accountName: "Tax-Free Saver", balance: 2000.00)
        let investment2 = AccountModel(accountType: .Investment, accountName: "Growth Fund", balance: 15000.00)
        
        accounts = [savings, chequing, visa, masterCard, investment1, investment2]
    }
    
    func getAccount(by index: IndexPath) -> Account {
        let target = accounts[index.row]
        let accountType: String
        let accountColor: UIColor
        var balanceName = "Current Balance"
        switch target.accountType {
        case .Banking:
            accountType = "Banking"
            accountColor = appColor
        case .CreditCard:
            accountType = "Credit Card"
            accountColor = .systemGreen
        case .Investment:
            accountType = "Account type"
            accountColor = .systemPink
            balanceName = "Value"
        }
        let balnce = balanceFormatter.makeFormateBalnace(balnce: target.balance)
        let account = Account(accountType: accountType, accountName: target.accountName, accountColor: accountColor, balnaceName: balanceName, balnce: balnce)
        return account
    }
    
}

