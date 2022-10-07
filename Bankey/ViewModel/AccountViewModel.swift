//
//  AccountSummaryViewModel.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/30.
//

import Foundation
import UIKit

// MARK: Protocol
protocol AccountsDelegate: AnyObject {
    func setAccounts() -> Void
}

protocol ProfileDelegate: AnyObject {
    func setProfile(profile: AccountViewModel.Profile) -> Void
}

class AccountViewModel: BaseViewModel {
    
    let balanceFormatter = BalanceFormatter()
    var accounts: [AccountModel] = []
    var count: Int {
        return accounts.count
    }
    
    var profile: ProfileModel? {
        didSet {
            if let profile = profile {
                let date = Date()
                let newProfile = Profile(welcomeText: "Good Moning", name: profile.firstName, date: date.monthDayYearString)
                profileDelegate?.setProfile(profile: newProfile)
            }
        }
    }

    weak var accountsDelegate: AccountsDelegate?
    weak var profileDelegate: ProfileDelegate?
    

    func fetchAccounts( byEndPoint endPoint: String) {
        api.fetch(byEndPoint: endPoint) { (result: Result<[AccountModel], NetworkError>) in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.accountsDelegate?.setAccounts()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchProfile(byEndPoint endPoint: String) {
        api.fetch(byEndPoint: endPoint) { (result: Result<ProfileModel, NetworkError>) in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAccountInfo(byBankType bankType: AccountType) -> (color: UIColor, balnaceName: String ) {
        let balanceName: String
        let color: UIColor
        switch bankType {
        case .Banking:
            balanceName = "Current Balance"
            color = appColor
        case .CreditCard:
            balanceName = "Current Balance"
            color = .systemGreen
        case .Investment:
            balanceName = "Value"
            color = .systemPink
        }
        
        return (color, balanceName)
    }

    func getAccount(by index: IndexPath) -> Account {
        let target = accounts[index.row]
        let accountInfo = getAccountInfo(byBankType: target.type)
        let balnce = balanceFormatter.makeFormateBalnace(balnce: target.amount)
        let account = Account(
            accountType: target.type.rawValue,
            accountName: target.name,
            accountColor: accountInfo.color,
            balnaceName: accountInfo.balnaceName,
            balnce: balnce)
        return account
    }
}


// MARK: View Data Struct
extension AccountViewModel {
    struct Account {
        let accountType: String
        let accountName: String
        let accountColor: UIColor
        let balnaceName: String
        let balnce: NSAttributedString
    }
    
    struct Profile {
        let welcomeText: String
        let name: String
        let date: String 
    }
}
