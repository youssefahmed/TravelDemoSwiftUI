//
//  DestinationDetailsViewModel.swift
//  TravelDemoSwiftUI
//
//  Created by youssef on 10/11/2022.
//

import Foundation

class DestinationDetailsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var destinationDetails: DestinationDetails?
    
    init(name: String) {
        // lets make a network call
//        let name = "paris"
        let fixedUrlString = "https://travel.letsbuildthatapp.com/travel_discovery/destination?name=\(name.lowercased())".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: fixedUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            // make sure to check your err & resp
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    
                    self.destinationDetails = try JSONDecoder().decode(DestinationDetails.self, from: data)
                    
                } catch {
                    print("Failed to decode JSON,", error)
                }
            }
        }.resume()
    }
    
}
