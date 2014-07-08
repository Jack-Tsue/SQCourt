//
//  SearchResultViewController.m
//  SQCourt
//
//  Created by Jack on 25/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "SearchResultViewController.h"
#import "HTMLParser.h"
#import "CourtArrangeCell.h"
#import "BasicInfoCell.h"
#import "CourtChangeCell.h"
#import "WeiboViewController.h"
#import "Macro.h"
#import "RatingViewController.h"
#import <libxml/HTMLparser.h>

@interface SearchResultViewController (){
    int refreshTime;
}

@end

@implementation SearchResultViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    refreshTime=0;
    self.tableView.delegate = self;
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	// Set determinate mode
    errHud = [[MBProgressHUD alloc] initWithView:self.view];
    errHud.delegate = self;
    
	HUD.mode = MBProgressHUDModeDeterminate;
	
	HUD.delegate = self;
	HUD.labelText = @"载入中...";
	
	[HUD showWhileExecuting:@selector(searchCase) onTarget:self withObject:nil animated:YES];
}
- (void)searchCase {
    resultSet = [[NSMutableArray alloc] init];
    didFinishParse = NO;
    [self performSelector:@selector(parsingDidTimeout) withObject:nil afterDelay:5];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", @"http://221.226.175.76:8018/ajcx/webapp/ajxx_info.jsp?j_password=", caseKey];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithContentsOfURL:url error:&error];
    
    if (error) {
        // NSLog(@"Error: %@", error);
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"查询失败"
                              message:@"连接时发生问题，请稍后再试！"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    HTMLNode *bodyNode = [parser body];
    
    NSArray *tdNodes = [bodyNode findChildTags:@"td"];
    
    for (HTMLNode *spanNode in tdNodes) {
        NSString *content = [spanNode contents];
        content =[content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        content =[content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        content =[content stringByReplacingOccurrencesOfString:@" " withString:@""];
        content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (content == nil) {
            content = @"";
        }
        [resultSet addObject:content];
    }
    
//    int i = 0;
//    for (NSString *tmp in resultSet) {
//        i++;
//        // NSLog(@"%d: %@", i, tmp);
//    }
    
    // 验证立案案号
    NSString *caseIDAuth;
    caseIDAuth = [resultSet objectAtIndex:3];
    if ([caseID isEqualToString: caseIDAuth]) {
        searchResult = [[SQSearchResult alloc] init];
        courtArranges = [[NSMutableArray alloc] init];
        courtChanges = [[NSMutableArray alloc] init];
//        // NSLog(@"search case success");
        for (int i=0; i<[resultSet count]; i++) {
            NSString *tmp;
            tmp = [resultSet objectAtIndex:i];
            // NSLog(@"%@", tmp);
            if ([tmp isEqualToString:@"案件名称："]) {
                searchResult.caseName = [resultSet objectAtIndex:i+1];
            }
            if ([tmp isEqualToString:@"立案案号："]) {
                searchResult.caseNo = [resultSet objectAtIndex:i+1];
            }
            if ([tmp isEqualToString:@"办案法院："]) {
                searchResult.court = [resultSet objectAtIndex:i+1];
            }
            if ([tmp isEqualToString:@"案件承办庭："]) {
                searchResult.contractorSector = [resultSet objectAtIndex:i+1];
            }
            if ([tmp isEqualToString:@"案件状态："]) {
                searchResult.caseStatus = [resultSet objectAtIndex:i+1];
            }
            if ([tmp isEqualToString:@"立案日期："]) {
                searchResult.filingDate = [resultSet objectAtIndex:i+1];
            }
            if ([tmp isEqualToString:@"结案日期："]) {
                searchResult.caseClosedDate = [resultSet objectAtIndex:i+1];
            }
            if ([tmp isEqualToString:@"法定审限："]) {
                searchResult.jurisdictionLimit = [resultSet objectAtIndex:i+1];
            }
            if ([tmp isEqualToString:@"案由："]) {
                searchResult.caseReason = [resultSet objectAtIndex:i+1];
            }
            if ([tmp isEqualToString:@"案由："]) {
                searchResult.caseReason = [resultSet objectAtIndex:i+1];
            }
            if ([tmp isEqualToString:@"审限变更情况："]) {
                int j = i+2;
                NSString *indexStr;
                indexStr = [resultSet objectAtIndex:j];
                while ([indexStr isEqualToString:@"开庭安排："] == NO) {
                    [courtChanges addObject:indexStr];
                    ++j;
                    indexStr = [resultSet objectAtIndex:j];
                }
            }
            if ([tmp isEqualToString:@"开庭安排："]) {
                int j = i+2;
                NSString *indexStr;
                indexStr = [resultSet objectAtIndex:j];
                while ([indexStr isEqualToString:@"合议庭成员组成："] == NO) {
                    [courtArranges addObject:indexStr];
                    ++j;
                    indexStr = [resultSet objectAtIndex:j];
                }
            }
            if ([tmp isEqualToString:@"合议庭成员组成："]) {
                searchResult.fullCourtMember = [resultSet objectAtIndex:i+1];
            }
        }
    }
    else {
        [HUD removeFromSuperview];
        [self.view addSubview:errHud];
        // Configure for text only and offset down
        errHud.mode = MBProgressHUDModeText;
        errHud.labelText = @"立案案号错误！";
        errHud.margin = 10.f;
        errHud.yOffset = 150.f;
        errHud.removeFromSuperViewOnHide = YES;
        [errHud showAnimated:YES whileExecutingBlock:^{
            sleep(3);
        } completionBlock:^{
            [errHud removeFromSuperview];
            errHud = nil;
        }];
    }
//    int index = 0;
//    for (NSString *tmp in courtChanges) {
//        index++;
//        // NSLog(@"%d: %@", index, tmp);
//    }
    didFinishParse = YES;
    refreshTime++;
    [self.tableView reloadData];
}

- (void)parsingDidTimeout {
    if(didFinishParse == NO) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"查询失败"
                              message:@"连接时发生问题，请稍后再试！"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setKey:(NSString *)key withCaseYear:(NSString *)caseYear withCaseNo:(NSString *)caseNo;
{
    caseID = [NSString stringWithFormat:@"%@%@%@%@",@"(", caseYear, @")", caseNo];
    caseKey = key;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    int sum = 0;
//    if (searchResult != nil) {
//        sum += 1;
//        if (courtArranges != nil) {
//            sum += 1;
//        }
//        if (courtChanges != nil) {
//            sum += 1;
//        }
//        return sum+=1;
//    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (refreshTime==0) {
        return 0;
    }else if (section == 0) {
        return 10;
    }
    if (section == 1) {
        return [courtArranges count]/3;
    }
    if (section == 2) {
        return [courtChanges count]/5;
    }
    if (section == 3) {
        return 1;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
            
        case 0:
            return @"基本信息";
        case 1:
            return @"开庭安排";
        case 2:
            return @"审限变更情况";
        case 3:
            return @"裁判文书";
        default:
            return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BasicInfoCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height*1.1;
        
    } if (indexPath.section == 1) {
        CourtArrangeCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height*1.1;
        
    } else if(indexPath.section == 2){
        CourtChangeCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height*1.1;
    } else {
        return 30;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"CourtCell";
        
        BasicInfoCell *cell = [[BasicInfoCell alloc] initWithReuseIdentifier:CellIdentifier];
        
        switch (indexPath.row) {
            case 0:
                cell.title.text = @"案件名称";
                [cell setDetailText:[searchResult caseName]];
                break;
            case 1:
                cell.title.text = @"立案案号";
                [cell setDetailText:[searchResult caseNo]];
                break;
            case 2:
                cell.title.text = @"办案法院";
                [cell setDetailText:[searchResult court]];
                break;
            case 3:
                cell.title.text = @"承办庭";
                [cell setDetailText:[searchResult contractorSector]];
                break;
            case 4:
                cell.title.text = @"案件状态";
                [cell setDetailText:[searchResult caseStatus]];
                break;
            case 5:
                cell.title.text = @"立案日期";
                [cell setDetailText:[searchResult filingDate]];
                break;
            case 6:
                cell.title.text = @"结案日期";
                [cell setDetailText:[searchResult caseClosedDate]];
                if ([[searchResult caseClosedDate] isEqualToString:@""]) {
                    self.navigationItem.RightBarButtonItem = nil;
                }
                break;
            case 7:
                cell.title.text = @"法定审限";
                [cell setDetailText:[searchResult jurisdictionLimit]];
                break;
            case 8:
                cell.title.text = @"案由";
                [cell setDetailText:[searchResult caseReason]];
                break;
            case 9:
                cell.title.text = @"合议庭成员";
                [cell setDetailText:[searchResult fullCourtMember]];
                break;
            default:
                break;
        }
        if ([cell.detail.text isEqualToString:@""]) {
            [cell setDetailText:@"无"];
        }
        return cell;
    } else if (indexPath.section == 1) {
        static NSString *CellIdentifier = @"CourtArrangeCell";
        CourtArrangeCell *cell = [[CourtArrangeCell alloc] initWithReuseIdentifier:CellIdentifier];
        // NSLog(@"courtArranges~~~~ %d", indexPath.row);
        if (indexPath.row*3+2<=[courtArranges count]) {
            cell.arrangeId.text = [courtArranges objectAtIndex:(indexPath.row*3)];
            cell.courtDate.text = [courtArranges objectAtIndex:(indexPath.row*3+1)];
            cell.courtLocation.text = [courtArranges objectAtIndex:(indexPath.row*3+2)];
        }
        return cell;
    } else if (indexPath.section == 2){
        // NSLog(@"courtArranges~~~~ %d", indexPath.row);
        static NSString *CellIdentifier = @"CourtChangeCell";
        CourtChangeCell *cell = [[CourtChangeCell alloc] initWithReuseIdentifier:CellIdentifier];
        if (indexPath.row*5+4<=[courtChanges count]) {
            cell.changeDetail.text = [courtChanges objectAtIndex:(indexPath.row*5)];
            [cell setReasonText:[courtChanges objectAtIndex:(indexPath.row*5+1)]];
            cell.startDate.text = [courtChanges objectAtIndex:(indexPath.row*5+2)];
            cell.endDate.text = [courtChanges objectAtIndex:(indexPath.row*5+3)];
            cell.duration.text = [courtChanges objectAtIndex:(indexPath.row*5+4)];
        }
        
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        // Configure the cell...
        cell.textLabel.textColor =  TINTBLUE;
        cell.textLabel.text = @"点击查看裁判文书";
        return cell;
    }
}
#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            UIStoryboard *storyboard = self.navigationController.storyboard;
            WeiboViewController *docView = [storyboard instantiateViewControllerWithIdentifier:@"judgeDoc"];
            docView.urlPath = [NSString stringWithFormat:@"%@%@", @"http://221.226.175.76:8018/ajcx/webapp/ajxx_info.jsp?j_password=", caseKey];
            [self.navigationController pushViewController:docView animated:YES];
        }
    }
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"rating"]) {
        RatingViewController *destViewController = [segue destinationViewController];
        destViewController.caseID = caseID;
        destViewController.caseKey = caseKey;
        //         destViewController.contentTextView = [[UITextView alloc] init];
        //         destViewController.contentTextView.text = p.content;
    }
}

@end
