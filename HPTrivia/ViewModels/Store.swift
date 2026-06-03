//
//  Store.swift
//  HPTrivia
//
//  Created by Muhammad on 03/06/26.
//

import StoreKit

@MainActor
@Observable
class Store {
    var products: [Product] = []
    var purchased: Set<String> = []
    
    private var updates: Task<Void, Never>? = nil
    
    // Load available products
    func loadProducts() async {
        do {
            products = try await Product.products(for: ["hp4", "hp5", "hp6", "hp7"])
            products.sort {
                $0.displayName < $1.displayName
            }
        } catch {
            print("❌ Unable to load products: \(error)")
        }
    }
    
    // Purchase a product
    
    // Check for purchased products
    
    // Conntect with App Store to watch for purchase and transaction updates
}
