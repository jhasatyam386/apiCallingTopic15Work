//
//  ViewController.swift
//  apiCallingTopic15Work
//
//  Created by R&W on 01/01/24.
//

import UIKit

struct GetApi : Decodable{
      var userId : Int
      var id : Int
      var title : String
      var body : String
   }


class ViewController: UIViewController {

    var arr : [GetApi] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
    
    }
    func getdata(){
        let url = URL(string:"https://jsonplaceholder.typicode.com/posts")
        var ur = URLRequest(url: url!)
        ur.httpMethod = "GET"
        URLSession.shared.dataTask(with: ur) { data ,response,error in
            do {
                if error == nil {
                    self.arr = try JSONDecoder().decode([GetApi].self, from: data!)
                    print(self.arr)
                }
            }
            catch{
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }

}

