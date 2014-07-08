//
//  CourtIntroViewController.m
//  SQCourt
//
//  Created by Jack on 8/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "CourtIntroViewController.h"
#import "Macro.h"

@interface CourtIntroViewController ()

@end

@implementation CourtIntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT+60)];

    } else {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+60)];

    }
    _contentTextView = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 280, 2000)];
    _contentTextView.text = @"    宿迁市位于江苏省北部，下辖沭阳县、泗阳县、泗洪县3个县和宿豫区、宿城区、宿迁经济技术开发区、湖滨新区、苏州宿迁工业园区、宿迁市软件园和洋河新区等行政区，人口555万。宿迁是著名的“杨树之乡”、“水产之乡”、“名酒之乡”、“花卉之乡”和“蚕茧之乡”，有洪泽湖、骆马湖、三台山等自然山水，是西楚霸王项羽的故乡，有国家级文物保护单位乾隆行宫、项王故里等大量文化遗址。\n\n    宿迁市中级人民法院成立于1996年12月，下辖沭阳县、泗阳县、泗洪县、宿豫区、宿城区5个基层人民法院，中院内设立案庭、民一庭、民二庭、民三庭、刑一庭、刑二庭、行政庭、生态保护庭、审监庭、执行局（内设执行实施处、执行裁决处、综合协调处）、司法鉴定处、研究室、审判管理办公室、政治部（内设法官人事处、宣传教育处、综合处）、机关党委、办公室、监察室、司法行政装备处、法警支队等部门。中院在编干警152名，其中审判人员86名。全院干警本科以上学历136名，法律专业硕士40名，法学博士1名。\n\n    在省法院的监督指导和大力支持、市委的正确领导下，全市法院深入贯彻落实科学发展观，认真践行“司法为民、公正司法”工作主题，全面加强自身建设，较好地履行了宪法和法律赋予的审判职责。全市法院立足实际，改革创新，审判执行工作、队伍建设、司法改革、基层基础建设等跃上了新的平台，受到市委、市人大、上级法院和社会各界的充分好评。市中院先后被评为全省人民满意法院、全市平安建设和法制建设工作先进集体、全省法院系统先进集体，并被江苏省高级人民法院荣记集体三等功四次、集体二等功二次。加强司法调研工作，宿迁中院因连续三年有论文在全国学术讨论会中获一等奖，被最高院授予全国法院学术讨论组织工作特别奖。创新审判管理，在全省率先探索建立以质效指标合理区间为基础的审判工作评价机制，在充分调研的基础上，确定部分主要指标的合理区间，对主要质效指标按优、良、中、差四个等级进行评价，改变单纯指标排名的做法，相关做法被省法院采用并推广。";
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_contentTextView];
        
    CGRect frame = [_scrollView frame];
    //文本赋值
    //设置label的最大行数
    _contentTextView.numberOfLines = 1000;
    CGSize size = CGSizeMake(280, 10000);
    CGSize labelSize = [_contentTextView.text sizeWithFont:_contentTextView.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    _contentTextView.frame = CGRectMake(_contentTextView.frame.origin.x, _contentTextView.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+400;
    
    [_scrollView setContentSize:frame.size];
    
    self.localThumbnailView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-280)/2, 20, 280, 184)];
    
    
    UIImage *image = [UIImage imageNamed:@"intro"];
	self.localThumbnailView.image = image;
	[_scrollView addSubview:self.localThumbnailView];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
