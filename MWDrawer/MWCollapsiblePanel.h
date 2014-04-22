/*
    CollapsiblePanelBase.h
    Copyright (C) 2014 Hernán Gustavo Pentimalli (hpentimalli g mail)

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 -------------------------------------------------------------------
 
 MWCollapsiblePanel is a view that acts as a "drawer" expandable and
 collapsible in the four directions.
 
 To use it:
 
 1) Set the view type in interface builder to MWCollapsiblePanel
 
 2) On the view controller, call one of the setup methods

*/

#import <UIKit/UIKit.h>
#import "MWInvisibleView.h"

/**
 Specifies the direction of the panel
 */
typedef enum {
    TWCollapsiblePanelDirectionTopDown /**< Panel expands top-down */,
    TWCollapsiblePanelDirectionBottomUp /**< Panel expands bottom-up */,
    TWCollapsiblePanelDirectionLeftRight /**< Panel expands from left to right */,
    TWCollapsiblePanelDirectionRightLeft /**< Panel expands from right to left */
    
} TWCollapsiblePanelDirection;

/**
 The view class for the collapsible panel
 */
 
@interface MWCollapsiblePanel : MWInvisibleView

/**
 Sets up the behavior of the control. 
 @param handle Pointer to the view acting as "handle" of the drawer. This is the view the user will drag, drop and double click
 @param direction The direction fo the handle
 @param openSize The full size of the drawer when expanded
 @param closedSize The size of the drawer when closed
 @param threshClose Index from 0 to 1 of how much the drawer should be manually dragged to in order to autocollapse to the minimum size
 @param threshOpen Index from 0 to 1 of how much the drawer should be manually dragged to in order to autoexpand to the maximum size
 */
-(void)setupWithHandle:(UIView*)handle direction:(TWCollapsiblePanelDirection)direction openSize:(float)openSize closedSize:(float)closedSize thresholdPercentForClosing:(float)threshClose thresholdPercentForOpening:(float)threshOpen;

/**
 Sets up the behavior of the control.
 @param handle Pointer to the view acting as "handle" of the drawer. This is the view the user will drag, drop and double click
 @param direction The direction fo the handle
 @param openSize The full size of the drawer when expanded
 */
-(void)setupWithHandle:(UIView*)handle direction:(TWCollapsiblePanelDirection)direction openSize:(float)openSize;

/**
 * Makes the panel to expand to the full size
 */
-(void)expand:(BOOL)animated;

/**
 * Makes the panel collapse to the minimun size
 */
-(void)collapse:(BOOL)animated;

@end
