//
//  BasicVC.swift
//  MyInsight_Blog
//
//  Created by gemvary_mini_2 on 2018/11/21.
//  Copyright © 2018 SongMengLong. All rights reserved.
//

import UIKit

class BasicVC: UIViewController {
    // 声明变量
    let tableview = UITableView()
    // 数组
    var dataArray = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // 初始化tableview
        
        self.view.addSubview(self.tableview)
        self.tableview.frame = self.view.bounds;
        self.tableview.delegate = self
        self.tableview.dataSource = self
        // 注册cell
        self.tableview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        // 清空多余cell
        self.tableview.tableFooterView = UIView(frame: CGRect.zero)
        
        dataArray = ["iOS制作Framework", "iOS代码块CodeSnippet"]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little prepa>>ration before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - 扩展
extension BasicVC: UITableViewDelegate, UITableViewDataSource {
    // setction个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // cell行数目
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    // 生成cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        // label赋值
        cell.textLabel?.text = dataArray[indexPath.row]
        // 箭头
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    // 选中cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let cellStr: String = self.dataArray[indexPath.row]
        
        let markdownStr: String = dataArray[indexPath.row]
        //debugPrint("滚滚长江东逝水 " + markdownStr)
        let markDownShowVC : MarkDownShowVC = MarkDownShowVC()
        markDownShowVC.hidesBottomBarWhenPushed = true
        markDownShowVC.markdownStr = markdownStr
        self.navigationController?.pushViewController(markDownShowVC, animated: true)
        
        
    }
}

