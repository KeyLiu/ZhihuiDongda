//
//  SettingViewController.m
//  code
//
//  Created by KeyLiu on 2020/9/25.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITextFieldDelegate>{
    @private
    bool isChanged;
}

@property(nonatomic,strong) UITextField * nameTextField;
@property(nonatomic,strong) UITextField * personIDTextField;
@property(nonatomic,strong) UITextField * addressTextField;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isChanged = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    
    
}

- (void) setMode{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)       objectAtIndex:0]stringByAppendingPathComponent:@"PropertyList.plist"];
    
    NSMutableDictionary * infoList = [[NSMutableDictionary alloc]init];
    
    
    [infoList setObject:self.personIDTextField.text forKey:@"personID"];
    [infoList setObject:self.addressTextField.text forKey:@"address"];
    [infoList setObject:self.nameTextField.text forKey:@"name"];

    
    [infoList writeToFile:path atomically:YES];
}

- (void) setUI{
    
    UIView *naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
    [naviView setBackgroundColor:[UIColor colorWithRed:87/255.0 green:154/255.0 blue:235/255.0 alpha:1]];
    [self.view addSubview:naviView];
    
    UITextField * nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 90, WIDTH - 50, 40)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    UITextField * personIDField = [[UITextField alloc]initWithFrame:CGRectMake(25, 150, WIDTH - 50, 40)];
    personIDField.borderStyle = UITextBorderStyleRoundedRect;
    UITextField * addressField = [[UITextField alloc]initWithFrame:CGRectMake(25,210, WIDTH - 50, 40)];
    addressField.borderStyle = UITextBorderStyleRoundedRect;
    
    nameTextField.text = self.name;
    personIDField.text = self.personID;
    addressField.text = self.address;
    
    nameTextField.delegate = self;
    personIDField.delegate = self;
    addressField.delegate = self;
    
    [self.view addSubview:nameTextField];
    [self.view addSubview:personIDField];
    
    if(_hasAddress)
        [self.view addSubview:addressField];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cancelBtn.frame = CGRectMake(10, 40, 80, 40);
    sureBtn.frame = CGRectMake(WIDTH - 90, 40,80, 40);
    
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    
    [naviView addSubview:cancelBtn];
    [naviView addSubview:sureBtn];
    
    self.personIDTextField = personIDField;
    self.nameTextField = nameTextField;
    self.addressTextField = addressField;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    isChanged = YES;
}

- (void) cancelClick{
    
    [self dismissViewControllerAnimated:YES completion:^{
            
    }];
}

- (void) sureClick{
    if(isChanged){
        [self setMode];
    }
    
    self.returnBlock();
    [self cancelClick];
}

@end
