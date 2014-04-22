/*
 MWInvisibleView.m
 
 Copyright (C) 2014 Hernán Gustavo Pentimalli (hpentimalli g mail)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 -------------------------------------------------------------------
 
 MWInvisibleView is a base class for UIViews. You should make your 
 UIView class a subclass of MWInvisibleView to use the features it 
 provides.
 
 The objective of the view is to bypass all gestures that don't hit
 a child view of this view. This is useful for irregular-shaped views
 with images or custom drawn that don't want to create a rectangular
 hit area.
 
 */

#import "MWInvisibleView.h"

@implementation MWInvisibleView

-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	
    UIView* v = [super hitTest:point withEvent:event];
    return v == self ? nil : v;

}

@end
