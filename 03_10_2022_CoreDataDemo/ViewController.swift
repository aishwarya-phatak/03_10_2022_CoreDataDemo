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
        //insertData()
        
        retriveEmployeeRecords()
        print("================")
        //updateEmployeeRecord()
        retriveEmployeeRecords()
        print("================")
        deleteEmployeeRecord()
        retriveEmployeeRecords()
        print("================")
        
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
    
    func retriveEmployeeRecords(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        
        do{
            let fetchResult = try managedContext.fetch(fetchRequest)
            
            for eachFetchResult in fetchResult as! [NSManagedObject]{
                print("The employee record \(eachFetchResult.value(forKey: "empName"))")
            }
        } catch {
            print("Failed to extract Employee Records")
        }
    }
    
    func updateEmployeeRecord(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequestQueryForUpdate : NSFetchRequest<NSFetchRequestResult> =
        NSFetchRequest<NSFetchRequestResult>.init(entityName: "Employee")
        
        fetchRequestQueryForUpdate.predicate = NSPredicate(format: "empName = %@","Employee -1")
        
        do{
            let employeeObjects = try managedContext.fetch(fetchRequestQueryForUpdate)
            let employeeObject = employeeObjects[0] as! NSManagedObject
            employeeObject.setValue("Employee - 4", forKey: "empName")
            employeeObject.setValue(4, forKey: "empId")
            employeeObject.setValue(27004.23, forKey: "empSalary")
        } catch {
            print("Failed to update Employee Record")
        }
    }
    
    func deleteEmployeeRecord(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequestForDelete : NSFetchRequest<NSFetchRequestResult> =
        NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        
        fetchRequestForDelete.predicate = NSPredicate(format: "empName = %@","Employee -3")
        do{
            let employees = try managedContext.fetch(fetchRequestForDelete)
            let employeeRecordToBeDeleted = employees[0] as! NSManagedObject
            managedContext.delete(employeeRecordToBeDeleted)
            
            do{
                try managedContext.save()
            } catch {
                print("error")
            }
            
        } catch {
            print("Employee Record Deletion Falied")
        }
    }
}
