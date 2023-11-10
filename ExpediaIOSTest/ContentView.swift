//
//  ContentView.swift
//  ExpediaIOSTest
//
//  Created by Diego Martinez on 09/11/23.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTIES
    @State private var city: City?
    @State private var searchText = ""
    
    //MARK: - BODY
    var body: some View {

        ZStack(alignment: .top) {
            if let city = city{
                CityWeatherView(city: city)
            }
                HStack{
                    TextField("Enter city name", text: $searchText)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 10)
                        .onSubmit {
                            self.searchCity()
                        }
                    
                    Button {
                        resignFirstResponder()
                        self.searchCity()
                    }label: {
                        Text("Search")
                            .foregroundColor(.white)
                    }
                }
                .padding()
            .padding(.top, 20)
            
            
        }
        .onAppear{
            self.searchCity()
        }
    }
    
    func resignFirstResponder() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
    
    func searchCity(){
        Services.getCityWeather(city: searchText.isEmpty ? "London" : searchText, onResult: { result in
            print("get city weather respose: \(result)")
            switch result {
            case .success(let city):
                self.city = city
            case .serverError(let err):
                print(err)
            case .networkError(let err):
                print(err)
            }
        })
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
