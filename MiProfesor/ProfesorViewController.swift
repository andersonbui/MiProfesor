//
//  ViewController.swift
//  MiProfesor
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//

import UIKit

class ProfesorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK: - properties
    @IBOutlet var nombreTextField: UITextField!
    @IBOutlet var referenciaTextField: UITextField!
    @IBOutlet var calificacionTextField: UITextField!
    @IBOutlet var idAsignaturaTextField: UITextField!
    @IBOutlet weak var fotoImage: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var profesor:Profesor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // handle the text field's user input through delegate callbacks
        nombreTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let prof = profesor {
            navigationItem.title = prof.nombre
            nombreTextField.text = prof.nombre
            fotoImage.image = prof.foto
            calificacionTextField.text = String(describing: prof.calificacion)
            referenciaTextField.text = prof.referencia
            idAsignaturaTextField.text  = prof.idAsignatura

        }
        
        // Enable the save button only if the text field has a valid Meal name
        checkValidProfesorName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //hide the keyboard.
        nombreTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller thet lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        //only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        //Make sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: - UITextDieldelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //mealNameLabel.text = textField.text
        checkValidProfesorName()
        navigationItem.title = textField.text
    }
    
    func checkValidProfesorName(){
        // Disable the save button if the text field is empty.
        let text = nombreTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //set photoImageView to display the selected image
        fotoImage.image = selectedImage
        // dismiss the picker
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK:  - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view
        // controller needs to be dismissed in two different ways.
        let isPresentationInAddMealMode = presentingViewController is UINavigationController
        if isPresentationInAddMealMode {
            dismiss(animated: true, completion: nil)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    //This method lets you configure a view controller before it's presnet.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let unSender:UIBarButtonItem = sender as! UIBarButtonItem
        
        if saveButton === unSender {
            let nombre = nombreTextField.text ?? ""
            let foto = fotoImage.image
            let calificacion = Int(calificacionTextField.text ?? "0")
            let referencia = referenciaTextField.text
            let idAsignatura = idAsignaturaTextField.text  ?? ""
            
            //set the meal to be passed to MealTableViewController after the unwind segue.
            profesor = Profesor(nombre: nombre, referencia: referencia, calificacion: calificacion, idAsignatura: idAsignatura, foto: foto)
            
        }
        
        
    }
    
    
}

