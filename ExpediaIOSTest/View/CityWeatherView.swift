//
//  CityWeatherView.swift
//  ExpediaIOSTest
//
//  Created by Diego Martinez on 09/11/23.
//

import SwiftUI

struct CityWeatherView: View {
    //MARK: - PROPERTIES
    var city: City
    @State var isFahrenheit: Bool = false
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                VStack (spacing: 10) {
                    VStack(spacing: 0) {
                        // CITY: NAME
                        Text(city.location.name)
                            .foregroundColor(.white)
                            .font(.system(size: 60))
                            .fontWeight(.medium)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                        
                        // CITY: LOCAL TIME
                        Text(city.location.localtime)
                            .foregroundColor(.white)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .frame(maxWidth: 480)
                        
                        
                    }

                    // CITY: TEMP
                    Text(isFahrenheit ? "\(String(format: "%.0f", city.current.temp_f)) ºF" : "\(String(format: "%.0f", city.current.temp_c)) ºC")
                        .foregroundColor(.white)
                        .font(.system(size: 80))
                        .fontWeight(.regular)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                    
                    
                    HStack {
                        
                        // CITY: ICON IMAGE
                        AsyncImage(
                            url: URL(string: "https:" + city.current.condition.icon),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 60, maxHeight: 60)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                        
                        // CITY: CONDITION TEXT
                        Text(city.current.condition.text)
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .multilineTextAlignment(.center)
                    }
                    
                }
                
                // OPTION: CHANGE DEGREES
                Toggle("Show Fahrenheit Degrees", isOn: $isFahrenheit)
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                .padding(20)
            }

            

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: (Bool(truncating: city.current.is_day as NSNumber) ? [Color.blue, Color.cyan] : [Color.black, Color.gray])), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleCity = City(
            location: Location(
                name : "London",
                region : "City of London, Greater London",
                country : "United Kingdom",
                tz_id : "Europe/London",
                localtime : "2023-11-09 18:37",
                lat : 51.52,
                lon : -0.11,
                localtime_epoch : 1699555068
            ),
            current: Current(
                last_updated_epoch : 1699554600,
                is_day : 0,
                wind_degree : 260,
                humidity : 81,
                cloud : 50,
                vis_km : 10,
                vis_miles : 6,
                uv : 1,
                last_updated : "2023-11-09 18:30",
                wind_dir : "W",
                temp_c : 8,
                temp_f : 46.4,
                wind_mph : 9.4,
                wind_kph : 15.1,
                pressure_in : 29.35,
                pressure_mb : 994,
                feelslike_c : 5,
                feelslike_f : 40.9,
                gust_mph : 17.6,
                gust_kph : 28.3,
                precip_mm : 2.53,
                precip_in : 0.1,
                condition: Condition(
                    text : "Moderate rain",
                    icon : "//cdn.weatherapi.com/weather/64x64/night/302.png",
                    code : 1189
                )
            )
        )
        CityWeatherView(city: exampleCity)
            .previewLayout(.fixed(width: 320, height: 640))
    }
}
