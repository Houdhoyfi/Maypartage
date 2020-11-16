//
//  Formulaire.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 11/15/20.
//

import AVFoundation
import UIKit
class Formulaire:UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var QuestionVue: UIView!
    var player : AVAudioPlayer?
    var player2 : AVAudioPlayer?
    @IBOutlet weak var question: UILabel!
    
    override func viewDidLoad() {
        
        //question.text = "Avez vous aimer l'application ? "
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(VueQuestion(_:)))
        QuestionVue.addGestureRecognizer(panGestureRecognizer)
        
                do {
                   let audioPath = Bundle.main.path(forResource: "vrai2",ofType: "mp3")
                    let audioPath2 = Bundle.main.path(forResource: "faux",ofType: "mp3")
                    try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
                    try player2 = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath2!) as URL)
              } catch  { print("erreur") }
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
        //var screenWidth = UIScreen.main.bounds.width
        //let translationPercent = translation.x/(UIScreen.main.bounds.width / 2)
        //let rotationAngle = (CGFloat.pi / 6) * translationPercent
        //let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
        
        //let transform = translationtransform.concatenating(rotationTransform)
        //QuestionVue.transform = transform
        
        
        if translation.x > 0 {
            QuestionVue.backgroundColor = UIColor.green
            player?.play()
            afficheAlert()
        } else {
            QuestionVue.backgroundColor=UIColor.red
            player2?.play()
            afficheAlert()
        }

    }
    
    func afficheAlert(){
        let dialogMessage = UIAlertController(title: "Message", message: "Merci pour votre réponse ", preferredStyle: .alert)
        
        // creation bouton ok
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.dismiss(animated: true, completion: nil)
         })
        
        //Add boutton ok
        dialogMessage.addAction(ok)
        // Presentet alerte
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            self.present(dialogMessage, animated: true, completion: nil)
            
      }
        

    }
    
    func AlertExplication (){
        let dialogMessage = UIAlertController(title: "Message", message: "Pour répondre à la question merci de déplacer le carré vers la droite pour répondre oui sinon vers la gauche pour répondre non ", preferredStyle: .alert)
        
        // creation bouton ok
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
         })
        
        //Add boutton ok
        dialogMessage.addAction(ok)
        // Presentet alerte
        DispatchQueue.main.async{
             self.present(dialogMessage, animated: true, completion: nil)
        }
        /*
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            self.present(dialogMessage, animated: true, completion: nil)
            
      }*/
        
    }
    
    
}
