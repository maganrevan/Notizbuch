//
//  ViewController.swift
//  Notizbuch
//
//  Created by Magnus Kruschwitz on 12.01.20.
//  Copyright © 2020 Magnus Kruschwitz. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var uiHeadlineField: UITextField!
    @IBOutlet weak var uiContentView: UITextView!
    @IBOutlet weak var uiSearchField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSaveClicked(_ sender: Any) {
        if uiHeadlineField.text == "" || uiContentView.text == "" {
            meineMeldung(title: "Fehlende Daten", meldung: "Es fehlen Daten, jene müssen nachgepflegt werden. Weder die Überschrift, noch der Inahlt dürfen Leer sein.")
        }
        else{
            let appDelegate   = UIApplication.shared.delegate as! AppDelegate
            let objectContext = appDelegate.persistentContainer.viewContext
            let entity        = NSEntityDescription.entity(forEntityName: "Notizen", in: objectContext)
            let myNotebook    = Notizen(entity: entity!, insertInto: objectContext)
            
            myNotebook.headline = uiHeadlineField.text
            myNotebook.content  = uiContentView.text
            
            do{
                try objectContext.save()
                meineMeldung(title: "Hinweis", meldung: "Notiz wurde gespeichert und ist per Headline suchbar.")
                uiHeadlineField.text = ""
                uiContentView.text   = ""
            }
            catch{
                meineMeldung(title: "Fehler", meldung: "Eintrag konnte nicht gespeichert werden.")
                print(error)
            }
        }
    }
    
    @IBAction func btnSearchClicked(_ sender: Any) {
        if uiSearchField.text == "" {
            meineMeldung(title: "Fehlende Daten", meldung: "Bitte geben Sie einen Suchbegriff ein. Wenn ein Eintrag mit der entsprechenden Headline gefunden wird, wird sie ausgegeben.")
        }
        else{
            let appDelegate   = UIApplication.shared.delegate as! AppDelegate
            let objektKontext = appDelegate.persistentContainer.viewContext
            let entitaet      = NSEntityDescription.entity(forEntityName: "Notizen", in: objektKontext)
            let anfrage       = NSFetchRequest<NSFetchRequestResult>()
                   
            anfrage.entity    = entitaet
                   
            let suche         = NSPredicate(format: "(headline CONTAINS[cb] %@)", uiSearchField.text!)
            anfrage.predicate = suche
                   
            do{
                let treffer = try objektKontext.fetch(anfrage)
                       
                if !treffer.isEmpty{
                    let ersterTreffer    = treffer[0] as! NSManagedObject
                    uiHeadlineField.text = (ersterTreffer.value(forKey: "headline") as! String)
                    uiContentView.text   = (ersterTreffer.value(forKey: "content") as! String)
                           
                    //Reset the search
                    uiSearchField.text   = ""
                }
                else{
                    meineMeldung(title: "Hinweis", meldung: "Keinen Treffer für \(uiSearchField.text!) gefunden")
                }
            }
            catch{
                meineMeldung(title: "Fehler: ", meldung: "Fehler!")
                print(error)
            }
        }
    }
    
    func meineMeldung(title: String, meldung: String){
        let meinHinweis = UIAlertController(title: title, message: meldung, preferredStyle: UIAlertController.Style.alert)
        meinHinweis.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(meinHinweis, animated: true, completion: nil)
    }
}

 
