//
//  RQCycleMenu.m
//  CycleMenu
//
//  Created by admin on 2021/1/5.
//

#import "RQCycleMenu.h"

@interface RQCycleMenu ()<UIScrollViewDelegate,RQCycleMenuItemDelegate>
@property (nonatomic, strong) UIScrollView *contentView;
@end

@implementation RQCycleMenu

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems
{
    self = [super initWithFrame:frame];
    if (self) {
        _menuItems = menuItems;
        
        _contentView = [[UIScrollView alloc] init];
        _contentView.backgroundColor = UIColor.blackColor;
        _contentView.frame = self.bounds;
        _contentView.delegate = self;
        [self addSubview:_contentView];
    }
    return self;
}

#pragma mark - setter

- (void)setScrollEnabled:(BOOL)scrollEnabled
{
    _scrollEnabled = scrollEnabled;
    self.contentView.scrollEnabled = _scrollEnabled;
}

- (void)setMenuItems:(NSArray<RQCycleMenuItem *> *)menuItems
{
    if (_menuItems != menuItems) {
        _menuItems = [menuItems copy];
        [self _resetScrollViewContentSize];
        [self _setMenu];
    }
}

- (void)setRadius:(CGFloat)radius
{
    if (_radius != radius) {
        _radius = radius;
        [self _resetScrollViewContentSize];
        [self _setMenu];
    }
}

- (void)setMaxMenuCount:(NSInteger)maxMenuCount
{
    if (_maxMenuCount != maxMenuCount) {
        _maxMenuCount = maxMenuCount;
        [self _resetScrollViewContentSize];
        [self _setMenu];
    }
}

#pragma mark - private methods

- (void)_setMenu
{
    for (UIView *v in self.subviews) {
        if (v.tag >= 1000) {
            [v removeFromSuperview];
        }
    }
    
    NSInteger maxMenuCount = self.maxMenuCount ?:self.menuItems.count;
    for (int i = 0; i < self.menuItems.count; i++) {
        CGFloat Ox = self.frame.size.width / 2;
        CGFloat Oy = self.frame.size.height;
        CGFloat angle = 2 * M_PI / maxMenuCount * i + M_PI + 2 * M_PI / maxMenuCount * 3;
        RQCycleMenuItem *item = self.menuItems[i];
        item.tag = 1000 + i;
        item.center = CGPointMake(Ox + self.radius * cos(angle),
                                  Oy + self.radius * sin(angle));
        [self.contentView addSubview:item];
    }
}

- (void)_updateMenu
{
    NSInteger maxMenuCount = self.maxMenuCount ?:self.menuItems.count;
    for (int i = 0; i < self.menuItems.count; i++) {
        CGFloat Ox = self.frame.size.width / 2;
        CGFloat Oy = self.frame.size.height;
        CGFloat offset = self.contentView.contentOffset.x / self.radius;
        CGFloat angle = 2 * M_PI / maxMenuCount * i - offset + M_PI + 2 * M_PI / maxMenuCount * 3;
        RQCycleMenuItem *item = self.menuItems[i];
        item.tag = 1000 + i;
        item.center = CGPointMake(Ox + self.radius * cos(angle) + self.contentView.contentOffset.x,
                                  Oy + self.radius * sin(angle));
    }
}

- (void)_resetScrollViewContentSize
{
    NSInteger maxMenuCount = self.maxMenuCount ?: self.menuItems.count;
    if (maxMenuCount) {
        CGFloat width = self.radius * 2 * M_PI / maxMenuCount * self.menuItems.count;
        width = width > self.bounds.size.width ? width : self.bounds.size.width;
        self.contentView.contentSize = CGSizeMake(width, CGRectGetHeight(self.frame));
    }
}

/// 计算手指离开后滑动距离算法
/// @param x 手指的位移量
/// @param coeff 某个比率
/// @param dim 指的是滚动视图的尺寸
- (CGFloat)_rubberBandClamp:(CGFloat)x coeff:(CGFloat)coeff dim:(CGFloat)dim
{
    return (1.0 - (1.0 / ((x * coeff / dim) + 1.0))) * dim;
}

#pragma mark - public methods

- (void)open
{
    [self _setMenu];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self _updateMenu];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
//    NSLog(@"scrollViewWillEndDragging333333");
    const float dim = CGRectGetWidth(scrollView.frame);
    CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView];
    CGFloat s = [self _rubberBandClamp:point.x coeff:0.55 dim:dim];
    CGFloat angle = (self.contentView.contentOffset.x - s) / self.radius;
    NSInteger maxMenuCount = self.maxMenuCount ?: self.menuItems.count;
    CGFloat indexf = angle / (2 * M_PI / maxMenuCount);
    CGFloat offset = roundf(indexf) * (2 * M_PI / maxMenuCount) * self.radius;
    *targetContentOffset = CGPointMake(offset, targetContentOffset->y);
}

#pragma mark - RQCycleMenuDelegate

- (void)cycleMenuItemTouchesBegan:(RQCycleMenuItem *)item
{
    
}

- (void)cycleMenuItemTouchesEnd:(RQCycleMenuItem *)item
{
    if ([_delegate respondsToSelector:@selector(cycleMenu:didSelectAtIndex:)])
    {
        [_delegate cycleMenu:self didSelectAtIndex:item.tag - 1000];
    }
}

@end
