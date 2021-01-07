//
//  RQCycleMenuItem.m
//  CycleMenu
//
//  Created by admin on 2021/1/5.
//

#import "RQCycleMenuItem.h"

@implementation RQCycleMenuItem

- (id)initWithImage:(UIImage *)image title:(NSString *)title
{
    return [self initWithImage:image highlightedImage:nil title:title];
}

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
              title:(NSString *)title
{
    self = [super init];
    if (self) {
        _image = image;
        _highlightedImage = highlightedImage;
        _title = [title copy];
        
        _imageView = [[UIImageView alloc] initWithImage:image];
        _imageView.userInteractionEnabled = YES;
        _imageView.highlightedImage = highlightedImage;
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.userInteractionEnabled = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor colorWithWhite:1 alpha:0.65];
        _titleLabel.text = _title;
        [self addSubview:_titleLabel];
    }
    return self;
}

#pragma mark - uiview methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    const float width = self.image.size.width + 30;
    const float height = self.image.size.height + 30;
    self.bounds = CGRectMake(0, 0, width, height);
    
    if (_title) {
        _imageView.frame = CGRectMake(15, 0, width-30, height-30);
        _titleLabel.frame = CGRectMake(0, height - 25, width, 18);
    } else {
        _titleLabel.frame = CGRectZero;
        _imageView.frame = self.bounds;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.imageView.highlighted = YES;
    NSLog(@"began");
    if ([_delegate respondsToSelector:@selector(cycleMenuItemTouchesBegan:)])
    {
       [_delegate cycleMenuItemTouchesBegan:self];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"moved");
    CGPoint location = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.bounds , location))
    {
        self.imageView.highlighted = NO;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ended");
    self.imageView.highlighted = NO;
    CGPoint location = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(self.bounds, location))
    {
        if ([_delegate respondsToSelector:@selector(cycleMenuItemTouchesEnd:)])
        {
            [_delegate cycleMenuItemTouchesEnd:self];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.imageView.highlighted = NO;
}


@end
