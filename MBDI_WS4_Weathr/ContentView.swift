//
//  ContentView.swift
//  MBDI_WS4_Weathr
//
//  Created by Tim Kaerts on 22/03/2022.
//

import SwiftUI

struct ContentView: View {
    let locationSize: CGFloat = 60
    let degreeSize: CGFloat = 120
    @State var weatherData: WeatherData?
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=s-Hertogenbosch&appid=3b7c0bb2df5778f696d6dfc53b6189c9&units=metric"
    
    var body: some View {
        VStack {
            Spacer()
            Text("Den Bosch")
                .font(.custom("Helvetica Neue UltraLight", size: locationSize))
            Text(getTemperatureString())
                .font(.custom("Helvetica Neue UltraLight", size: degreeSize))
            Spacer()
        }
        .onAppear(perform: loadData)
        .background(Image("Lenticular_Cloud").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea())
    }
    
    func loadData() {
        guard let url = URL(string: urlString) else {
            print("ERROR: failed to construct a URL from string")
            return
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("ERROR: fetch failed: \(error.localizedDescription)")
                    return
                }
                guard let data = data else {
                    print("ERROR: failed to get data from URLSession")
                    return
                }
                do {
                    newWeatherData = try JSONDecoder().decode(weatherData.self, from: data)
                } catch let error as NSError {
                    print("ERROR: decoding. In domain= \(error.domain), description \(error.localizedDescription)")
                }
                if newWeatherData == nil {
                    print("ERROR: failed to read or decode data.")
                    return
                }
                self.weatherData = newWeatherData
             }
            task.resume()
        }
    }
    func getTemperatureString()-> String {
        return "? C"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
