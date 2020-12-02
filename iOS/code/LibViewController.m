//
//  LibViewController.m
//  code
//
//  Created by KeyLiu on 2020/9/27.
//

#import "LibViewController.h"
#import "SettingViewController.h"

@interface LibViewController (){
    @private
    NSString * nameString;
    NSString * personIDString;
}

@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *address;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *personID;
@property(nonatomic,strong)UIImageView *imgView;

@end

@implementation LibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self setModel];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)initUI{
    
    
    UIColor *mainColor = [UIColor colorWithRed:99/255.0 green:173/255.0 blue:252/255.0 alpha:1];

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Setting" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(10, 40, 80, 40)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchDown];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, WIDTH, 100)];
    [title setTextColor:mainColor];
    title.text = @"东北大学通行验证";
    [title setFont:[UIFont boldSystemFontOfSize:25]];
    title.textAlignment = NSTextAlignmentCenter;
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 100, 200, 200, 200)];
    [imgView setImage:[UIImage imageNamed:@"in"]];
    
    UIView * subView = [[UIView alloc]initWithFrame:CGRectMake(0,450, WIDTH, 240)];
    [subView setBackgroundColor:mainColor];
    //subView.backgroundColor =
    
    UILabel * time = [[UILabel alloc]initWithFrame:CGRectMake(0,400, WIDTH, 50)];
    UILabel * userID = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WIDTH,40)];
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, WIDTH, 40)];
    UILabel * address = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, WIDTH, 40)];
    UILabel * state = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, WIDTH, 40)];
    UILabel * review = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, WIDTH, 40)];
    
    time.textAlignment = NSTextAlignmentCenter;
    userID.textAlignment = NSTextAlignmentLeft;
    name.textAlignment = NSTextAlignmentLeft;
    address.textAlignment = NSTextAlignmentLeft;
    state.textAlignment = NSTextAlignmentLeft;
    review.textAlignment = NSTextAlignmentLeft;
    
    [time setTextColor:mainColor];
    
    [userID setTextColor:[UIColor whiteColor]];
    [name setTextColor:[UIColor whiteColor]];
    [address setTextColor:[UIColor whiteColor]];
    [state setTextColor:[UIColor whiteColor]];
    [review setTextColor:[UIColor whiteColor]];
    
    state.text = @"\t进入状态：进入";
    address.text = @"\t验证位置：浑南校区图书馆";
    review.text = @"\t审核状态：未经审核";
    
    [self.view addSubview:title];
    [self.view addSubview:imgView];
    [self.view addSubview:time];

    [self.view addSubview:subView];
    
    [subView addSubview:userID];
    [subView addSubview:name];
    [subView addSubview:address];
    [subView addSubview:state];
    [subView addSubview:review];
    
    self.personID = userID;
    self.address = address;
    self.name = name;
    self.time = time;
    self.imgView = imgView;
}

- (void)viewWillAppear:(BOOL)animated{
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
       self.imgView.frame = CGRectMake(WIDTH/2 - 125, 175, 250, 250);
   } completion:^(BOOL finished) {
       self.imgView.frame = CGRectMake(WIDTH/2 - 100, 200, 200, 200);
   }];
}

- (void) setModel{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    self.time.text = [NSString stringWithFormat:@"时间：%@",[formatter stringFromDate:[NSDate date]]];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)       objectAtIndex:0]stringByAppendingPathComponent:@"PropertyList.plist"];
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:path]){
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        
        
        [dic setObject:@"1871997" forKey:@"personID"];
        [dic setObject:@"浑南校区东门" forKey:@"address"];
        [dic setObject:@"小明" forKey:@"name"];
        
        [dic writeToFile:path atomically:YES];
        
    }
    
    NSMutableDictionary * dataDic = [[[NSMutableDictionary alloc]initWithContentsOfFile:path]mutableCopy];

    nameString = [dataDic objectForKey:@"name"];
    personIDString = [dataDic objectForKey:@"personID"];
    
    self.name.text = [NSString stringWithFormat:@"\t姓名\t  ：%@",nameString];
    self.personID.text = [NSString stringWithFormat:@"\t学工号\t  ：%@",personIDString];
}

- (void) btnClick{
    
    SettingViewController * setting = [[SettingViewController alloc]init];
    
    setting.name = nameString;
    setting.personID = personIDString;
    setting.hasAddress = FALSE;
    
    __weak typeof(self) weakSelf = self;
    setting.returnBlock = ^(){
        __strong typeof(weakSelf) strongWeak = weakSelf;
        [strongWeak setModel];
    };
    
    [self presentViewController:setting animated:YES completion:^{
          
            
    }];

}

-(void)dealloc{
    
}

@end
