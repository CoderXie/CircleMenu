//
//  RQCycleMenu.h
//  CycleMenu
//
//  Created by admin on 2021/1/5.
//

#import <UIKit/UIKit.h>
#import "RQCycleMenuItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface RQCycleMenu : UIView

@property (nonatomic, copy) NSArray <RQCycleMenuItem *>*menuItems;
@property (nonatomic, getter=isExpanded) BOOL expanded;

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger maxMenuCount;
@property (nonatomic, assign) BOOL scrollEnabled;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems;
- (void)open;

@end

@protocol  RQCycleMenuDelegate <NSObject>
- (void)cycleMenu:(RQCycleMenu *)menu didSelectAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
