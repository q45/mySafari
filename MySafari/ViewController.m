//
//  ViewController.m
//  MySafari
//
//  Created by Q on 3/16/14.
//  Copyright (c) 2014 wasatchCode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UITextField *myURLTextField;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)onBackButtonPressed:(id)sender;
- (IBAction)onForwardButtonPressed:(id)sender;
- (IBAction)onStopLoadingButtonPressed:(id)sender;
- (IBAction)onReloadButtonPressed:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (self.myWebView.canGoForward) {
        [self.forwardButton setEnabled:TRUE];
    } else {
       
        [self.forwardButton setEnabled:FALSE];
    }
    
    if (self.myWebView.canGoBack) {
        [self.backButton setEnabled:TRUE];
    } else {
        [self.backButton setEnabled:FALSE];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
   
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *URLString = textField.text;
    NSURL *url = [NSURL URLWithString:URLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.myWebView loadRequest:request];
    
    return YES;
}

- (IBAction)onBackButtonPressed:(UIButton *)sender
{
    
    [self.myWebView goBack];
    
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    
    
    [self.myWebView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(id)sende
{
    [self.myWebView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender
{
    [self.myWebView reload];
}
@end
