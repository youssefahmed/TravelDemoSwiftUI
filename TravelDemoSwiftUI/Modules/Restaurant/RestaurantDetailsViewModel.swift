//
//  RestaurantDetailsViewModel.swift
//  TravelDemoSwiftUI
//
//  Created by youssef on 10/11/2022.
//

import Foundation

class RestaurantDetailsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var details: RestaurantDetails?
    
    init() {
        func getResturant() {
            let baseUrl = NetworkConstants.BaseUrl.rawValue
            guard let url = URL(string: baseUrl + NetworkConstants.Apis.restaurant.rawValue) else { fatalError("Missing URL") }
            
            let urlRequest = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
                guard let data = data else { return }
                do {
                    let details = try JSONDecoder().decode(RestaurantDetails.self, from: data)
                    self.details = details
                    print("Completion handler decodedFood", details)
                } catch {
                    print("Error decoding", error)
                }
            }
            
            dataTask.resume()
        }
    }
}
