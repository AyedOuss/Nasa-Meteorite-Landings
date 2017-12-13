//
//  ViewController.swift
//  Nasa:Meteorite Landings
//
//  Created by Oussama Ayed on 12/12/2017.
//  Copyright © 2017 Oussama Ayed. All rights reserved.
//
import CoreData
import UIKit
import SwiftSpinner
class ViewController: UIViewController,UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    var meterorites = [NSManagedObject]()
     var sortedMeterorites = [NSManagedObject]()
    func getMeteorites()  {
        
        // If you plan to use Backendless Media Service, uncomment the following line (iOS ONLY!)
        // backendless.mediaService = MediaService()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let dataHelp = DataHelper(context: managedContext)
        dataHelp.seedMeteorites()
        
        
    }
    func fetchMeteorites()  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Meteorite")
        do{
            let result = try managedContext.fetch(fetchRequest)
            
            self.meterorites = result as! [NSManagedObject]
            
        }
        catch let error as NSError {
            print("Could not fetch \(error)")
            
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
    
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        
        if (currentReachabilityStatus == .reachableViaWiFi || currentReachabilityStatus == .reachableViaWWAN){
            if !UserDefaults.standard.bool(forKey: "HasLaunchedOnce") {
                UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
                UserDefaults.standard.synchronize()
                getMeteorites()
                
            }
            fetchMeteorites()
        }else {
            fetchMeteorites()
            if (meterorites.count == 0 ){
               
                let alert = UIAlertController(title: "No Network?!", message: "You need network connection for the first start to get data from Nasa", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction!) -> Void in
                    exit(0)
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                }
                
            }
        
        
        
        print(meterorites.count)
        for result in meterorites {
            print("\(result.value(forKey: "longitude"))")
        }
        tableView.dataSource = self
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meterorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath) //1.
        sortedMeterorites = meterorites.sorted(by: { (a, b) -> Bool in
            let m1 = a.value(forKey: "mass") as! String
            let m2 = b.value(forKey: "mass") as! String
            let mass1 = Double(m1)
            let mass2 = Double(m2)
            return mass1 as! Double>mass2 as! Double
        })
        let meteorite = sortedMeterorites[indexPath.row] //2.
        
        let lblName:UILabel = cell.viewWithTag(1) as! UILabel
        lblName.text = meteorite.value(forKey: "name") as? String
        let lblYear:UILabel = cell.viewWithTag(2) as! UILabel
        let y = meteorite.value(forKey: "year") as? String
        let ys = String(describing: y!.prefix(4))
        lblYear.text = "Year : \(ys)"
        
        return cell //4.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? DetailViewController {
            //do something you want
            let path = self.tableView.indexPathForSelectedRow!
            print("path : \(path.row)")
            let selectedRow:NSManagedObject = sortedMeterorites[path.row]
            destination.id = selectedRow.value(forKey: "id") as! Int
            
        }
    }

}

