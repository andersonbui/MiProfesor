//
//  EstudianteTableViewController.swift
//  MiProfesor
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//

import UIKit

class EstudianteTableViewController: UITableViewController {
    
    //MARK: - Properties
    var estudiantes:[Estudiante] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Use the edit button item provided by the table view controller.
        //navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = editButtonItem
        
        estudiantes = [Estudiante]()
        
        // Load any saved meals, otherwise load sample data.
        loadEstudiantes()
        
        if estudiantes.isEmpty {
            let foto1 = UIImage(named: "ImageDefault")
            let univ1 = Estudiante(codigo: "001", nombre: "Juan Dia", celular: "123", email: "ansd@", semestre: "2", foto: foto1, usr: "juan", pass: "juan", idP: "1")!
            estudiantes.append(univ1)
            
            let foto2 = UIImage(named: "ImageDefault")
            let univ2 = Estudiante(codigo: "002", nombre: "Luis Rivera", celular: "1254", email: "12345", semestre: "2", foto: foto2, usr: "luis", pass: "luis", idP: "2")!
            estudiantes.append(univ2)
            
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
        return estudiantes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EstudianteTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as! EstudianteTableViewCell
        
        // Fetch the appropriate meal for the data source layout.
        let estudiante:Estudiante = estudiantes[indexPath.row]
        
        cell.nombreLabel.text = estudiante.nombre
        cell.fotoImage.image = estudiante.foto
        cell.codigoLabel.text = estudiante.codigo
        
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
            
            estudiantes.remove(at: indexPath.row)
            
            // Save the meals
            saveEstudiantes()
            
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
    
    @IBAction func unwindToEstudianteList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as?
            EstudianteViewController, let estudiante = sourceViewController.estudiante{
            
            // If the user has been selected a row in the table view
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing estudiante.
                estudiantes[selectedIndexPath.row] =  estudiante
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else {
                // Add a new estudiante.
                let newIndexPath = NSIndexPath(row: estudiantes.count, section: 0)
                estudiantes.append(estudiante)
                tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
            }
            // Save the estudiantes
            saveEstudiantes()
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let estudianteDetailViewController = segue.destination as!
            EstudianteViewController
            // Get the cell that generated this segue.
            if let selectedMealCell:EstudianteTableViewCell = sender as? EstudianteTableViewCell {
                let indexPath = tableView.indexPath(for: selectedMealCell)!
                let selectedMeal = estudiantes[indexPath.row]
                estudianteDetailViewController.estudiante = selectedMeal
            }
        }else if segue.identifier == "AddItem"{
            print("Adding new meal.")
        }
    }
    
    // MARK: persistencia
    
    func saveEstudiantes() {
        /* let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
         if !isSuccessfulSave {
         print("Failed to save meals...")
         }*/
    }
    
    func loadEstudiantes() {
        //GestorEstudiantes().obtenrestudiantes(callback: imprimirUni)
    }
    
    func imprimirUni(estudiantes:[Estudiante]){
        self.estudiantes = estudiantes
        self.tableView.reloadData()
        for item:Estudiante in estudiantes {
            print("nombre de la u: "+item.nombre)
        }
    }
}
