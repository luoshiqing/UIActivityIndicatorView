//
//  RootViewController.swift
//  Activity
//
//  Created by sqluo on 2016/12/19.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    
    var activity: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "首页"
        self.view.backgroundColor = UIColor.white
        
        
        
        
        self.activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activity?.frame = CGRect(x: 100, y: 200, width: 50, height: 50)
        
        self.activity?.backgroundColor = UIColor.red
        
        self.view.addSubview(self.activity!)
        
        self.activity?.startAnimating()
        
        
        
        
        //
        let btn = UIButton(frame: CGRect(x: (self.view.frame.width - 80) / 2, y: self.view.frame.height - 30 - 120, width: 80, height: 30))
        btn.setTitle("点击开始", for: UIControlState())
        btn.setTitleColor(UIColor.white, for: UIControlState())
        btn.backgroundColor = UIColor.red
        
        btn.addTarget(self, action: #selector(self.btnAct(send:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
    }
    
    
    func btnAct(send: UIButton){
        
        
        let myhud = myHUD(style: .gray, in: self.view)
        myhud.title = "加载中"
        myhud.show()
        
        //模拟3秒之后调用移除方法
        self.delay(3) {
            //移除时调用
            myhud.title = "加载成功"
            myhud.remove(afterDelay: 1) //存活一秒
        }
        
        
    }
    
    

    func delay(_ delay: TimeInterval, closure:@escaping ()->()){
        let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: closure)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
