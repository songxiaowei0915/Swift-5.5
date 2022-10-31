//
//  File.swift
//  
//
//  Created by 宋小伟 on 2022/10/31.
//

import Foundation

class Bank {
    var accounts: [BankAccount]
    
    init(accounts: [BankAccount] = []) {
        self.accounts = accounts
    }
    
    func filterAccount(_ criteria: @Sendable (BankAccount) -> Bool) -> [BankAccount] {
        return accounts.filter(criteria)
    }
    
    func requestToClose(_ accountNumber: Int) async {
        print("Closing account: \(accountNumber)")
    }
}
