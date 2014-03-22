//
//  ViewController.m
//  MySafari
//
//  Created by Q on 3/16/14.
//  Copyright (c) 2014 wasatchCode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UITextField *myURLTextField;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)onBackButtonPressed:(id)sender;
- (IBAction)onForwardButtonPressed:(id)sender;
- (IBAction)onStopLoadingButtonPressed:(id)sender;
- (IBAction)onReloadButtonPressed:(id)sender;
- (IBAction)teaserButton:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.myURLTextField.text = @"http://";
    
    self.myWebView.scrollView.delegate = self;
    
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
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myWebView)];
    gestureRecognizer.delegate = self;
    [self.myWebView addGestureRecognizer:gestureRecognizer];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
   
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
    if([self.myWebView canGoForward]) {
        self.forwardButton.enabled = YES;
    }
    
    if([self.myWebView canGoBack]) {
        self.backButton.enabled = YES;
    }
    
    self.myURLTextField.text = [self.myWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *URLString = textField.text;
    NSString *formatUrl = [NSString stringWithFormat:@"%@%@", @"http://",URLString];
    
    NSURL *url = [NSURL URLWithString:formatUrl];
   
    
    NSLog(@"%@", formatUrl);

    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.myWebView loadRequest:request];
    
    [self.myURLTextField resignFirstResponder];
    
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

- (IBAction)onStopLoadingButtonPressed:(id)sender
{
    [self.myWebView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender
{
    [self.myWebView reload];
}

- (IBAction)teaserButton:(id)sender {
    UIAlertView *teaser = [[UIAlertView alloc]initWithTitle:@"Coming Soon    " message:@"We have big plans!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [teaser show];
}

#pragma mark - scrolling

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"%f", self.myWebView.scrollView.contentOffset.y);
    
    if (self.myWebView.scrollView.contentOffset.y > 100) {
        [[self myURLTextField] setHidden:YES];
    } else {
        [[self myURLTextField] setHidden:NO];
    }
}
@end
