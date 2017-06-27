//
//  AddBusinessOpptyViewController.m
//  FoldCellDemo
//
//  Created by Turbo on 2017/6/27.
//  Copyright © 2017年 Turbo. All rights reserved.
//

#import "AddBusinessOpptyViewController.h"
#import "AddBusinessOppCell.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface AddBusinessOpptyViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    CGFloat keyboardHeight;
}
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;  //右边内容
@property (nonatomic, strong) NSMutableArray *titlesArray;      //左边标题
@property (nonatomic, strong) NSMutableArray *rowsNumArray;     //二级菜单row个数
@property (nonatomic, strong) NSMutableArray *openStatusArray;  //二级菜单打开状态

@end

@implementation AddBusinessOpptyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    [self removeObserver:self forKeyPath:UIKeyboardWillShowNotification];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加商机";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(25, 136, 53);
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    self.titlesArray = [NSMutableArray arrayWithCapacity:0];
    self.rowsNumArray = [NSMutableArray arrayWithCapacity:0];
    self.openStatusArray = [NSMutableArray arrayWithCapacity:0];
    
    [self initUI];
    
    [self fetchdata];
    
}

- (void)initUI {
    
    CGRect tFrame = self.view.bounds;
    tFrame.origin.y = 0.f;
    tFrame.size.height = tFrame.size.height-60.0f;
    self.tableView = [[UITableView alloc] initWithFrame:tFrame style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[AddBusinessOppCell class] forCellReuseIdentifier:@"AddBusinessOppCell"];
    
    [self createFooterView];
    
    /* 保存 */
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    save.frame = CGRectMake(SCREEN_WIDTH/2-40.0f, self.view.frame.size.height-45.0f, 80.0f, 35.0f);
    save.backgroundColor = RGBCOLOR(25, 136, 53);
    save.layer.cornerRadius = 17.5f;
    [save setTitle:@"保存" forState:UIControlStateNormal];
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:save];
}

- (void)fetchdata {
    
    for (int i = 0; i < 10; i++) {
        [self.titlesArray addObject:@"项目经理"];
        [self.rowsNumArray addObject:@0];
        [self.openStatusArray addObject:@0];
        if (i > 4) {
            [self.dataSourceArray addObject:@""];
        } else {
            if (i == 1) {
                [self.dataSourceArray addObject:@"潘多拉魔盒"];
            } else {
                [self.dataSourceArray addObject:@"尚二狗"];
            }
        }
    }
    
    [self.tableView reloadData];
}

- (void)createFooterView {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(.0f, .0f, SCREEN_WIDTH, 154.0f)];
    footerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footerView;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, .0f, SCREEN_WIDTH/2, 44.0f)];
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.text = @"备注";
    [footerView addSubview:titleLabel];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20.0f, CGRectGetMaxY(titleLabel.frame), SCREEN_WIDTH-40.0f, 120.0f)];
    textView.backgroundColor = RGBCOLOR(235, 235, 235);
    textView.font = [UIFont systemFontOfSize:14.0f];
    textView.layer.cornerRadius = 3.0f;
    textView.delegate = self;
    textView.returnKeyType = UIReturnKeyDone;
    [footerView addSubview:textView];
}


