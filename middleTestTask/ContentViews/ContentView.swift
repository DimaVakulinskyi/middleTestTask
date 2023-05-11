//
//  ContentView.swift
//  middleTestTask
//
//  Created by Dmytro Vakulinsky on 10.05.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = VendorViewModel()
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText) { searchText in
                self.searchText = searchText
                debouncer.schedule {
                    viewModel.filterVendors(with: searchText)
                }
            }
            .padding(.top)
            
            if searchText.isEmpty || viewModel.filteredVendors.isEmpty {
                Spacer()
                NoResultsView()
                Spacer()
            } else {
                List(viewModel.filteredVendors) { vendor in
                    VendorRow(vendor: vendor)
                }
            }
        }
        .onAppear {
            viewModel.fetchVendors()
        }
        .background(Color(hex: 0xFCFCFC))
    }
    
    private let debouncer = Debouncer(delay: 0.5)
}

struct VendorRow: View {
    @StateObject private var imageLoader = ImageLoader()
    let vendor: Vendor
    
    var body: some View {
        HStack(spacing: 16) {
            if let coverPhotoURL = vendor.cover_photo.media_url {
                AsyncImage(url: coverPhotoURL) { phase in
                    switch phase {
                    case .empty:
                        PlaceholderView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        PlaceholderView()
                    @unknown default:
                        PlaceholderView()
                    }
                }
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            } else {
                PlaceholderView()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
            }
            
            Text(vendor.company_name)
        }
        .onAppear {
            if let coverPhotoURL = vendor.cover_photo.media_url {
                imageLoader.loadImage(from: coverPhotoURL)
            }
        }
    }
}


struct PlaceholderView: View {
    var body: some View {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.gray)
    }
}
