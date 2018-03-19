/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "LoginViewController.h"

#import <MaterialComponents/MaterialButtons.h>
#import <MaterialComponents/MaterialTextFields.h>

@interface LoginViewController () <UITextFieldDelegate>

@property(nonatomic) UIScrollView *scrollView;

@property(nonatomic) UILabel *titleLabel;
@property(nonatomic) UIImageView *logoImageView;

// Text Fields
@property(nonatomic) MDCTextField *usernameTextField;
@property(nonatomic) MDCTextField *passwordTextField;

@property(nonatomic) MDCTextInputControllerFilled *usernameTextFieldController;
@property(nonatomic) MDCTextInputControllerFilled *passwordTextFieldController;

// Buttons
@property(nonatomic) MDCFlatButton *cancelButton;
@property(nonatomic) MDCRaisedButton *nextButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  [self registerKeyboardNotifications];

  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
  self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.scrollView];

  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"V:|[scrollView]|"
                        options:0
                        metrics:nil
                        views:@{
                                @"scrollView" : self.scrollView
                                }]];
  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|[scrollView]|"
                        options:0
                        metrics:nil
                        views:@{
                                @"scrollView" : self.scrollView
                                }]];
  UIEdgeInsets margins = UIEdgeInsetsMake(0, 16, 0, 16);
  self.scrollView.layoutMargins = margins;

  UITapGestureRecognizer *tapGestureRecognizer =
  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDidTouch:)];
  [self.scrollView addGestureRecognizer:tapGestureRecognizer];

  self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.titleLabel.text = @"Shrine";
  [self.titleLabel sizeToFit];
  [self.scrollView addSubview:self.titleLabel];

  UIImage *logoImage = [UIImage imageNamed:@"ShrineLogo"];
  self.logoImageView = [[UIImageView alloc] initWithImage:logoImage];
  self.logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:self.logoImageView];

  // Text Fields
  self.usernameTextField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  self.usernameTextField.translatesAutoresizingMaskIntoConstraints = NO;
  self.usernameTextField.delegate = self;
  self.usernameTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
  [self.scrollView addSubview:self.usernameTextField];

  self.usernameTextFieldController =
    [[MDCTextInputControllerFilled alloc] initWithTextInput:self.usernameTextField];
  self.usernameTextFieldController.placeholderText = @"Username";

  self.passwordTextField = [[MDCTextField alloc] initWithFrame:CGRectZero];
  self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
  self.passwordTextField.delegate = self;
  self.passwordTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
  [self.scrollView addSubview:self.passwordTextField];

  self.passwordTextFieldController =
  [[MDCTextInputControllerFilled alloc] initWithTextInput:self.passwordTextField];
  self.passwordTextFieldController.placeholderText = @"Password";

  // Buttons
  self.cancelButton = [[MDCFlatButton alloc] init];
  self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
  [self.scrollView addSubview:self.cancelButton];

  self.nextButton = [[MDCRaisedButton alloc] initWithFrame:CGRectZero];
  self.nextButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.nextButton setTitle:@"NEXT" forState:UIControlStateNormal];
  [self.scrollView addSubview:self.nextButton];

  // Layout Constraints

  NSMutableArray <NSLayoutConstraint *> *constraints = [[NSMutableArray alloc] init];

  NSLayoutConstraint *titleTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView.contentLayoutGuide
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:40];
  [constraints addObject:titleTopConstraint];

  NSLayoutConstraint *centerTitleConstraint =
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1.f constant:0.f];
  [constraints addObject:centerTitleConstraint];

  NSLayoutConstraint *logoTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.logoImageView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.titleLabel
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:49];
  [constraints addObject:logoTopConstraint];

  NSLayoutConstraint *centerLogoConstraint =
  [NSLayoutConstraint constraintWithItem:self.logoImageView
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1.f constant:0.f];
  [constraints addObject:centerLogoConstraint];

  NSLayoutConstraint *usernameTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.usernameTextField
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.logoImageView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:8];
  [constraints addObject:usernameTopConstraint];

  NSLayoutConstraint *centerUsernameConstraint =
  [NSLayoutConstraint constraintWithItem:self.usernameTextField
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1.f constant:0.f];
  [constraints addObject:centerUsernameConstraint];

  NSArray <NSLayoutConstraint *> *horizontalUsernameConstraints =
  [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[username]-|"
                                          options:0
                                          metrics:nil
                                            views:@{ @"username" : self.usernameTextField }];
  [constraints addObjectsFromArray:horizontalUsernameConstraints];

  NSLayoutConstraint *passwordTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.passwordTextField
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.usernameTextField
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:8];
  [constraints addObject:passwordTopConstraint];

  NSLayoutConstraint *centerPasswordConstraint =
  [NSLayoutConstraint constraintWithItem:self.passwordTextField
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1.f constant:0.f];
  [constraints addObject:centerPasswordConstraint];

  NSArray <NSLayoutConstraint *> *horizontalPasswordConstraints =
  [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[password]-|"
                                          options:0
                                          metrics:nil
                                            views:@{ @"password" : self.passwordTextField }];
  [constraints addObjectsFromArray:horizontalPasswordConstraints];

  NSLayoutConstraint *cancelTopConstraint =
  [NSLayoutConstraint constraintWithItem:self.cancelButton
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.passwordTextField
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:8];
  [constraints addObject:cancelTopConstraint];

  NSLayoutConstraint *centerCancelConstraint =
  [NSLayoutConstraint constraintWithItem:self.cancelButton
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1.f constant:0.f];
  [constraints addObject:centerCancelConstraint];

  NSLayoutConstraint *centerButtonsConstraint =
  [NSLayoutConstraint constraintWithItem:self.cancelButton
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.nextButton
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1.f constant:0.f];
  [constraints addObject:centerButtonsConstraint];

  NSArray <NSLayoutConstraint *> *horizontalButtonConstraints =
  [NSLayoutConstraint constraintsWithVisualFormat:@"H:[cancel]-[next]-|"
                                          options:0
                                          metrics:nil
                                            views:@{ @"cancel" : self.cancelButton, @"next" : self.nextButton }];
  [constraints addObjectsFromArray:horizontalButtonConstraints];

  NSLayoutConstraint *scrollContentBottomConstraint =
                                            [NSLayoutConstraint constraintWithItem:self.nextButton
                                                                         attribute:NSLayoutAttributeBottom
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.scrollView.contentLayoutGuide
                                                                         attribute:NSLayoutAttributeBottomMargin
                                                                        multiplier:1
                                                                          constant:-20];
  [constraints addObject:scrollContentBottomConstraint];

  [NSLayoutConstraint activateConstraints:constraints];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];

  if (textField == (UITextField *)self.passwordTextField &&
      self.passwordTextField.text.length < 8) {
    [self.passwordTextFieldController setErrorText:@"Password is too short" errorAccessibilityValue:nil];
  }

  return NO;
}

#pragma mark - Gesture Handling

- (void)tapDidTouch:(UIGestureRecognizer *)sender {
  [self.view endEditing:YES];
}

#pragma mark - Keyboard Handling

- (void)registerKeyboardNotifications {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillChangeFrameNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notif {
  CGRect keyboardFrame = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
  self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(keyboardFrame), 0);
}

- (void)keyboardWillHide:(NSNotification *)notif {
  self.scrollView.contentInset = UIEdgeInsetsZero;
}



@end
