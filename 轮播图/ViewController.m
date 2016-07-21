//
//  ViewController.m
//  轮播图
//
//  Created by 韩永进 on 16/6/25.
//  Copyright © 2016年 han. All rights reserved.
//

#import "ViewController.h"
#import "LBTView.h"
@interface ViewController ()
/**
 *  lb
 */
@property(nonatomic,strong)LBTView *adView;
/**
 *  <#Description#>
 */
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation ViewController
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 30)];
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    }
    return _pageControl;
}
- (LBTView *)adView{
    
    if (!_adView) {
        _adView = [[LBTView alloc]initWithFrame:self.view.bounds];
        _adView.pageControl = self.pageControl;
    }
    
    return _adView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取当前bundleId
   NSLog(@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]);
    
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.adView];
    [self.view addSubview:self.pageControl];
    self.adView.ImageS = @[@"1.png",@"2.png",@"3.png"];
    
}

@end
