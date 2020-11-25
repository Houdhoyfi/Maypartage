//
//  Formulaire.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 11/15/20.
//
//la classe pour le formulaire
import AVFoundation
import UIKit
class Formulaire:UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var oui: UIBarButtonItem!
    @IBOutlet weak var non: UIBarButtonItem!
    @IBOutlet weak var QuestionVue: UIView!
    var player : AVAudioPlayer?
    var player2 : AVAudioPlayer?
    @IBOutlet weak var question: UILabel!
    var countP:Int=0
    var countM:Int=0
    
    override func viewDidLoad() {
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(VueQuestion(_:)))
        QuestionVue.addGestureRecognizer(panGestureRecognizer)
        
                do {
                   let audioPath = Bundle.main.path(forResource: "vrai2",ofType: "mp3")
                    let audioPath2 = Bundle.main.path(forResource: "faux",ofType: "mp3")
                    try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
                    try player2 = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath2!) as URL)
              } catch  { print("erreur") }
        
        //message alerte explication
            AlertExplication()
    }
    
    @IBAction func VueQuestion(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            transformQuestionViewWith(gesture: sender)
        case .ended, .cancelled:
            break
        default:
            break
        }
    }
    
    private func transformQuestionViewWith(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: QuestionVue)
        QuestionVue.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        //si la translation x >0
        if translation.x>0  {
            //on met la vue en vert
            QuestionVue.backgroundColor = UIColor.green
            //on démarre le son
            player?.play()
            let when = DispatchTime.now()+1
            //on attend une seconde
            DispatchQueue.main.asyncAfter(deadline: when){
                //on affiche l'alerte
                self.AlertConfOui()
           }
            
            let whenn = DispatchTime.now()+5
            //on attend 5 seconde
            DispatchQueue.main.asyncAfter(deadline: whenn){
                //on retourne à la vue précédente
                self.dismiss(animated: true, completion: nil)
           }
    
        } else {
           //sinon si translation x <0
            //on met la vue en rouge
            QuestionVue.backgroundColor=UIColor.red
            //on démarre le deuxième son
            player2?.play()
            let when = DispatchTime.now()+1
            //on attend une seconde
            DispatchQueue.main.asyncAfter(deadline: when){
                self.AlertConfNon()

          }
            let whenn = DispatchTime.now()+5
            DispatchQueue.main.asyncAfter(deadline: whenn){
                self.dismiss(animated: true, completion: nil)
           }
           
        }
        
    }
    
    //message alerte explication
    func AlertExplication (){
        let dialogMessage = UIAlertController(title: "Message", message: "Pour répondre à la question merci de déplacer le carré vers la droite pour répondre oui sinon vers la gauche pour répondre non. ", preferredStyle: .alert)
        
        // creation bouton ok
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
         })
        //Ajouter boutton ok
        dialogMessage.addAction(ok)
        // Presenter alerte
        DispatchQueue.main.async{
             self.present(dialogMessage, animated: true, completion: nil)
        }
 
    }
    
    //message alerte confirmation pour le non
    func AlertConfNon(){
        let dialogMessage = UIAlertController(title: "Confirmation", message: " Votre réponse est non. ", preferredStyle: .alert)
        // creation bouton ok
        let ok = UIAlertAction(title: "Oui", style: .default, handler: { (action) -> Void in
           // self.dismiss(animated: true, completion: nil)
            self.countM=self.countM+1
            self.non.title = "\(self.countM)"
            
         })
        //Ajouter boutton ok
        dialogMessage.addAction(ok)
        // Presente alerte
        let when = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: when){
            self.present(dialogMessage, animated: true, completion: nil)
      }
    }
 
    //message alerte confirmation pour le oui
    func AlertConfOui(){
        let dialogMessage = UIAlertController(title: "Confirmation", message: "Votre réponse est oui. ", preferredStyle: .alert)
        // creation bouton ok
        let ok = UIAlertAction(title: "Oui", style: .default, handler: { (action) -> Void in
            self.countP=self.countP+1
            self.oui.title = " \(self.countP)"
         })
        //Add boutton ok
        dialogMessage.addAction(ok)
        // Presentet alerte
        let when = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: when){
            self.present(dialogMessage, animated: true, completion: nil)
      }
    }
    
    
}
