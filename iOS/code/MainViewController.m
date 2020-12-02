//
//  MainViewController.m
//  code
//
//  Created by KeyLiu on 2020/9/27.
//

#import "MainViewController.h"
#import "ViewController.h"
#import "LibViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI{
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(20, 90, WIDTH - 40, 40);
    [btn1 setTitle:@"进门" forState:UIControlStateNormal];
    btn1.tag = 1;
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(20, 140, WIDTH - 40, 40);
    [btn2 setTitle:@"图书馆" forState:UIControlStateNormal];
    btn2.tag = 2;
    
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
}

- (void)btnClick:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    if(btn.tag == 1){
        [self.navigationController pushViewController:[[ViewController alloc]init] animated:YES];
    }else{
        [self.navigationController pushViewController:[[LibViewController alloc]init] animated:YES];
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
