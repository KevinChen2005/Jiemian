//
//  JMLeftMenuCooperation.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/15.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMLeftMenuItem.h"

@interface JMLeftMenuCooperation : NSObject

@property (nonatomic, copy) NSString* notes;
@property (nonatomic, copy) NSString* notesUrl;
@property (nonatomic, strong) NSArray* data;

/*
 "cooperation": {
 "notes": "对战略合作感兴趣？请点击了解详情…",
 "notesUrl": "http://m.jiemian.com/article/389805_app.html",
 "data": [{
 "icon": "",
 "title": "赞那度",
 "slogan": "全球精品旅行体验",
 "type": "11",
 "url": "http://zanadu.cn/?ref=jiemian_app_strategyApp",
 "sort": "1",
 "unistr": "",
 "id": "-100",
 "show": ""
 }, {
 "icon": "",
 "title": "懒投资",
 "slogan": "聪明的理财选择",
 "type": "11",
 "url": "https://lantouzi.com/index_custom?pcode=jiemian&share=%7B%22title%22%3A%22%5Cu61d2%5Cu6295%5Cu8d44%26%5Cu754c%5Cu9762+%7C+%5Cu72ec%5Cu7acb%5Cu601d%5Cu8003%5Cu8005%5Cu7684%5Cu6295%5Cu8d44%5Cu4ff1%5Cu4e50%5Cu90e8%22%2C%22url%22%3A%22https%3A%5C%2F%5C%2Flantouzi.com%5C%2Findex_custom%3Fpcode%3Djiemian%22%2C%22imgurl%22%3A%22https%3A%5C%2F%5C%2Fs1.lantouzi.com%5C%2Fimg%5C%2F201511%5C%2Fltz%5C%2Fjiemian.jpg%22%2C%22content%22%3A%22%5Cu4f60%5Cu82e5%5Cu9752%5Cu7750%5Cuff0c%5Cu4ef7%5Cu503c%5Cu65e0%5Cu5904%5Cu4e0d%5Cu5728%22%7D",
 "sort": "2",
 "unistr": "",
 "id": "-101",
 "show": ""
 }, {
 "icon": "",
 "title": "YHOUSE",
 "slogan": "精选轻奢美食与活动预定",
 "type": "11",
 "url": "http://m.yhouse.com",
 "sort": "3",
 "unistr": "",
 "id": "-102",
 "show": ""
 }, {
 "icon": "",
 "title": "活动树",
 "slogan": "爱活动就上活动树",
 "type": "11",
 "url": "http://m.huodongshu.com/h5/enterprise/comp/100/index.html?from=jiemian",
 "sort": "4",
 "unistr": "",
 "id": "-103",
 "show": ""
 }, {
 "icon": "",
 "title": "菜鸟理财",
 "slogan": "理财之前先看菜鸟理财",
 "type": "11",
 "url": "http://m.cainiaolc.com",
 "sort": "5",
 "unistr": "",
 "id": "-104",
 "show": ""
 }]
 }*/

@end
