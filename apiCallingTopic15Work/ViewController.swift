//
//  ViewController.swift
//  apiCallingTopic15Work
//
//  Created by R&W on 01/01/24.
//

import UIKit
import Alamofire

struct GetApi : Decodable{
      var userId : Int
      var id : Int
      var title : String
      var body : String
   }


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    

    var arr : [GetApi] = []
    
    @IBOutlet weak var tabelDataview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
    
    }
//    func getdata(){
//        let url = URL(string:"https://jsonplaceholder.typicode.com/posts")
//        var ur = URLRequest(url: url!)
//        ur.httpMethod = "GET"
//        URLSession.shared.dataTask(with: ur) { data ,response,error in
//            do {
//                if error == nil {
//                    self.arr = try JSONDecoder().decode([GetApi].self, from: data!)
//                    print(self.arr)
//                    DispatchQueue.main.async {
//                        self.tabelDataview.reloadData()
//                    }
//                }
//            }
//            catch{
//                print(error.localizedDescription)
//            }
//
//        }.resume()
//
//    }
    
    func getdata(){
       
        AF.request("https://jsonplaceholder.typicode.com/posts",method: .get).responseData { respo in
            switch respo.result{
            case.success(let data):
                do{
                    if data == respo.value{
                        self.arr = try JSONDecoder().decode([GetApi].self, from: data)
                        print(self.arr)
                        DispatchQueue.main.async{
                            self.tabelDataview.reloadData()
                        }
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            case.failure(let err):
                print(err.localizedDescription)
            }
        }
      
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelDataview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.label1.text = "\(arr[indexPath.row].userId)"
        cell.label4.text = "\(arr[indexPath.row].id)"
        cell.label2.text = arr[indexPath.row].title
        cell.label3.text = arr[indexPath.row].body

        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

}

