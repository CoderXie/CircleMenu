//
//  RQCycleMenuItem.h
//  CycleMenu
//
//  Created by admin on 2021/1/5.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface RQCycleMenuItem : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nullable, nonatomic, strong) UIImage *image;
@property (nullable, nonatomic, strong) UIImage *highlightedImage;
@property (nullable, nonatomic, copy) NSString *title;

- (id)initWithImage:(nullable UIImage *)image title:(nullable NSString *)title;

- (id)initWithImage:(nullable UIImage *)image
   highlightedImage:(nullable UIImage *)highlightedImage
              title:(nullable NSString *)title;

@end

@protocol RQCycleMenuItemDelegate <NSObject>


@end
NS_ASSUME_NONNULL_END
