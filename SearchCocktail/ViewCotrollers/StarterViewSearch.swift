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
        self.view.addBackground()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationBarController = segue.destination as? UINavigationController else { return }
        guard let nameCocktailVC = navigationBarController.topViewController as? CocktailsCollectionController else {return}
        nameCocktailVC.name = nameCocktail.text ?? ""
    }
}

// MARK: Method for TF
extension StarterViewSearch: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count ?? 0 != 0  {
            performSegue(withIdentifier: "tableCocktails", sender: nil)
        }
        return true
    }
    
     func textField(_ textField: UITextField,
                           shouldChangeCharactersIn range: NSRange,
                           replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range,
                                                                     with: string)
        if text.count != 0 {
            button?.alpha = 1.0
            button?.isUserInteractionEnabled = true
        } else {
            button?.alpha = 0.5
            button?.isUserInteractionEnabled = false
        }
        return true
    }
}

extension UIView {
    func addBackground() {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 20, y: -20, width: width, height: height))
        imageViewBackground.image = UIImage(named: "cocktails")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}
