//
//  ProgramaTableViewController.swift
//  MiProfesor
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//

import UIKit

class ProgramaTableViewController: UITableViewController {
    
    //MARK: - Properties
    var programas:[Programa] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Use the edit button item provided by the table view controller.
        //navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = editButtonItem
        
        programas = [Programa]()
        
        // Load any saved meals, otherwise load sample data.
        loadProgramas()
        
        if programas.isEmpty {
            let foto1 = UIImage(named: "ImageDefault")
            let univ1 = Programa(nombre: "Ing sistemas", descripcion: "un ing muy chevere", idUniversidad: "1", foto: foto1)!
            programas.append(univ1)
            
            let foto2 = UIImage(named: "ImageDefault")
            let univ2 = Programa(nombre: "ing electronica", descripcion: "a lo grande", idUniversidad: "2", foto: foto2)!
            programas.append(univ2)
            
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
        return programas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ProgramaTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as! ProgramaTableViewCell
        
        // Fetch the appropriate meal for the data source layout.
        let programa:Programa = programas[indexPath.row]
        
        cell.nombreLabel.text = programa.nombre
        cell.fotoImage.image = programa.foto
        cell.descripcionLabel.text = programa.descripcion
        
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
            
            programas.remove(at: indexPath.row)
            
            // Save the meals
            saveProgramas()
            
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
    
    @IBAction func unwindToProgramaList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as?
            ProgramaViewController, let programa = sourceViewController.programa{
            
            // If the user has been selected a row in the table view
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing programa.
                programas[selectedIndexPath.row] =  programa
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else {
                // Add a new programa.
                let newIndexPath = NSIndexPath(row: programas.count, section: 0)
                programas.append(programa)
                tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
            }
            // Save the programas
            saveProgramas()
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let programaDetailViewController = segue.destination as!
            ProgramaViewController
            // Get the cell that generated this segue.
            if let selectedMealCell:ProgramaTableViewCell = sender as? ProgramaTableViewCell {
                let indexPath = tableView.indexPath(for: selectedMealCell)!
                let selectedMeal = programas[indexPath.row]
                programaDetailViewController.programa = selectedMeal
            }
        }else if segue.identifier == "AddItem"{
            print("Adding new meal.")
        }
    }
    
    // MARK: persistencia
    
    func saveProgramas() {
        /* let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
         if !isSuccessfulSave {
         print("Failed to save meals...")
         }*/
    }
    
    func loadProgramas() {
        //GestorProgramas().obtenrprogramas(callback: imprimirUni)
    }
    
    func imprimirUni(programas:[Programa]){
        self.programas = programas
        self.tableView.reloadData()
        for item:Programa in programas {
            print("nombre de la u: "+item.nombre)
        }
    }
}
