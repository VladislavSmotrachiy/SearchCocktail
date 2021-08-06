//
//  ViewController.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 22.07.2021.
//

import UIKit

class StarterViewSearch: UIViewController {
    
    
    @IBOutlet weak var nameCocktail: UITextField!
    @IBOutlet weak var button: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        nameCocktail?.delegate = self
        nameCocktail.returnKeyType = .done
        nameCocktail.enablesReturnKeyAutomatically = true
        button?.isUserInteractionEnabled = false
        button?.alpha = 0.5
    }
    
    @objc func didTapDone() {
        if nameCocktail.text?.count ?? 0 >= 1 {
        performSegue(withIdentifier: "tableCocktails", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationBarController = segue.destination as? UINavigationController else { return }
        guard let nameCocktailVC = navigationBarController.topViewController as? TableCocktails else {return}
        nameCocktailVC.name = nameCocktail.text ?? "old"
    }
 
}

// MARK: Method for TF
extension StarterViewSearch: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count ?? 0 >= 1 {
            nameCocktail.becomeFirstResponder()
            performSegue(withIdentifier: "tableCocktails", sender: nil)
        }
        return true
    }
    
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if text.count >= 1 {
            button?.isUserInteractionEnabled.toggle()
            button?.alpha = 1.0
        } else {
            button?.isUserInteractionEnabled.toggle()
            button?.alpha = 0.5
        }
        return true
    }
    
}
