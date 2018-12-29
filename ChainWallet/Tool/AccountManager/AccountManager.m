//
//  AccountManager.m
//  ChainWallet
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "AccountManager.h"
#import "AccountInfoModel.h"
#import "AESCrypt.h"
#import "TokenModel.h"
#import "AccountInfoKeysModel.h"
#import "AccountInfoModel.h"
#import "HomeViewController.h"
#import "BAICKey.h"

static AccountManager *manager = nil;
@interface AccountManager ()
//公钥
@property (copy,nonatomic) NSString *publickey;
//
@property (strong,nonatomic) NSMutableArray *keysArray;
@end

@implementation AccountManager

+ (AccountManager *)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AccountManager alloc]init];
    
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.tokenArray = [NSArray array];
        //self.keysArray = [NSMutableArray array];
    }
    return self;
}

- (BOOL)varifyAccountWithModel:(AccountModel *)model{
    
    BAICKey *ssKey = [[BAICKey alloc] initWithWIF:_baicPrivateKey];
    self.publickey = ssKey.publicKey;
    
    _account_name = model.account_name;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    BOOL isVarify = NO;
    
    for (AccountPermission *per in model.permissions) {
        
        for (AccountPerKeys *keyM in per.keys) {
            
            if ([keyM.key isEqualToString:_publickey]) {
                isVarify = YES;
            }
            NSDictionary *dict = @{@"account_name":_account_name,
                                   @"perm_name":per.perm_name,
                                   @"key":keyM.key
                                   };
            AccountInfoKeysModel *keyModel = [[AccountInfoKeysModel alloc]initWithDictionary:dict error:nil];
            [tempArray addObject:keyModel];
        }
    }
    
    if (isVarify) {
        self.keysArray = [NSMutableArray arrayWithArray:tempArray];
    }
    return isVarify;
}


- (void)saveAccountInfoWithKey:(NSString *)key{
    
    NSDictionary *dict = @{@"account_name":self.account_name,
                           @"active_privatekey":@"",
                           @"active_publickey":@"",
                           @"owner_privatekey":@"",
                           @"owner_publickey":@""
                           };
    
    //输入交易密码后，使用AES加密存储
    AccountInfoModel *infoModel = [[AccountInfoModel alloc]initWithDictionary:dict error:nil];
    for (AccountInfoKeysModel *keyModel in _keysArray) {
        if ([keyModel.perm_name isEqualToString:@"active"]) {
            BAICKey *ssKey = [[BAICKey alloc] initWithWIF:_baicPrivateKey];
            if ([keyModel.key isEqualToString:ssKey.publicKey]) {
                infoModel.active_privatekey = [AESCrypt encrypt:_baicPrivateKey password:key];
            }
            keyModel.key = [AESCrypt encrypt:keyModel.key password:key];
            infoModel.active_publickey = keyModel.key;
        }else{
            BAICKey *ssKey = [[BAICKey alloc] initWithWIF:_baicPrivateKey];

            if ([keyModel.key isEqualToString:ssKey.publicKey]) {
                infoModel.owner_privatekey = [AESCrypt encrypt:_baicPrivateKey password:key];
            }
            keyModel.key = [AESCrypt encrypt:keyModel.key password:key];
            infoModel.owner_publickey = keyModel.key;
        }
    }
    
    [infoModel bg_saveOrUpdateAsync:^(BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSUserDefaults standardUserDefaults]setObject:self.account_name forKey:ACCOUNT_KEY];

                [self changeRootViewController];
            });
        }
    }];
}

- (void)changeRootViewController{
    HomeViewController *view = [[HomeViewController alloc]init];
    UINavigationController *root = [[UINavigationController alloc]initWithRootViewController:view];
    [self restoreRootViewController:root];
}

// 登陆后淡入淡出更换rootViewController
- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    typedef void (^Animation)(void);
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

- (NSString *)current_account_name{
    //查询
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"account_name"),bg_sqlValue(ACCOUNT_NAME_VALUE)];
    NSArray* array = [AccountInfoModel bg_find:nil where:where];
    AccountInfoModel *model = [array firstObject];
    return model.account_name;
}

- (NSArray *)account_nameArray{
    NSArray* array = [AccountInfoModel bg_findAll:nil];
    NSMutableArray *accountArray = [NSMutableArray array];
    for (AccountInfoModel *info in array) {
        [accountArray addObject:info.account_name];
    }
    return accountArray;
}

- (NSArray *)current_account_info{
    //查询
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"account_name"),bg_sqlValue(ACCOUNT_NAME_VALUE)];
    NSArray* array = [AccountInfoModel bg_find:nil where:where];
    return array;
}
@end
