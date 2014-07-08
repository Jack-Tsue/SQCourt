//
//  News.h
//  SQCourt
//
//  Created by Jack on 1/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
<title>市法院召开召开律师代表座谈会</title>
<author></author>
<time>2014-03-27 08:36:30</time>
<content>3月26日上午，市中院召开律师代表座谈会。中院党组书记、院长汤小夫出席会议并讲话。中院党组副书记、副院长陈茂，党组成员、政治部主任孙克杰，党组成员、纪检组长庄永之出席会议，来自市区部分律师事务所的律师代表参加了会议。
</content>
<editor>责任编辑：宿迁市中级人民法院</editor>
*/

@interface SQNews : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *editor;
- (NSString *)getTime;
@end
