//
//  myHUD.swift
//  Activity
//
//  Created by sqluo on 2016/12/19.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

enum HudStyle {
    case lighted    //高亮
    case gray       //灰色
}


class myHUD: UIView {
    
    public var title: String!{                          //标题
        didSet{
            self.titleLabel?.text = self.title
        }
    }
    fileprivate var style: HudStyle = HudStyle.gray     //风格
    fileprivate var showInView: UIView!                 //显示在那个视图之上
    fileprivate var activity: UIActivityIndicatorView?  //菊花
    fileprivate var bgView: UIView?                     //蒙版透明层
    fileprivate var titleLabel: UILabel?                //显示标题label
    fileprivate var showView: UIView?                   //显示的区域
    fileprivate var tickImgView: UIImageView?           //加载完成时，显示的图片
    fileprivate let showWidth: CGFloat = 70             //显示区域的大小
    
    init(style: HudStyle, in showView: UIView) {
        super.init(frame: showView.frame)
        
        self.style = style
        self.showInView = showView
        
        self.frame = showView.frame                     //设置本身的区域
        
        self.bgView = UIView(frame: showView.frame)     //初始化背景视图
        self.bgView?.backgroundColor = UIColor.gray
        self.bgView?.alpha = 0.3
        self.addSubview(self.bgView!)
        ///->初始显示区域视图
        self.showView = UIView(frame: CGRect(x: 0, y: 0, width: showWidth, height: showWidth))
        self.showView?.layer.cornerRadius = 5
        self.showView?.layer.masksToBounds = true
        self.showView?.center = self.center
        switch style {
        case .lighted:
            self.showView?.backgroundColor = UIColor(red: 176/255.0, green: 220/255.0, blue: 255/255.0, alpha: 1)
        case .gray:
            self.showView?.backgroundColor = UIColor.gray
        }
        self.addSubview(self.showView!)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:公共接口
    
    ///show->显示使用时必须调用
    public func show(){
        
        self.loadActivity()
        
        self.showInView.addSubview(self)
    }
    ///remove->移除时调用
    public func remove(afterDelay: TimeInterval){
        
        self.activity?.stopAnimating()
        
        self.activity?.removeFromSuperview()
        
        self.loadTickImg()
        
        self.delay(afterDelay) {
            self.removeFromSuperview()
        }
    }
    
    
    //MARK:私有方法
    //加载成功之后的图片
    fileprivate func loadTickImg(){
        
        let activityH: CGFloat = 50
        let x = (self.showView!.frame.width - activityH) / 2
        self.tickImgView = UIImageView(frame: CGRect(x: x, y: 0, width: activityH, height: activityH))
        //没找到素材，随便搞了个图片=>>改成透明的图片即可
        self.tickImgView?.image = UIImage(named: "tick.jpg")
        self.showView?.addSubview(self.tickImgView!)
    }
    
    //加载菊花,文字
    fileprivate func loadActivity(){
        //如果没有设置标题，则菊花居中即可
        if self.title == nil {
            //菊花高度
            let activityH: CGFloat = 50
            //菊花
            self.activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            self.activity?.frame = CGRect(x: 0, y: 0, width: activityH, height: activityH)
            self.activity?.center = self.showView!.center
            self.activity?.startAnimating()
            self.showView?.addSubview(self.activity!)
        }else{
            //菊花高度
            let activityH: CGFloat = 50
            //菊花
            self.activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            let x = (self.showView!.frame.width - activityH) / 2
            self.activity?.frame = CGRect(x: x, y: 0, width: activityH, height: activityH)
            
            self.activity?.startAnimating()
            self.showView?.addSubview(self.activity!)
            //文字
            self.titleLabel = UILabel(frame: CGRect(x: 0, y: activityH, width: self.showWidth, height: self.showWidth - activityH))
            self.titleLabel?.textAlignment = .center
            self.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            
            switch self.style {
            case .gray:
                self.titleLabel?.textColor = UIColor.white
            case .lighted:
                self.titleLabel?.textColor = UIColor.black
            }
            self.titleLabel?.text = self.title
            self.showView?.addSubview(self.titleLabel!)
            
        }
 
        
    }
    
    //延迟异步执行方法
    fileprivate func delay(_ delay: TimeInterval, closure:@escaping ()->()){
        let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: closure)
    }
    

    
    deinit {
        print("HUD释放")
    }
    

}
