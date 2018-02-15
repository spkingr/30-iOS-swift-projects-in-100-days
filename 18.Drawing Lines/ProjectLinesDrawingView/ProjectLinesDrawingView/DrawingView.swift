//
// Created by 刘庆文 on 2-11.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import UIKit

struct Line
{
    var start:CGPoint = CGPoint.zero
    var end:CGPoint = CGPoint.zero
    //var width:CGFloat = 2.0
    //var color:UIColor = UIColor.black
}

extension DrawingView:DrawingDelegate
{
    var canUndo: Bool
    {
        return self.existLines.count > 0
    }
    var canRedo: Bool
    {
        return self.backupLines.count > 0
    }
    
    func undo()
    {
        if self.existLines.count > 0 {
            let lastLine = self.existLines.removeLast()
            self.setNeedsDisplay()
            
            self.backupLines.append(lastLine)
        }
    }
    
    func redo()
    {
        if self.backupLines.count > 0 {
            let lastLine = self.backupLines.removeLast()
            self.existLines.append(lastLine)
            
            self.setNeedsDisplay()
        }
    }
    
    func clear()
    {
        self.existLines.removeAll()
        self.setNeedsDisplay()
        
        self.backupLines.removeAll()
    }
}

class DrawingView:UIView
{
    @IBInspectable var existLinesColor:UIColor = UIColor.black {
        didSet{
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var tempLinesColor:UIColor = UIColor.red {
        didSet{
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var lineStrokeWidth:CGFloat = 2.0 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    private var existLines = [Line]()
    private var tempLines = [NSValue:Line]()
    private var backupLines = [Line]()
    
    private func strokeLine(_ line:Line)
    {
        let path = UIBezierPath()
        path.lineJoinStyle = .round
        path.lineCapStyle = .round
        path.lineWidth = self.lineStrokeWidth
        path.move(to: line.start)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        touches.forEach { touch in
            let key = NSValue(nonretainedObject: touch)
            let location = touch.location(in: self)
            let line = Line(start: location, end: location)
            self.tempLines[key] = line
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        touches.forEach { touch in
            let key = NSValue(nonretainedObject: touch)
            if var line = self.tempLines[key] {
                line.end = touch.location(in: self)
                self.tempLines[key] = line
            }
        }
        
        self.setNeedsDisplay()
        //super.touchesMoved(touches, with: event) //next responder do not need this event
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        touches.forEach { touch in
            let key = NSValue(nonretainedObject: touch)
            if var line = self.tempLines[key] {
                line.end = touch.location(in: self)
                self.existLines.append(line)
            }
        }
        self.tempLines.removeAll()
        self.backupLines.removeAll() //!Important!
        
        self.setNeedsDisplay()
        super.touchesEnded(touches, with: event) //This code should be placed at the last position
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        touches.forEach { touch in
            let key = NSValue(nonretainedObject: touch)
            self.tempLines[key] = nil
        }
        
        self.setNeedsDisplay()
        super.touchesCancelled(touches, with: event) //This code should be placed at the last position
    }
    
    override func draw(_ rect: CGRect)
    {
        super.draw(rect)
        
        self.existLinesColor.setStroke()
        self.existLines.forEach { line in
            self.strokeLine(line)
        }
        
        self.tempLinesColor.setStroke()
        self.tempLines.forEach { _, line in
            self.strokeLine(line)
        }
    }
}
