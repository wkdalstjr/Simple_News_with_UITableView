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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 데이터 몇개
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 무엇인가
        // 1
        //let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCellType1")
        
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        // as? as! - 부모 자식 친자확인 느낌
        cell.LabelText.text = "\(indexPath.row)"
        
        
        
        //cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    // 클릭
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICK \(indexPath.row)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
    }

    //tableview 테이블로 된 뷰 - 여러개의 행이 모여있는 목록 화면(뷰)
    // 정갈하게 보이기 위해 - ex) 전화번호부, 부재중 ...
    
    // 1. 테이블에 사용되는 데이터가 무엇인가 - ex) 전화번호부 목록
    // 2. 그 데이터가 몇개인가 - ex) 100개, 1000개
    // (옵션) 3. 데이터 행을 눌렀다. - ex) 클릭
    

}

