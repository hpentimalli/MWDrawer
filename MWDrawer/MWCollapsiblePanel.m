/*
 CollapsiblePanelBase.m
 Copyright (C) 2014 Hernán Gustavo Pentimalli (hpentimalli g mail)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 -------------------------------------------------------------------
 
 MWCollapsiblePanel is a view that acts as a "drawer" expandable and
 collapsible in the four directions.
 
 
 */

#import "MWCollapsiblePanel.h"

#define ROLLUPDOWNDURATION 0.3
#define ISVERT(A) A == TWCollapsiblePanelDirectionBottomUp || A == TWCollapsiblePanelDirectionTopDown

@implementation MWCollapsiblePanel {
	UIView* _handle;
	float _origPosPan;
    float _openSize;
    float _closedSize;
    TWCollapsiblePanelDirection _direction;
    float _threshOpen;
    float _threshClose;
}

-(void)onTap:(UITapGestureRecognizer*)gestureRecognizer {
	
	if (self.relevantSize == _openSize) {
		[self collapse:YES];
		
	} else {
		[self expand:YES];
        		
	}
}

-(void)onPan:(UIPanGestureRecognizer*)gestureRecognizer {
	
	if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
		_origPosPan = ISVERT(_direction) ? [gestureRecognizer locationInView:self.superview].y : 
        [gestureRecognizer locationInView:self.superview].x;
		
	} else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
		
		float touchPos = ISVERT(_direction) ?        
        [gestureRecognizer locationInView:self.superview].y :
        [gestureRecognizer locationInView:self.superview].x; 
		
		float deltaPos = touchPos - _origPosPan;
		
		_origPosPan = touchPos;
		
		CGRect frame = self.frame;
					
		// if it's anchored at the top
		if (_direction == TWCollapsiblePanelDirectionTopDown &&
			self.relevantSize + deltaPos < _openSize &&
			self.relevantSize + deltaPos > _closedSize) {
				            
            self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + deltaPos);
				
		} 
		// if it's anchored at the bottom
		else if (_direction == TWCollapsiblePanelDirectionBottomUp &&
				self.relevantSize - deltaPos < _openSize &&
				self.relevantSize - deltaPos > _closedSize) {				
				
			self.frame = CGRectMake(frame.origin.x, frame.origin.y + deltaPos, frame.size.width, frame.size.height - deltaPos);
		}
		// if it's anchored at the left
		if (_direction == TWCollapsiblePanelDirectionLeftRight &&
			self.relevantSize + deltaPos < _openSize &&
			self.relevantSize + deltaPos > _closedSize) {
            
            self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width + deltaPos,frame.size.height);
            
		} 
		// if it's anchored at the right
		else if (_direction == TWCollapsiblePanelDirectionRightLeft &&
                 self.relevantSize - deltaPos < _openSize &&
                 self.relevantSize - deltaPos > _closedSize) {				
            
			self.frame = CGRectMake(frame.origin.x + deltaPos, frame.origin.y, frame.size.width - deltaPos, frame.size.height);
		}
		
	} else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
		
		// If passed the threshold to expand completely
		if (self.relevantSize >= [self thresholdOpen]) {
			
			[self expand:YES];
			
		}
		// If passed the threshold to hidding		
		else if (self.relevantSize <= [self thresholdClosed]) {
					
			[self collapse:YES];
            
		}
	}
}

-(float)relevantSize {
    return ISVERT(_direction) ? self.frame.size.height : self.frame.size.width;
    
}

-(void)collapse:(BOOL)animated {

    void(^animBlock)(void) = ^{
    
        CGRect f = self.frame;
        
        if (_direction == TWCollapsiblePanelDirectionTopDown) {
            self.frame = CGRectMake(f.origin.x, f.origin.y, f.size.width, _closedSize);
            
        } else if(_direction == TWCollapsiblePanelDirectionBottomUp) {
            self.frame = CGRectMake(f.origin.x, CGRectGetMaxY(f) - _closedSize, f.size.width, _closedSize);				
        } else if (_direction == TWCollapsiblePanelDirectionLeftRight) {
            self.frame = CGRectMake(f.origin.x, f.origin.y, _closedSize,  f.size.height);
            
        } else if(_direction == TWCollapsiblePanelDirectionRightLeft) {
            self.frame = CGRectMake(CGRectGetMaxX(f) - _closedSize, f.origin.y ,  _closedSize, f.size.height);				
        } 
        
    };
    
    if (animated)
        [UIView animateWithDuration:ROLLUPDOWNDURATION animations:animBlock];
    else
        animBlock();
}

-(void)expand:(BOOL)animated {
	
    void(^animBlock)(void) = ^{
        
        CGRect f = self.frame;
        
        if (_direction == TWCollapsiblePanelDirectionTopDown) {
            self.frame = CGRectMake(f.origin.x, f.origin.y, f.size.width, _openSize);
            
        } else if(_direction == TWCollapsiblePanelDirectionBottomUp) {
            self.frame = CGRectMake(f.origin.x, CGRectGetMaxY(f) - _openSize, f.size.width, _openSize);
            
        } else if(_direction == TWCollapsiblePanelDirectionLeftRight) {
            self.frame = CGRectMake(f.origin.x, f.origin.y, _openSize, f.size.height);
            
        } else if(_direction == TWCollapsiblePanelDirectionRightLeft) {
            self.frame = CGRectMake(CGRectGetMaxX(f) - _openSize, f.origin.y, _openSize, f.size.height);
            
        }
        
    };
    
    if (animated)
        [UIView animateWithDuration:ROLLUPDOWNDURATION animations:animBlock];
    else
        animBlock();
}

-(void)setupWithHandle:(UIView*)handle direction:(TWCollapsiblePanelDirection)direction openSize:(float)openSize {

    // Sets up the panel with default parameters: 50%-50% open/close thresholds and the current size as minimum size
    [self setupWithHandle:handle direction:direction openSize:openSize closedSize:self.bounds.size.height thresholdPercentForClosing:0.5 thresholdPercentForOpening:0.5];
}

-(void)setupWithHandle:(UIView*)handle direction:(TWCollapsiblePanelDirection)direction openSize:(float)openSize closedSize:(float)closedSize thresholdPercentForClosing:(float)threshClose thresholdPercentForOpening:(float)threshOpen {
    
    _direction = direction;
    
    _closedSize = closedSize;
    
    _threshOpen = threshOpen;
    
    _threshClose = threshClose;
    
    float oldOpenSize = _openSize;
	_openSize = openSize;
	if (self.frame.size.height == oldOpenSize)
		[self expand:YES];

	_handle = handle;
	
	// Pan gesture recognizer for moving
	UIPanGestureRecognizer* p = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
	p.minimumNumberOfTouches = 1;
	p.maximumNumberOfTouches = 1;
	[_handle addGestureRecognizer:p];
	
	// double tap gesture recognizer to fully open or close
	UITapGestureRecognizer* t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
	t.numberOfTapsRequired = 2;
	t.numberOfTouchesRequired = 1;
	[_handle addGestureRecognizer:t];
}

-(float)thresholdClosed {
	return _openSize * _threshClose;
    
}

-(float)thresholdOpen {
	return _openSize * _threshOpen;
	
}

@end
