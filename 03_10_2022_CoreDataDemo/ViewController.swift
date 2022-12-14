//
//  ViewController.swift
//  03_10_2022_CoreDataDemo
//
//  Created by Vishal Jagtap on 14/12/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertData()
    }
    
    func insertData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
       
        let employeeEntity = NSEntityDescription.entity(forEntityName: "Employee", in: managedContext)
        
        for i in 1...3{
            let employee = NSManagedObject(entity: employeeEntity!, insertInto: managedContext)
            employee.setValue(i, forKey: "empId")
            employee.setValue("Employee -\(i)", forKey: "empName")
            employee.setValue((i * 25000), forKey: "empSalary")
        }
        do{
            try managedContext.save()
        } catch let error as NSError{
            print("The data cannot be saved - \(error)")
        }
    }
    
}
