//
//  ViewController.m
//  YimReaderDemo
//
//  Created by Yimmm on 2019/8/17.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import "ViewController.h"
#import "QLReadPageViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *BookButton;//图书

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
}



//点击图书
-(IBAction)clickBookButton:(id)sender {
    
    NSURL * MyTxtUrl = [[NSBundle mainBundle] URLForResource:@"MinDiaoJuYWL" withExtension:@"txt"];
    QLReadPageViewController * pageView = [[QLReadPageViewController alloc] init];
    //先设置LSYReadPageViewController属性
    pageView.resourceURL = MyTxtUrl;    //文件位置
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        pageView.RBmodel = [QLReadBookModel getReadBookModelWithLocalURL:MyTxtUrl];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:pageView animated:YES completion:nil];
        });
    });
    
//    [self.BookButton setHidden:YES];
}




@end
