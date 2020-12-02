//
//  SettingViewController.h
//  code
//
//  Created by KeyLiu on 2020/9/25.
//

#import <UIKit/UIKit.h>

#define HEIGHT [[UIScreen mainScreen]bounds].size.height
#define WIDTH [[UIScreen mainScreen]bounds].size.width

@interface SettingViewController : UIViewController

@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * personID;
@property(nonatomic,assign)BOOL hasAddress;

@property(nonatomic,copy)void(^returnBlock)(void);

@end
