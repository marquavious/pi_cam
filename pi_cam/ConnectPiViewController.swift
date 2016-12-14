//
//  ConnectPiViewController.swift
//  pi_cam
//
//  Created by Marquavious on 12/11/16.
//  Copyright © 2016 marqmakesapps. All rights reserved.
//

import UIKit


class ConnectPiViewController: UIViewController, UITextFieldDelegate,NRFManagerDelegate {
    
    var nrfManager:NRFManager!
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var wifiTextField: UITextField!
    @IBOutlet weak var backButton: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
        backButton.isUserInteractionEnabled = true

        nrfManager = NRFManager(
            onConnect: {
                print("C: ★ Connected")
        },
            onDisconnect: {
                print("C: ★ Disconnected")
        },
            onData: {
                (data:Data?, string:String?)->() in
                print("C: ⬇ Received data - String: \(string) - Data: \(data)")
        },
            autoConnect: true
        )
        
        nrfManager.verbose = true
        //        nrfManager.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
        backButton.isUserInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    func sendData() {
        //                let string = "Wifi,MakeSchool,applynow"
        let string = "wifi,\(wifiTextField.text!),\(passwordTextField.text!)"
        let result = self.nrfManager.writeString(string)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        passwordTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func connectButtonPressed(_ sender: Any) {
        
        //                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:{
        //                    self.mainStackView.alpha = 0
        //                }, completion: nil)
        //
        //                let loader: UIImageView = {
        //                    let loader = UIImageView()
        //                    loader.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        //                    loader.backgroundColor = .red
        //                    loader.image = UIImage(named: "ovalLoad")
        //                    loader.translatesAutoresizingMaskIntoConstraints = false
        //                    loader.contentMode = .scaleAspectFit
        //                    return loader
        //                }()
        //
        //
        //
        //                view.addSubview(loader)
        //
        //                loader.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        //                loader.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        //                loader.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        //                loader.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        //                loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //                loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //                loader.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //                loader.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        performSegue(withIdentifier: "show", sender: self)
        sendData()
        
        
        
    }
}
