//
//  ImageTool.swift
//  BsyImageTool
//
//  Created by 包曙源 on 2018/11/21.
//  Copyright © 2018年 bsy. All rights reserved.
//

import UIKit

class ImageTool: NSObject {
    //生成二维码
    static func setQRCodeToImageView(_ imageView: UIImageView?, _ url: String?,_ centerTag:Bool) {
        if imageView == nil || url == nil {
            return
        }
        // 创建二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        // 恢复滤镜默认设置
        filter?.setDefaults()
        
        // 设置滤镜输入数据
        let data = url!.data(using: String.Encoding.utf8)
        filter?.setValue(data, forKey: "inputMessage")
        
        // 设置二维码的纠错率
        filter?.setValue("M", forKey: "inputCorrectionLevel")
        
        // 从二维码滤镜里面, 获取结果图片
        var image = filter?.outputImage
        
        // 生成一个高清图片
        let transform = CGAffineTransform.init(scaleX: 20, y: 20)
        image = image?.transformed(by: transform)
        
        // 图片处理
        var resultImage = UIImage(ciImage: image!)
        
        // 设置二维码中心显示的小图标
        let center = UIImage(named: "AppIcon.png")
        if center != nil {
            resultImage = getClearImage(sourceImage: resultImage, center: center!,centerTag:centerTag)
        }
        
        // 显示图片
        imageView?.image = resultImage
    }
    
    // 使图片放大也可以清晰
    static func getClearImage(sourceImage: UIImage, center: UIImage,centerTag:Bool) -> UIImage {
        
        let size = sourceImage.size
        // 开启图形上下文
        UIGraphicsBeginImageContext(size)
        
        // 绘制大图片
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        if centerTag == true {
            // 绘制二维码中心小图片
            let width: CGFloat = 80
            let height: CGFloat = 80
            let x: CGFloat = (size.width - width) * 0.5
            let y: CGFloat = (size.height - height) * 0.5
            center.draw(in: CGRect(x: x, y: y, width: width, height: height))
        }
        // 取出结果图片
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        return resultImage!
    }
    
    
    //生成渐变色image
    static func getImageFromColors(colors:NSArray,gradientType:NSInteger,size:CGSize) -> UIImage {
        let ar = NSMutableArray()
        for item in colors {
            let c:UIColor = item as! UIColor
            ar .add(c)
        }
        UIGraphicsBeginImageContextWithOptions(size, true, 1)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.saveGState()
        let colors = ar.map { (color) -> AnyObject? in
            let co:UIColor = color as! UIColor
            return (co.cgColor as AnyObject)
            } as NSArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
        var start:CGPoint = CGPoint(x: 0.0, y: 0.0)
        var end:CGPoint = CGPoint(x: 0.0, y: 0.0)
        switch gradientType {
        case 0:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: 0.0, y: size.height)
            break
        case 1:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: size.width, y: 0.0)
            break
        case 2:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: size.width, y: size.height)
            break
        case 3:
            start = CGPoint(x: size.width, y: 0.0)
            end = CGPoint(x: 0.0, y: size.height)
            break
        default:
            break
        }
        let type = CGGradientDrawingOptions.drawsBeforeStartLocation.rawValue | CGGradientDrawingOptions.drawsAfterEndLocation.rawValue
        
        context.drawLinearGradient(gradient!, start: start, end: end, options:  CGGradientDrawingOptions(rawValue: type))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        context.restoreGState()
        
        UIGraphicsEndImageContext()
        return image!
    }
}
