//
//  ViewController.swift
//  MiProfesor
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//

import UIKit

class EstudianteViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK: - properties
    @IBOutlet weak var codigoTextField: UITextField!
    @IBOutlet var nombreTextField: UITextField!
    @IBOutlet weak var celularTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var idProgramaTextField: UITextField!
    @IBOutlet weak var semestreTextField: UITextField!
    @IBOutlet weak var usrTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var fotoImage: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var estudiante:Estudiante?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // handle the text field's user input through delegate callbacks
        nombreTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let univ = estudiante {
            navigationItem.title = univ.nombre
            nombreTextField.text = univ.nombre
            fotoImage.image = univ.foto
            codigoTextField.text = univ.codigo
            celularTextField.text = univ.celular
            emailTextField.text = univ.email
            semestreTextField.text = univ.semestre
            usrTextField.text  = univ.usr
            passTextField.text  = univ.pass
            idProgramaTextField.text  = univ.idPrograma
        }
        
        // Enable the save button only if the text field has a valid Meal name
        checkValidEstudianteName()
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
        checkValidEstudianteName()
        navigationItem.title = textField.text
    }
    
    func checkValidEstudianteName(){
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
            let codigo = codigoTextField.text ?? ""
            let nombre = nombreTextField.text ?? ""
            let celular = celularTextField.text
            let foto = fotoImage.image
            let email = emailTextField.text
            let semestre = semestreTextField.text
            let usr = usrTextField.text ?? ""
            let pass = passTextField.text ?? ""
            let idPrograma = idProgramaTextField.text ?? ""
            
            //set the meal to be passed to MealTableViewController after the unwind segue.
            estudiante = Estudiante(codigo: codigo, nombre: nombre, celular: celular, email: email, semestre: semestre, foto: foto, usr: usr, pass: pass, idP: idPrograma)
            
        }
        
        
    }
    
    
}

