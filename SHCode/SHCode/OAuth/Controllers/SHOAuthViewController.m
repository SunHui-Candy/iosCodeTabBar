//
//  SHOAuthViewController.m
//  SHCode
//
//  Created by ios on 17/4/11.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHOAuthViewController.h"
#import "SHUserAccount.h"
#import "SHUserAccountViewModel.h"
#import "SHWelcomeViewController.h"

@interface SHOAuthViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
//@property (nonatomic, strong) SHUserAccount *userAccount;

@end

@implementation SHOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录页面";
    
    [self loadPage];
}

#pragma mark - delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    
    if ([urlStr containsString:@"code="]) {
        NSString *code = [urlStr componentsSeparatedByString:@"code="].lastObject;
        [self loadAccessToken:code];

        return NO;
    }
    return YES;
    
}


#pragma mark - Private&Public Methods
//请求数据
- (void)loadAccessToken:(NSString *)code
{
    /*
     ,{
     "access_token" = "2.00_5u7IDl8OPNE4f2a11e4cc9ik7aB";
     "expires_in" = 157679999;
     "remind_in" = 157679999;
     uid = 2873022483;
     }
     */
    
    [[SHNetworkTools shareInstance] loadAccessToken:code success:^(id responseObject) {
        NSLog(@"授权成功,,%@",responseObject);
        SHUserAccount *userAccount = [SHUserAccount mj_objectWithKeyValues:responseObject];
        [self loadUserInfo:userAccount];
    } failure:^(NSError *error) {
        NSLog(@"授权失败,,,%@",error);
        
    }];
}

- (void)loadUserInfo:(SHUserAccount *)userAccount
{
    /*
     {
     "allow_all_act_msg" = 0;
     "allow_all_comment" = 1;
     "avatar_hd" = "http://tva1.sinaimg.cn/crop.0.0.1241.1241.1024/ab3ed813jw8f95i9eq40nj20yi0yhn3t.jpg";
     "avatar_large" = "http://tva1.sinaimg.cn/crop.0.0.1241.1241.180/ab3ed813jw8f95i9eq40nj20yi0yhn3t.jpg";
     "bi_followers_count" = 0;
     "block_app" = 0;
     "block_word" = 0;
     city = 1000;
     class = 1;
     "created_at" = "Sat Jul 07 08:45:42 +0800 2012";
     "credit_score" = 80;
     description = "";
     domain = "";
     "favourites_count" = 0;
     "follow_me" = 0;
     "followers_count" = 9;
     following = 0;
     "friends_count" = 67;
     gender = f;
     "geo_enabled" = 1;
     id = 2873022483;
     idstr = 2873022483;
     insecurity =     {
     "sexual_content" = 0;
     };
     lang = "zh-cn";
     location = "\U5b89\U5fbd";
     mbrank = 0;
     mbtype = 0;
     name = "\U624b\U673a\U7528\U62372873022483";
     "online_status" = 0;
     "pagefriends_count" = 0;
     "profile_image_url" = "http://tva1.sinaimg.cn/crop
     
     */
    
    [[SHNetworkTools shareInstance] loadUserInfo:userAccount.access_token uid:userAccount.uid success:^(id responseObject) {
        NSLog(@"获取用户信息成功%@",responseObject);
        userAccount.name = responseObject[@"name"];
        userAccount.avatar_large = responseObject[@"avatar_large"];
        
        NSString *path = [[SHUserAccountViewModel shareInstance] accountPath];
        
        [NSKeyedArchiver archiveRootObject:userAccount toFile:path];
        NSLog(@"地址的,,%@",path);
        
        
        [SHUserAccountViewModel shareInstance].account = userAccount;
        
        SHWelcomeViewController *welcomeVC = [[SHWelcomeViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = welcomeVC;
    } failure:^(NSError *error) {
        NSLog(@"获取用户信息失败%@",error);
    }];
    
}

- (void)loadPage
{
    NSString *urlStr = kFormat(@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", app_key,redirect_uri);
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


- (void)setupNavItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"填充" style:UIBarButtonItemStylePlain target:self action:@selector(fillItemClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClick)];
}

- (void)closeItemClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//  let jsCode = "document.getElementById('userId').value='1606020376@qq.com';document.getElementById('passwd').value='haomage';"

- (void)fillItemClick
{
    NSString *jsCode = @"document.getElementById('userId').value='13837165010';document.getElementById('passwd').value='hui1126.';";
    [self.webView stringByEvaluatingJavaScriptFromString:jsCode];

}
@end


















