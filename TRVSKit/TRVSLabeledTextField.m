//
//  TRVSLabeledTextField.m
//  TRVSKit
//
//  Created by Travis Jeffery on 10/3/13.
//
//

#import "TRVSLabeledTextField.h"

@interface TRVSLabeledTextField ()

@property (nonatomic, strong, readwrite) UILabel *label;
@property (nonatomic) dispatch_semaphore_t animationSemaphore;

@end

@implementation TRVSLabeledTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.label];
        }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    self.label.text = placeholder;
    [self setNeedsLayout];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], [self insetRect]);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect([super editingRectForBounds:bounds], [self insetRect]);
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    return CGRectIntegral(CGRectOffset([super clearButtonRectForBounds:bounds], 0.f, self.label.font.lineHeight/2.f));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.label sizeToFit];
    self.label.frame = (CGRect){ .origin.x = CGRectGetMinX(self.bounds), .origin.y = self.label.font.lineHeight, .size = self.label.frame.size };
    
    if (!self.text.length) [self hideLabel];
    else if (self.isFirstResponder) [self showLabel];
}

- (UIEdgeInsets)insetRect {
    return (UIEdgeInsets){ .top = self.label.font.lineHeight };
}
              
- (void)showLabel {
    if (self.label.alpha) return;
    
    self.label.textColor = self.editingLabelTextColor;
    dispatch_semaphore_wait(_animationSemaphore, DISPATCH_TIME_FOREVER);
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
        self.label.alpha = 1.f;
        CGRect slice, remainder;
        CGRectDivide(self.label.frame, &slice, &remainder, 2.f, CGRectMinYEdge);
        self.label.frame = slice;
    } completion:^(BOOL finished) {
        dispatch_semaphore_signal(_animationSemaphore);
    }];
}

- (void)hideLabel {
    if (!self.label.alpha) return;
    
    self.label.textColor = self.labelTextColor;
    dispatch_semaphore_wait(_animationSemaphore, DISPATCH_TIME_FOREVER);
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
        self.label.alpha = 0.f;
    } completion:^(BOOL finished) {
        self.label.frame = (CGRect){ .origin.x = CGRectGetMinX(self.bounds), .origin.y = self.label.font.lineHeight, .size = self.label.frame.size };
        dispatch_semaphore_signal(_animationSemaphore);
    }];
}

@end
