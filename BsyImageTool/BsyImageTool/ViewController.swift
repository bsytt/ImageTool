//
//  ViewController.swift
//  BsyImageTool
//
//  Created by bsy on 2018/11/21.
//  Copyright © 2018年 bsy. All rights reserved.
//

import UIKit

func kHexColorA(_ HexString: Int,_ a: CGFloat) ->UIColor {
    return UIColor(red: CGFloat((HexString  & 0xFF0000) >> 16)/255.0, green: CGFloat((HexString  & 0x00FF00) >> 8)/255.0, blue: (CGFloat(HexString & 0x0000FF))/255.0, alpha:a)
}
func kHexColor(_ HexString: Int) ->UIColor {
    return UIColor(red: CGFloat((HexString  & 0xFF0000) >> 16)/255.0, green: CGFloat((HexString  & 0x00FF00) >> 8)/255.0, blue: (CGFloat(HexString & 0x0000FF))/255.0, alpha:1.0)
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let colors:NSArray = [kHexColor(0xEC5583),kHexColor(0x8F58B0)]
        self.view.backgroundColor = UIColor.init(patternImage: ImageTool .getImageFromColors(colors: colors, gradientType: 1, size: self.view.frame.size))
        
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: self.view.frame.width-200, height: self.view.frame.width-200))
        self.view .addSubview(imageView)
        ImageTool .setQRCodeToImageView(imageView, "sfasdafdag", false)
    }


}

