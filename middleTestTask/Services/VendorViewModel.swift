//
//  VendorViewModel.swift
//  middleTestTask
//
//  Created by Dmytro Vakulinsky on 10.05.2023.
//

import Foundation

class VendorViewModel: ObservableObject {
    @Published var vendors: [Vendor] = []
    @Published var filteredVendors: [Vendor] = []
    
    func fetchVendors() {
        guard let url = Bundle.main.url(forResource: "Vendor", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(VendorResponse.self, from: data)
            self.vendors = response.vendors
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func filterVendors(with text: String) {
        filteredVendors = vendors.filter { vendor in
            return vendor.company_name.localizedCaseInsensitiveContains(text)
        }
    }
}

