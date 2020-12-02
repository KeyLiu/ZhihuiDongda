//
//  ScanViewController.m
//  code
//
//  Created by KeyLiu on 2020/11/2.
//

#import "ScanViewController.h"
#import "QiCodeReader/QiCodePreviewView.h"
#import "QiCodeReader/QiCodeManager.h"
#import "ViewController.h"

@interface ScanViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) QiCodePreviewView *previewView;
@property (nonatomic, strong) QiCodeManager *codeManager;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"二维码";
    
    //UIBarButtonItem *photoItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photo:)];
    //self.navigationItem.rightBarButtonItem = photoItem;
    
    _previewView = [[QiCodePreviewView alloc] initWithFrame:self.view.bounds];
    _previewView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_previewView];
    
    __weak typeof(self) weakSelf = self;
    _codeManager = [[QiCodeManager alloc] initWithPreviewView:_previewView completion:^{
        [weakSelf startScanning];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self startScanning];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [_codeManager stopScanning];
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Action functions

- (void)photo:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    [_codeManager presentPhotoLibraryWithRooter:self callback:^(NSString * _Nonnull code) {
        [weakSelf performSegueWithIdentifier:@"showCodeGeneration" sender:code];
    }];
}


#pragma mark - Private functions

- (void)startScanning {
    
    __weak typeof(self) weakSelf = self;
    [_codeManager startScanningWithCallback:^(NSString * _Nonnull code) {
        [weakSelf.navigationController pushViewController:[[ViewController alloc]init] animated:YES];
    } autoStop:YES];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [self.navigationController pushViewController:[[ViewController alloc]init] animated:YES];
//    if ([segue.identifier isEqualToString:@"showCodeGeneration"]) {
//        QiCodeGenerationViewController *codeGeneration = segue.destinationViewController;
//        codeGeneration.code = (NSString *)sender;
    
//    }
}

////控制扫描线上下滚动
//- (void)timerMethod{
//    if (upOrDown == NO) {
//        num ++;
//        _line.frame = CGRectMake(CGRectGetMinX(_imageView.frame)+5, CGRectGetMinY(_imageView.frame)+5+num, CGRectGetWidth(_imageView.frame)-10, 3);
//        if (num == (int)(CGRectGetHeight(_imageView.frame)-10)) {
//            upOrDown = YES;
//        }
//    }
//    else{
//        num --;
//        _line.frame = CGRectMake(CGRectGetMinX(_imageView.frame)+5, CGRectGetMinY(_imageView.frame)+5+num, CGRectGetWidth(_imageView.frame)-10, 3);
//        if (num == 0) {
//            upOrDown = NO;
//        }
//    }
//}
 
@end


