//
//  StartViewController.h
//  SimpleCoreData
//
//  Created by Kasper Spychala on 03/10/2024.
//

#import <UIKit/UIKit.h>

// Forward declare Swift protocol and classes
@protocol StartViewModelProtocol;
@class StartCoordinator;
@class StartView;

NS_ASSUME_NONNULL_BEGIN

@interface StartViewController : UIViewController

// Property for the viewModel (adheres to Swift protocol)
@property (nonatomic, strong) id<StartViewModelProtocol> viewModel;

@end

NS_ASSUME_NONNULL_END
