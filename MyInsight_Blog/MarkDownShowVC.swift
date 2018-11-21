//
//  MarkDownShowVC.swift
//  MyInsight_Blog
//
//  Created by gemvary_mini_2 on 2018/11/21.
//  Copyright © 2018 SongMengLong. All rights reserved.
//

import UIKit

class MarkDownShowVC: UIViewController {

    // 需要传入的字符串
    var markdownStr: String = String()
    
    let mdView: MarkdownView = MarkdownView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = markdownStr
        
        self.view.backgroundColor = UIColor.white
        
        self.mdView.frame = self.view.bounds
        self.view.addSubview(self.mdView)
        self.mdView.translatesAutoresizingMaskIntoConstraints = false
        self.mdView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        self.mdView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.mdView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.mdView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        
        //let path = Bundle.main.path(forResource: "用 isa 承载对象的类信息", ofType: "md")!
        let path = Bundle.main.path(forResource: markdownStr, ofType: "md")!
        
        let url = URL(fileURLWithPath: path)
        let markdown = try! String(contentsOf: url, encoding: String.Encoding.utf8)
        mdView.load(markdown: markdown, enableImage: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