#pragma mark
#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    [UIView animateWithDuration:.25f animations:^{
        [self.tableView setContentOffset:CGPointMake(0, self.dataSourceArray.count*44.0f + 154.0f - self.view.frame.size.height + keyboardHeight)];
    } completion:^(BOOL finished) {
        [textView becomeFirstResponder];
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark - UITableView dataSource and delegate method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titlesArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, 44.0f)];
    sectionHeader.backgroundColor = [UIColor whiteColor];
    sectionHeader.tag = 200+section;
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, .0f, SCREEN_WIDTH/2, 44.0f)];
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.text = self.titlesArray[section];
    [sectionHeader addSubview:titleLabel];
    
    // 内容
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-12.0f-20, .0f, SCREEN_WIDTH/2, 44.0f)];
    
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.textAlignment = NSTextAlignmentRight;
    textField.textColor = [UIColor blackColor];
    textField.alpha = 0.6;
    textField.text = self.dataSourceArray[section];
    textField.tag = section;
    textField.delegate = self;
    [textField addTarget:self action:@selector(onEditing:) forControlEvents:UIControlEventEditingChanged];
    textField.returnKeyType = UIReturnKeyDone;
    
    if (section > 4) {
        textField.userInteractionEnabled = NO;
    } else {
        textField.userInteractionEnabled = YES;
        if (section == 1) {
            textField.userInteractionEnabled = NO;
            textField.alpha = 0.35;
        }
    }
    [sectionHeader addSubview:textField];
    
    // 箭头
    UIImage *image = [UIImage imageNamed:@"arrow.jpg"];
    UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20.0f, 18.0f, 10.0f, 8.0f)];
    arrowImgV.image = image;
    arrowImgV.tag = 300+section;
    arrowImgV.transform = CGAffineTransformMakeRotation(-M_PI_2);
    NSNumber *status = self.openStatusArray[section];
    if ([status isEqual:@1]) {
        arrowImgV.transform = CGAffineTransformIdentity;
    }
    [sectionHeader addSubview:arrowImgV];
    arrowImgV.hidden = YES;
    
    if (section > 4) {
        arrowImgV.hidden = NO;
    } else {
        textField.frame = CGRectMake(SCREEN_WIDTH/2-12.0f, .0f, SCREEN_WIDTH/2, 44.0f);
        arrowImgV.hidden = YES;
    }
    
    // 分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15.f, 43.5f, SCREEN_WIDTH-15.f, .5f)];
    line.backgroundColor = [UIColor blackColor];
    line.alpha = 0.1;
    [sectionHeader addSubview:line];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImg:)];
    [sectionHeader addGestureRecognizer:tap];
    
    return sectionHeader;
}

#pragma mark - 编辑内容
- (void)onEditing:(UITextField *)textField {
    
    NSInteger index = textField.tag;
    NSString *text = self.dataSourceArray[index];
    text = textField.text;
    [self.dataSourceArray replaceObjectAtIndex:index withObject:text];
    [self.tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - cell折叠与展开
- (void)tapImg:(UIGestureRecognizer *)gesture {
    
    [self.view endEditing:YES];
    
    NSInteger index = gesture.view.tag - 200;
    if (index > 4) {
        NSNumber *status = self.openStatusArray[index];
        
        if ([status isEqual:@0]) {
            [self.rowsNumArray replaceObjectAtIndex:index withObject:@3];
            [self.openStatusArray replaceObjectAtIndex:index withObject:@1];
            UIImageView *imageView = [gesture.view viewWithTag:index+300];
            imageView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        } else {
            [self.openStatusArray replaceObjectAtIndex:index withObject:@0];
            [self.rowsNumArray replaceObjectAtIndex:index withObject:@0];
            UIImageView *imageView = [gesture.view viewWithTag:index+300];
            imageView.transform = CGAffineTransformIdentity;
        }
        
        NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:index];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark -
#pragma mark - UITableView dataSource and delegate method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rowsNumArray[section] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"AddBusinessOppCell";
    AddBusinessOppCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AddBusinessOppCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:YES];
    [self.dataSourceArray replaceObjectAtIndex:indexPath.section withObject:@"尚鲁超"];
    
    NSInteger index = indexPath.section;
    if (index > 4) {
        NSNumber *status = self.openStatusArray[index];
        
        if ([status isEqual:@0]) {
            [self.rowsNumArray replaceObjectAtIndex:index withObject:@3];
            [self.openStatusArray replaceObjectAtIndex:index withObject:@1];
            UIImageView *imageView = [self.view viewWithTag:index+300];
            imageView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        } else {
            [self.openStatusArray replaceObjectAtIndex:index withObject:@0];
            [self.rowsNumArray replaceObjectAtIndex:index withObject:@0];
            UIImageView *imageView = [self.view viewWithTag:index+300];
            imageView.transform = CGAffineTransformIdentity;
        }
        
        NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:index];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

#pragma mark - keyboardWillShow
- (void)keyboardWillShow:(NSNotification *)aNotification {
    
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardHeight = keyboardRect.size.height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 如果项目引用了IQKeyboard等键盘处理工具，此处最好注释
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
