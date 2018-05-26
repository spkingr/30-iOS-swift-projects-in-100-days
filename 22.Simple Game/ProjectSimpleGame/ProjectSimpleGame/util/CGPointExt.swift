//
// Created by 刘庆文 on 5-26.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import Foundation
import CoreGraphics

//Overloads
func +(left: CGPoint, right:CGPoint) -> CGPoint
{
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right:CGPoint) -> CGPoint
{
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar:CGFloat) -> CGPoint
{
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar:CGFloat) -> CGPoint
{
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

//Extensions
extension CGPoint
{
    var length:CGFloat {
        get {
            return sqrt(self.x * self.x + self.y * self.y)
        }
    }
    
    var normalized:CGPoint {
        get {
            return self / self.length
        }
    }
    /*
    //same orientation of [self]
    func calculateOrientationBy(x:CGFloat) throws -> CGFloat
    {
        return self.y * x / self.x
    }
    
    //same orientation of [self]
    func calculateOrientationBy(y:CGFloat) throws -> CGFloat
    {
        return self.x * y / self.y
    }*/
}