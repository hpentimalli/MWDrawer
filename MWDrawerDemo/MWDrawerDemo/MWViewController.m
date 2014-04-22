/*
 MWViewController.m
 
 Copyright (C) 2014 Hernán Gustavo Pentimalli (hpentimalli g mail)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 -------------------------------------------------------------------
 
 Demo application for MWCollapsiblePanel
 
 */

#import "MWViewController.h"
#import "../../MWDrawer/MWCollapsiblePanel.h"

@interface MWViewController ()

@property (weak, nonatomic) IBOutlet UIView *topDrawerHandle;
@property (weak, nonatomic) IBOutlet MWCollapsiblePanel *topDrawer;
@property (weak, nonatomic) IBOutlet UIView *bottomDrawerHandle;
@property (weak, nonatomic) IBOutlet MWCollapsiblePanel *bottomDrawer;


@end

@implementation MWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Sets up top drawer
    [self.topDrawer setupWithHandle:self.topDrawerHandle direction:TWCollapsiblePanelDirectionTopDown openSize:300];

    // Sets up the bottom drawer
    // Will collapse when it is manually dragged below it's 30% size
    // (0.3) and fully expand when dragged above 60% of its full size
    [self.bottomDrawer setupWithHandle:self.bottomDrawerHandle direction:TWCollapsiblePanelDirectionBottomUp openSize:400 closedSize:30 thresholdPercentForClosing:0.3 thresholdPercentForOpening:0.6];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
