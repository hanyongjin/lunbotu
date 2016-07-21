//
//  LBTView.m
//  轮播图
//
//  Created by 韩永进 on 16/7/20.
//  Copyright © 2016年 han. All rights reserved.
//

#import "LBTView.h"
@interface LBTView()<UIScrollViewDelegate>
/**
 *  <#Description#>
 */
/**
 *  <#Description#>
 */
@property(nonatomic,strong)NSTimer *timer;
@end
@implementation LBTView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = self;
        
        self.scrollsToTop = NO;
        [self addSubview:self.pageControl];
    }
    return self;
}
- (void)setImageS:(NSArray *)ImageS{
    
    _ImageS = ImageS;
    
    self.pageControl.numberOfPages = ImageS.count;
    
    [self setUpUI];
    
}
- (void)setUpUI{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat W = self.bounds.size.width;
    
    CGFloat H = self.bounds.size.height;
    
    CGFloat Y = 0;
    
    UIImageView *one = [[UIImageView alloc]init ];
    
    UIImageView *last = [[UIImageView alloc]init];
    
    for (int i = 0; i < self.ImageS.count; i++) {
        
        CGFloat X = i * self.bounds.size.width + self.bounds.size.width;
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(X, Y, W, H)];
        imageV.image = [UIImage imageNamed:self.ImageS[i]];
        
        if (i == 0) {
             last.image = [UIImage imageNamed:self.ImageS[i]];
        }
        
        if (i == self.ImageS.count -1) {
           
             one.image = [UIImage imageNamed:self.ImageS[i]];
        }
        
        [self addSubview:imageV];
    }
    
    one.frame = CGRectMake(0, Y, W, H);
    [self addSubview:one];
    
    last.frame = CGRectMake((self.ImageS.count + 1)*self.bounds.size.width, Y, W, H);
    [self addSubview:last];
    self.contentSize = CGSizeMake((self.ImageS.count + 2)*W, H);
    
    self.pagingEnabled = YES;
    
    self.pageControl.currentPage = 0;
    //滚动到第一张
    [self setContentOffset:CGPointMake(W, 0)];
    //不现实滚动条
    self.showsHorizontalScrollIndicator = NO;
    [self addTimer];
    
}

#pragma UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat w = self.bounds.size.width;
    
    int page = (scrollView.contentOffset.x + w *0.5) / w;
    
    page --;
    
    self.pageControl.currentPage = page;
    
//    NSLog(@"%d",page);
    
}
//手离开后减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat w = self.bounds.size.width;
    
    int page = (scrollView.contentOffset.x + w * 0.5) / w;
    NSLog(@"%f",scrollView.contentOffset.x);
     NSLog(@"%d",page);
    if (page == 0) {
        [self setContentOffset:CGPointMake(w * self.ImageS.count, 0)];
    }else if(page == self.ImageS.count + 1){
        [self setContentOffset:CGPointMake(w , 0)];

    }
    
    
}
//滚动动画停止
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat w = self.bounds.size.width;
    
    int page = (scrollView.contentOffset.x + w * 0.5) / w;
    NSLog(@"%d",page);
    //向右滑了,设置滑动的点为最后一张的位置w * self.ImageS.count
    if (page == 0) {
        [self setContentOffset:CGPointMake(w * self.ImageS.count, 0)];
        //向左滑了，当滑动到最后一张的时候设置滑动的位置是第一张的位置
    }else if(page == self.ImageS.count + 1) {
        [self setContentOffset:CGPointMake(w , 0)];
        
    }
}
- (void)addTimer
{
    self.timer = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextImage
{
    NSInteger page = 0;
    if (self.pageControl.currentPage == self.ImageS.count) {
        page = 0;
    } else {
        page = self.pageControl.currentPage + 1;
    }
    CGFloat offsetX = (page + 1) * self.bounds.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    
    [self setContentOffset:offset animated:YES];
    

}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc
{
    [self removeTimer];
}
@end
