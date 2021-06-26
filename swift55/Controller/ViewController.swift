//
//  ViewController.swift
//  swift55
//
//  Created by Satyaa Akana on 26/06/21.
//

import UIKit


class ViewController: UIViewController {
    let url = "https://jsonplaceholder.typicode.com/users"
    var users =  [User]()
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nibRegister()
        
        async{
            await getTodos()
        }
    }
    
    func nibRegister(){
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tblView.register(nib, forCellReuseIdentifier: "TableViewCell")
    }
    
    func getTodos() async{
        let res: Result<[User], ApiError> = await ApiHandler.getParse(url: url)
        switch res{
        case .success(let users):
            self.users = users
            print(users)
            DispatchQueue.main.async{
                self.tblView.reloadData()
            }
            
        case .failure(let error):
            print(error)
        }
    }
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "TableViewCell")
        cell?.textLabel?.text = self.users[indexPath.row].name
        return cell!
    }
    
    
}

