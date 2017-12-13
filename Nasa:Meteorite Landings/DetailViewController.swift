//
//  DetailViewController.swift
//  Nasa:Meteorite Landings
//
//  Created by Oussama Ayed on 12/12/2017.
//  Copyright © 2017 Oussama Ayed. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class DetailViewController: UIViewController {
    var id = 0
    @IBOutlet weak var holder: UIView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtClass: UILabel!
    @IBOutlet weak var txtMass: UILabel!
    @IBOutlet weak var txtRec: UILabel!
    var meteorite = NSManagedObject()
    func fetchTMeteoriteById(id:Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Meteorite")
        fetchRequest.predicate = NSPredicate(format: "%K == %@","id","\(id)")
        do{
            let result = try managedContext.fetch(fetchRequest)
            
            self.meteorite = result.first! as! NSManagedObject
            
        }
        catch let error as NSError {
            print("Could not fetch \(error)")
            
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTMeteoriteById(id:id)
        let latitude = meteorite.value(forKey: "latitude") as! String
        let longitude = meteorite.value(forKey: "longitude") as! String
        print(":::::::test:::::::")
        print(latitude)
        print(longitude)
        let location = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)
        // Drop a pin
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = location
        dropPin.title = meteorite.value(forKey: "name") as? String
        map.addAnnotation(dropPin)
        map.isZoomEnabled = true
        map.showAnnotations(self.map.annotations, animated: true)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        txtName.text = "\(meteorite.value(forKey: "name") as! String)"
        txtClass.text = "RecClass : \(meteorite.value(forKey: "recclass") as! String) Name type : \(meteorite.value(forKey: "nametype") as! String)"
        txtRec.text = "Reclat : \(meteorite.value(forKey: "reclat") as! String) Reclong : \(meteorite.value(forKey: "reclong") as! String)"
        txtMass.text = "Mass : \(meteorite.value(forKey: "mass") as! String) Fall : \(meteorite.value(forKey: "fall") as! String)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
