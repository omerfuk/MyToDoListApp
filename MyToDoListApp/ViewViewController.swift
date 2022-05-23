//
//  ViewViewController.swift
//  MyToDoListApp
//
//  Created by Ömer Faruk Kılıçaslan on 24.05.2022.
//
import RealmSwift
import UIKit

class ViewViewController: UIViewController {
    public var item:ToDoListItem?
    
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var itemlabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        itemlabel.text = item?.item
        dateLabel.text = ViewViewController.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete(){
        guard let myItem = self.item else {
            return
        }
        
        realm.beginWrite()
        
        realm.delete(myItem)
       try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }

}
