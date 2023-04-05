//
//  ViewController.swift
//  TableStory
//
//  Created by Villafuerte Langford, Mateo on 3/22/23.
//

import UIKit
import MapKit

let data = [
    Item(name: "The Getty Villa", address: "17985 E Pacific Coast Hwy", location: "Pacific Palisades, CA 90272", desc: "The Getty Villa is one of two galleries built by oil tycoon J. Paul Getty in 1954. Just east of the city limits of Malibu in the Pacific Palisades neighborhood lays a collection of 44,000 Greek, Roman, and Etruscan antiquities.", type: "Historical, Art Museum", url: "www.getty.edu", lat: 34.0459, long: -118.5649, imageName: "GETTY"),
    
    Item(name: "Los Angeles County Museum of Art", address: "5905 Wilshire Blvd", location: "Los Angeles, CA 90036", desc: "Take a picture with the iconic \"Urban Lights\" by artist Chris Burden and dive into the revolving art exhibits at LACMA. Make it an all-day affair by taking advantage of the on-site dining options, or visit neighboring museums--all at walking distance.", type: "Art Museum", url: "www.lacma.org", lat: 34.0639, long: -118.3592, imageName: "LACMA"),
    
    Item(name: "\"Hi, How Are You\" Mural", address: "408 W 21st St", location: "Austin, TX 78705", desc: "If you thought Austin lost its \"weird,\" Jeremiah the Frog reminds visitors and locals that it has not. Painted by musician Daniel Johnston in 1993 in exchange for $70 and vinyl records, it has stood multiple attempts at demolition and remains an Austin favorite. ", type: "Mural", url: "www.hihowareyou.org", lat: 30.2839, long: -97.7422, imageName: "HI"),
    
    Item(name: "Wynwood Walls", address: "2516 NW 2nd Ave", location: "Miami, FL 33127", desc: "Labeled as \"Miami's Original Street Art Museum,\" the Wynwood Walls has hosted over 100 artists from 21 countries. This urban revitalization project rewrites the definition of modern art.", type: "Mural, Art Museum", url: "www.thewynwoodwalls.com", lat: 25.801, long: -80.1994, imageName: "WYNWOOD"),
    
    Item(name: "Pérez Art Museum Miami", address: "1103 Biscayne Blvd", location: "Miami FL, 33132", desc: "Highlighting Miami's diverse culture, the Exhibitions at the Pérez Art Museum showcase modern and contemporary art. Enjoy an app-guided tour, or dive into the Art Stations to practice your artist skills.", type: "Art Museum", url: "www.pamm.org", lat: 25.7859, long: -80.1862, imageName: "PEREZ"),
    
    Item(name: "The Vizcaya Museum and Gardens", address: "3251 S Miami Ave", location: "Miami, FL 33129", desc: "This restored early 20th-century estate once belonged to businessman James Deering. Resting in Coconut Grove in Miami, Florida, this National Historic Landmark is full of antiques and one-of-a-kind art pieces from all over the world.", type: "Museum, Garden", url: "www.vizcaya.org", lat: 25.7444, long: -80.2105, imageName: "VIZCAYA"),
    
    Item(name: "Broadway: Al Hirschfeld Theatre", address: "302 W 45th St", location: "New York, NY 10036", desc: "Described by The New York Times as \"the only theater in America made in Byzantine fashion,\" this Broadway theater specializes in breath-taking performances. Enjoy musical talents from multiple performers in \"Moulin Rouge! The Musical.\"", type: "Theatre", url: "www.broadway.com", lat: 40.759261, long: -73.989201, imageName: "BROADWAY")
]

struct Item {
    var name: String
    var address: String
    var location: String
    var desc: String
    var type: String
    var url: String
    var lat: Double
    var long: Double
    var imageName: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      
      let image = UIImage(named: item.imageName)
                   cell?.imageView?.image = image
                   cell?.imageView?.layer.cornerRadius = 10
                   cell?.imageView?.layer.borderWidth = 5
                   cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      
      return cell!
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "ShowDetailSegue" {
                  if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                      // Pass the selected item to the detail view controller
                      detailViewController.item = selectedItem
                  }
              }
          }
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
               //let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
               //let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
               //mapView.setRegion(region, animated: true)
               
            // loop through the items in the dataset and place them on the map
                for item in data {
                   let annotation = MKPointAnnotation()
                   let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                   annotation.coordinate = eachCoordinate
                       annotation.title = item.name
                       mapView.addAnnotation(annotation)
                       }
        
        // Do any additional setup after loading the view.
    }


}
