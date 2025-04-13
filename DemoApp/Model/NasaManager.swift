//
//  NasaManager.swift
//  Manager class for connection to the Nasa API
//  DemoApp
//
//  Created by Raul Humberto Juliao Colina on 10/04/25.
//
import Foundation

protocol NasaManagerDelegate{
    func didGetPhotos(_ nasaManager: NasaManager, photos: NasaModel)
    func didFailWithError(error: Error)
}

struct NasaManager {
    let nasaURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"
    let apiKey = "3BKXf7KfxfaCz6B61XmuTyJ3jYZcfBiO9memTqOU"
    
    var delegate: NasaManagerDelegate?
    //Create the URL and pass a date value
    func fetchPhotos (date: String?){
        if let dateValue = date {
            let urlString = "\(nasaURL)?earth_date=\(dateValue)&api_key=\(apiKey)"
            print(urlString)
            performRequest(with: urlString)
        }
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let photos = self.parseJSON(safeData) {
                        self.delegate?.didGetPhotos(self, photos: photos)
                        //print(photos)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ roversData: Data) -> NasaModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(RoverPhotos.self, from: roversData)
            if decodedData.photos.count != 0 {
                print(decodedData.photos[0].camera.name)
                let id = decodedData.photos[0].id
                let rName = decodedData.photos[0].rover.name
                let imgUrl = decodedData.photos[0].imgSrc
                let name = decodedData.photos[0].camera.fullName
                let earthDate = decodedData.photos[0].earthDate
                let lanDate = decodedData.photos[0].rover.landingDate
                let launDate = decodedData.photos[0].rover.launchDate
                
                let nasa = NasaModel(id: id, roverName: rName, earthDate: earthDate, imgURL: imgUrl, fullName: name, landingDate: lanDate, launchDate: launDate)
                
                return nasa
            }
            else {
                print("No data found")
                return nil
            }
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
