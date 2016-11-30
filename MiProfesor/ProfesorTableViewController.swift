//
//  ProfesorTableViewController.swift
//  MiProfesor
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//

import UIKit

class ProfesorTableViewController: UITableViewController {
    
    //MARK: - Properties
    var profesores:[Profesor] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Use the edit button item provided by the table view controller.
        //navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = editButtonItem
        
        profesores = [Profesor]()
        
        // Load any saved meals, otherwise load sample data.
        loadProfesores()
        
        if profesores.isEmpty {
            let foto1 = UIImage(named: "ImageDefault")
            let univ1 = Profesor(nombre: "Pedro Valdez", referencia: "ninguna", calificacion: 5, idAsignatura: "1", foto: foto1)!
            profesores.append(univ1)
            
            let foto2 = UIImage(named: "ImageDefault")
            let univ2 = Profesor(nombre: "Juan Luis Guerra", referencia: "A lo macho pecho puludo", calificacion: 2, idAsignatura: "2", foto: foto2)!
            profesores.append(univ2)
            
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
        return profesores.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ProfesorTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as! ProfesorTableViewCell
        
        // Fetch the appropriate meal for the data source layout.
        let profesor:Profesor = profesores[indexPath.row]
        
        cell.nombreLabel.text = profesor.nombre
        cell.fotoImage.image = profesor.foto
        cell.referenciaLabel.text = profesor.referencia
        
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
            
            profesores.remove(at: indexPath.row)
            
            // Save the meals
            saveProfesores()
            
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
    
    @IBAction func unwindToProfesorList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as?
            ProfesorViewController, let profesor = sourceViewController.profesor{
            
            // If the user has been selected a row in the table view
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing profesor.
                profesores[selectedIndexPath.row] =  profesor
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else {
                // Add a new profesor.
                let newIndexPath = NSIndexPath(row: profesores.count, section: 0)
                profesores.append(profesor)
                tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
            }
            // Save the profesores
            saveProfesores()
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let profesorDetailViewController = segue.destination as!
            ProfesorViewController
            // Get the cell that generated this segue.
            if let selectedMealCell:ProfesorTableViewCell = sender as? ProfesorTableViewCell {
                let indexPath = tableView.indexPath(for: selectedMealCell)!
                let selectedMeal = profesores[indexPath.row]
                profesorDetailViewController.profesor = selectedMeal
            }
        }else if segue.identifier == "AddItem"{
            print("Adding new meal.")
        }
    }
    
    // MARK: persistencia
    
    func saveProfesores() {
        /* let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
         if !isSuccessfulSave {
         print("Failed to save meals...")
         }*/
    }
    
    func loadProfesores() {
        //GestorProfesores().obtenrprofesores(callback: imprimirUni)
    }
    
    func imprimirUni(profesores:[Profesor]){
        self.profesores = profesores
        self.tableView.reloadData()
        for item:Profesor in profesores {
            print("nombre de la u: "+item.nombre)
        }
    }
}
