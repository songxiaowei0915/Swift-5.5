//
//  File.swift
//  
//
//  Created by 宋小伟 on 2022/10/31.
//

import Foundation

actor BankAccount {
    let number: Int
    var balance: Double
    var owners: [Person]
    var isOpen: Bool = true
    
    init(number: Int, balance: Double, owners: [Person]) {
        self.number = number
        self.balance = balance
        self.owners = owners
    }
}

extension BankAccount {
    func deposit(amount: Double) -> Double {
        balance += amount
        sleep(1)
        return balance
    }
}

extension BankAccount {
    enum BankError: Error {
        case insufficientFunds
        case alreadyClosed
    }
}

extension BankAccount {
    func close() async throws -> Void {
        if isOpen {
            await Bank().requestToClose(self.number)
            
            if isOpen {
                isOpen = false
            }
            else {
                throw BankError.alreadyClosed
            }
        }
        else {
            throw BankError.alreadyClosed
        }
    }
}

extension BankAccount {
    func primaryOwner() -> Person {
        return owners[0]
    }
}

//extension BankAccount {
//    @available(iOS 13.0, *)
//    func secondaryOwners() async -> [Person] {
//        if #available(iOS 13.0, *) {
//            return await Task.detached {
//                await self.owners.filter {
//                    $0.name != self.owners[0].name
//                }
//            }.value
//        } else {
//            // Fallback on earlier versions
//        }
//    }
//}

