//
//  ViewController.swift
//  aula04-romulo
//
//  Created by Faculdade Alfa on 12/03/20.
//  Copyright © 2020 Faculdade Alfa. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var edtValorEtanol:UITextField!
    @IBOutlet var edtValorGasolina:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calcular() {
        
        guard let valorEtanol = Double(edtValorEtanol.text ?? "") else {
            mostrarMensagem(titulo: "Atenção", texto: "Valor do Etanol inválido!!!");
            return
        }
        
        guard let valorGasolina = Double(edtValorGasolina.text ?? "") else {
            mostrarMensagem(titulo: "Atenção", texto: "Valor da Gasolina inválido!!!");
            return
        }
        
        if (valorEtanol <= (valorGasolina * 0.7)) {
            mostrarMensagem(titulo: "Etanol", texto: "Etanol é mais vantajoso")
        } else {
            mostrarMensagem(titulo: "Gasolina", texto: "Gasolina é mais vantajoso")
        }
        
    }
    
    private func mostrarMensagem(titulo: String, texto: String) -> Void {
        let alerta = UIAlertController(title: titulo, message: texto, preferredStyle: .alert)
        
        let acaoOK = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alerta.addAction(acaoOK)
        
        present(alerta, animated: true)
    }
    
    @IBAction func compatilhar() {
        let alerta = UIAlertController(title: "Compartilhar", message: "Onde deseja compartilhar?", preferredStyle: .actionSheet)
        alerta.addAction(UIAlertAction(title: "Voltar", style: .cancel, handler: nil))
        
        let emailAcao = UIAlertAction(title: "E-mail", style: .default) {
            UIAlertAction in
            
            self.enviarEmail()
        }
        
        alerta.addAction(emailAcao)
        
        let whatsapAcao = UIAlertAction(title: "Whatsap", style: .default) {
            UIAlertAction in
            
            self.enviarWhatsap()
        }
        
        alerta.addAction(whatsapAcao)
        
        present(alerta, animated: true);
    }
    
    private func enviarEmail() -> Void {
        if (MFMailComposeViewController.canSendMail()) {
            let email = MFMailComposeViewController()
            
            email.mailComposeDelegate = self
            
            email.setToRecipients(["romuloevil@outlook.com","romulo.vieira@gazin.com.br"])
            email.setSubject("Assunto do E-mail");
            email.setMessageBody("Valor do Etanol:\(edtValorEtanol.text ?? ""). Valor da Gasolina:\(edtValorGasolina.text ?? "" ).", isHTML:true)
            
            present(email, animated: true)
            
        } else {
            mostrarMensagem(titulo: "E-mail", texto: "Não é possivel encontrar um e-mail configurado")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func enviarWhatsap() -> Void {
        if let link = URL(string: "https:\\api.whatsapp.com/send?phone=5544997353414text=AULA%20ALFA") {
            if (UIApplication.shared.canOpenURL(link)) {
                UIApplication.shared.open(link, options: option: [:], completionHandler: nil)            }
        } else {
            
        }
    }

}

