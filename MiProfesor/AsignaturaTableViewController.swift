//
//  AsignaturaTableViewController.swift
//  MiProfesor
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//

import UIKit

class AsignaturaTableViewController: UITableViewController {
    
    //MARK: - Properties
    var asignaturas:[Asignatura] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Use the edit button item provided by the table view controller.
        //navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = editButtonItem
        
        asignaturas = [Asignatura]()
        
        // Load any saved meals, otherwise load sample data.
        loadAsignaturas()
        
        if asignaturas.isEmpty {
            let foto1 = UIImage(named: "ImageDefault")
            let univ1 = Asignatura(nombre: "Desarrollo de app moviles", descripcion: "desarrollo de app moviles", semestre: 6, foto: foto1)!
            asignaturas.append(univ1)
            
            let foto2 = UIImage(named: "ImageDefault")
            let univ2 = Asignatura(nombre: "base de datos", descripcion: "base de datos", semestre: 4, foto: foto2)!
            asignaturas.append(univ2)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return asignaturas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "AsignaturaTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as! AsignaturaTableViewCell
        
        // Fetch the appropriate meal for the data source layout.
        let asignatura:Asignatura = asignaturas[indexPath.row]
        
        cell.nombreLabel.text = asignatura.nombre
        cell.fotoImage.image = asignatura.foto
        
        cell.descripcionLabel.text = asignatura.descripcion
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            asignaturas.remove(at: indexPath.row)
            
            // Save the meals
            saveAsignaturas()
            
            // Deleted the corresponding row  from the table view
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    @IBAction func unwindToAsignaturaList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as?
            AsignaturaViewController, let asignatura = sourceViewController.asignatura{
            
            // If the user has been selected a row in the table view
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing asignatura.
                asignaturas[selectedIndexPath.row] =  asignatura
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else {
                // Add a new asignatura.
                let newIndexPath = NSIndexPath(row: asignaturas.count, section: 0)
                asignaturas.append(asignatura)
                tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
            }
            // Save the asignaturas
            saveAsignaturas()
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let asignaturaDetailViewController = segue.destination as!
            AsignaturaViewController
            // Get the cell that generated this segue.
            if let selectedMealCell:AsignaturaTableViewCell = sender as? AsignaturaTableViewCell {
                let indexPath = tableView.indexPath(for: selectedMealCell)!
                let selectedMeal = asignaturas[indexPath.row]
                asignaturaDetailViewController.asignatura = selectedMeal
            }
        }else if segue.identifier == "AddItem"{
            print("Adding new meal.")
        }
    }
    
    // MARK: persistencia
    
    func saveAsignaturas() {
        /* let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
         if !isSuccessfulSave {
         print("Failed to save meals...")
         }*/
    }
    
    func loadAsignaturas() {
        //GestorAsignaturas().obtenrasignaturas(callback: imprimirUni)
    }
    
    func imprimirUni(asignaturas:[Asignatura]){
        self.asignaturas = asignaturas
        self.tableView.reloadData()
        for item:Asignatura in asignaturas {
            print("nombre de la u: "+item.nombre)
        }
    }
}
