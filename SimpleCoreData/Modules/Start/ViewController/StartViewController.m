//
//  StartViewController.m
//  SimpleCoreData
//
//  Created by Kasper Spychala on 03/10/2024.
//

#import <Foundation/Foundation.h>

#import "StartViewController.h"
#import "SimpleCoreData-Swift.h"

@interface StartViewController ()

@property (nonatomic, strong) StartView *contentView;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleButton];
    [self updateCompanyName];
}

- (void)loadView {
    [super loadView];

    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];

    self.contentView = [[StartView alloc] initWithFrame:CGRectZero];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.contentView];

    [NSLayoutConstraint activateConstraints:@[
        [self.contentView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor]
    ]];
}

- (void)updateCompanyName {
    NSString *companyName = [self.viewModel getCompanyName];
    if (companyName == nil) {
        NSLog(@"Company name not accessible");
        return;
    }
    [self.contentView updateCompanyNameWithName:companyName];
}

- (void)handleButton {
    __weak typeof(self) weakSelf = self;
    self.contentView.onButtonTap = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.viewModel navigateToSubmit];
    };
}

@end
