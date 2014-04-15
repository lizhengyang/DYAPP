//
//  DYSecondViewController.m
//  DYAPP
//
//  Created by dev on 13-12-18.
//  Copyright (c) 2013年 dy. All rights reserved.
//

#import "DYMoreViewController.h"
#import "ACPButton.h"
#import "DXAlertView.h"
#import "CheckNetwork.h"
@interface DYMoreViewController ()

@end

@implementation DYMoreViewController

NSDictionary *dictionary;
NSArray * groups;

- (void)viewDidLoad
{

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
    // 获取plist资源文件地址
    NSString *path = [[NSBundle mainBundle] pathForResource:@"moreList" ofType:@"plist"];
    dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // 根据字典，获得分类名称
    groups = [[dictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    //改变tabview的背景颜色
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// tableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"Contact";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    
    NSString *group = [groups objectAtIndex:[indexPath section]];
    NSArray * contactSection = [dictionary objectForKey:group];
    NSString *cllstr = [contactSection objectAtIndex:[indexPath row]];
    if(![cllstr isEqualToString:@"版本号："]){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = cllstr;
    }else{
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
        cllstr = [cllstr stringByAppendingString:@" V"];
        cell.textLabel.text =  [cllstr stringByAppendingString:version];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.imageView.image = nil;
	cell.accessoryView = nil;
    
    return cell;
}
//分组
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [groups count];
}


//使用UITableViewDataSource协议的tableView:numberOfRowsInSection:方法
//该方法用来设置Table View中要显示数据的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *group = [groups objectAtIndex:section];
    NSArray *contactSection = [dictionary objectForKey:group];
    return [contactSection count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.0;
        case 1:
            return 130.0;
        default:
            return 0.0;
    }
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *group = [groups objectAtIndex:section];
    return group;
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    
    UIView *headerLabelContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 0.0)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 280.0, 0.0)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont systemFontOfSize:15.0];
    headerLabel.textColor = [UIColor colorWithRed:61.0/255.0 green:77.0/255.0 blue:99.0/255.0 alpha:1.0];
    headerLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.65];
    headerLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.numberOfLines = 0;
    
    headerLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    
    NSString *group = [groups objectAtIndex:section];
    headerLabel.text = group;
    
    [headerLabel sizeToFit];
    
    CGRect headerLabelContainerViewRect = headerLabelContainerView.frame;
    headerLabelContainerViewRect.size.height = headerLabel.frame.size.height;
    headerLabel.frame = headerLabelContainerViewRect;
    
    [headerLabelContainerView addSubview:headerLabel];
    
    CGRect headerLabelFrame = headerLabel.frame;
    headerLabelFrame.size.width = 280.0;
    headerLabelFrame.origin.x = 20.0;
    headerLabelFrame.origin.y = 5.0;
    //headerLabelFrame.size.height -= 10.0;
    headerLabel.frame = headerLabelFrame;
    CGRect containerFrame = headerLabelContainerView.frame;
    containerFrame.size.height = headerLabel.frame.size.height;
    headerLabelContainerView.frame = containerFrame;
    
    
    if (section == 1) {
        [headerLabel setTextColor:[UIColor redColor]];
    }
    return headerLabelContainerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *group = [groups objectAtIndex:[indexPath section]];
    if([group isEqualToString:@"服务电话"]){
        
        NSArray * contactSection = [dictionary objectForKey:group];
        NSString *cllstr = [contactSection objectAtIndex:[indexPath row]];
        cllstr = [@"tel://" stringByAppendingString:cllstr];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:cllstr]];
    }else{
        NSArray * contactSection = [dictionary objectForKey:group];
        NSString *cllstr = [contactSection objectAtIndex:[indexPath row]];
        if([cllstr isEqualToString:@"关于大银"]){
            NSURL*url =[NSURL URLWithString:@"http://www.dycf.cn"];
            [[UIApplication sharedApplication] openURL:url];
        }else if ([cllstr isEqualToString:@"检测网络"]){
            
            NSString *result=[CheckNetwork isExistenceNetwork];
            
            if([result isEqualToString:@""]){
                DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"网络状态" contentText:@"网络状况正常" leftButtonTitle:nil rightButtonTitle:@"确定"];
                [alert show];
            }
        }
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == [groups count] - 1)
    {
        
        ACPButton *button = [ACPButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"关闭程序" forState:UIControlStateNormal ];
        
        [button addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(60, 10, 180,30)];
        [button setStyleType:ACPButtonCancel];
        [button setCornerRadius:10];
        CGRect resultFrame = CGRectMake(0.0f, 0.0f,button.frame.size.height+ 10.0f,button.frame.size.width + 10.0f);
        UIView *footerView = [[UIView alloc] initWithFrame:resultFrame];
        [footerView addSubview:button];
        return footerView;
        //return button;
    }
    return nil;
}

- (void)closeBtnClicked:(id)sender{
    
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"退出" contentText:@"确定要退出大银云商吗？" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    [alert show];
    alert.leftBlock = ^() {
        exit(0);         //退出应用程序
    };
}



- (void)dealloc {
    self.tabView = nil;
}


@end

