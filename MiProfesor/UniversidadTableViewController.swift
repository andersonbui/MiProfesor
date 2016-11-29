//
//  UniversidadTableViewController.swift
//  MiProfesor
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//

import UIKit

class UniversidadTableViewController: UITableViewController {

    //MARK: - Properties
    var universidades:[Universidad] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Use the edit button item provided by the table view controller.
        //navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = editButtonItem
        
        universidades = [Universidad]()
        
        // Load any saved meals, otherwise load sample data.
        loadUniversidades()
        
        if universidades.isEmpty {
            let foto1 = UIImage(named: "ImageDefault")
            let univ1 = Universidad(nombre: "unicauca", descripcion: "universidad del cauca", foto: foto1)!
            universidades.append(univ1)
            
            let foto2 = UIImage(named: "ImageDefault")
            let univ2 = Universidad(nombre: "univalle", descripcion: "universidad del valle", foto: foto2)!
            universidades.append(univ2)

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
        return universidades.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "UniversidadTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as! UniversidadTableViewCell
        
        // Fetch the appropriate meal for the data source layout.
        let universidad:Universidad = universidades[indexPath.row]
        
        cell.nombreLabel.text = universidad.nombre
        cell.fotoUIImage.image = universidad.foto
        
        cell.descripcionLabel.text = universidad.descripcion
 
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
            
            universidades.remove(at: indexPath.row)
            
            // Save the meals
            saveUniversidades()
            
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
    
    @IBAction func unwindToUniversidadList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as?
            UniversidadViewController, let universidad = sourceViewController.universidad{
            
            // If the user has been selected a row in the table view
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing universidad.
                universidades[selectedIndexPath.row] =  universidad
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else {
                // Add a new universidad.
                let newIndexPath = NSIndexPath(row: universidades.count, section: 0)
                universidades.append(universidad)
                tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
            }
            // Save the universidades
            saveUniversidades()
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let universidadDetailViewController = segue.destination as!
            UniversidadViewController
            // Get the cell that generated this segue.
            if let selectedMealCell:UniversidadTableViewCell = sender as? UniversidadTableViewCell {
                let indexPath = tableView.indexPath(for: selectedMealCell)!
                let selectedMeal = universidades[indexPath.row]
                universidadDetailViewController.universidad = selectedMeal
            }
        }else if segue.identifier == "AddItem"{
            print("Adding new meal.")
        }
    }
    
    // MARK: persistencia
    
    func saveUniversidades() {
       /* let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }*/
    }
    
    func loadUniversidades() {
        GestorUniversidades().obtenruniversidades(callback: imprimirUni)
    }
    
    func imprimirUni(universidades:[Universidad]){
        self.universidades = universidades
        self.tableView.reloadData()
        for item:Universidad in universidades {
            print("nombre de la u: "+item.nombre)
        }
    }
}
