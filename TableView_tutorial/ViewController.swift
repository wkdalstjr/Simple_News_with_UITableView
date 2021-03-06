//
//  ViewController.swift
//  TableView_tutorial
//
//  Created by 장민석 on 2021/12/06.
//  Copyright © 2021 장민석. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableViewMain: UITableView!
    
    
    var newsData : Array<Dictionary<String, Any>>?
    //1. http 통신 방법
    //2. JSON 데이터 형태 {"돈":"10000원"} -> key, value 형태 / {["100","1000","10000"]} -> key 나열
    //3. 테이블뷰의 데이터 매칭

    
    func getNews() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/top-headlines?country=kr&apiKey=0d14f9feb1624e97b11b6a5b7aba0ff5")!) { (data, response, error) in
            if let dataJson = data{
                
                //Json parsing
                do{
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    print(json)
                    //Dictionary
                    let articles = json["articles"] as! Array<Dictionary<String, Any>>
                    print(articles)
                    self.newsData = articles
                    
                    DispatchQueue.main.async {
                        self.TableViewMain.reloadData()
                    }

                }
                catch{}
            }
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 데이터 몇개
        
        if let news = newsData {
            return news.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 무엇인가
        // 1
        //let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCellType1")
        
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        // as? as! - 부모 자식 친자확인 느낌
        
        let idx = indexPath.row
        if let news = newsData {
            
            let row = news[idx]
            if let r = row as? Dictionary<String, Any> {
                if let title = r["title"] as? String{
                    cell.LabelText.text = title
                }
                
            }
            
        }
        
        
        
        return cell
    }
    
    //옵션 - 클릭 감지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICK \(indexPath.row)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
        
        getNews()
    }

    //tableview 테이블로 된 뷰 - 여러개의 행이 모여있는 목록 화면(뷰)
    // 정갈하게 보이기 위해 - ex) 전화번호부, 부재중 ...
    
    // 1. 테이블에 사용되는 데이터가 무엇인가 - ex) 전화번호부 목록
    // 2. 그 데이터가 몇개인가 - ex) 100개, 1000개
    // (옵션) 3. 데이터 행을 눌렀다. - ex) 클릭
    

}

