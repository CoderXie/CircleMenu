//
//  ViewController.m
//  CycleMenu
//
//  Created by admin on 2021/1/5.
//

#import "ViewController.h"
#import "RQCycleMenu.h"

@interface ViewController ()<RQCycleMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0 ; i < 15; i++) {
        NSString *title = [NSString stringWithFormat:@"标题--%d",i];
        RQCycleMenuItem *item = [[RQCycleMenuItem alloc] initWithImage:[UIImage imageNamed:@"mt_center_item0"] title:title];
        [dataArray addObject:item];
    }
    CGFloat radius = CGRectGetWidth(self.view.frame) / 2 - 15 + 140;
    RQCycleMenu *menu = [[RQCycleMenu alloc] initWithFrame:CGRectMake(0 , CGRectGetHeight(self.view.frame)-radius, CGRectGetWidth(self.view.frame), radius) menuItems:dataArray];
    menu.radius = radius - 70;
    menu.maxMenuCount = 20;
    menu.delegate = self;
    [self.view addSubview:menu];
}

- (void)cycleMenu:(RQCycleMenu *)menu didSelectAtIndex:(NSInteger)index
{
    NSLog(@"%d",index);
}

@end
