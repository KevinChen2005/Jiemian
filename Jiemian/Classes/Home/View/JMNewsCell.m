//
//  JMNewsCell.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/12.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMNewsCell.h"
#import "JMNewsRst.h"
#import "JMAuthor.h"
#import "UIImageView+WebCache.h"

#define kMargin 10
#define kMarginH (kMargin-2)
#define kFontHeight 15

#define kAuthorFont [UIFont systemFontOfSize:10]
#define kCommentFont kAuthorFont
#define kHitFont kAuthorFont

#define kAuthorColor kColor(136, 136, 136)
#define kCommentColor kAuthorColor
#define kHitColor kAuthorColor

@interface JMNewsCell()

@property (nonatomic, strong) UIImageView* icon;
@property (nonatomic, strong) UILabel* title;
@property (nonatomic, strong) UILabel* author;
@property (nonatomic, strong) UILabel* time;
@property (nonatomic, strong) UILabel* commentCount;
@property (nonatomic, strong) UILabel* hitCount;

@end

@implementation JMNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kGlobalBG;
        
        // 1.图标
        UIImageView* icon = [[UIImageView alloc] init];
        icon.clipsToBounds = YES;
        icon.layer.cornerRadius = 10;
        [self addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(kMargin);
            make.bottom.equalTo(self).offset(-kMargin);
            make.width.equalTo(icon.mas_height).multipliedBy(1.3); // 宽高比4：3
        }];
        self.icon = icon;
        
        // 2.作者
        UILabel* author= [UILabel new];
        author.font = kAuthorFont;
        author.textColor = kAuthorColor;
        [self addSubview:author];
        [author mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-kMarginH);
            make.left.equalTo(icon.mas_right).offset(kMargin);
            make.width.equalTo(@30);
            make.height.equalTo(@kFontHeight);
        }];
        self.author = author;
        
        // 3.时间
        UILabel* time= [UILabel new];
        [self addSubview:time];
        time.font = kAuthorFont;
        time.textColor = kAuthorColor;
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-kMarginH);
            make.left.equalTo(author.mas_right).offset(kMargin);
            make.width.equalTo(@30);
            make.height.equalTo(@kFontHeight);
        }];
        self.time = time;
        
        // 4.点击数
        UILabel* hitCount= [UILabel new];
        hitCount.font = kAuthorFont;
        hitCount.textColor = kAuthorColor;
        [self addSubview:hitCount];
        [hitCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-kMarginH);
            make.right.equalTo(self).offset(-kMargin);
            make.width.equalTo(@30);
            make.height.equalTo(@kFontHeight);
        }];
        self.hitCount = hitCount;
        
        UIImageView* hitIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hit.png"]];
        [self addSubview:hitIcon];
        [hitIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-kMarginH);
            make.right.equalTo(hitCount.mas_left).offset(-2);
            make.width.equalTo(@(kFontHeight+2));
            make.height.equalTo(@(kFontHeight-2));
        }];
        
        // 5.评论数
        UILabel* commentCount= [UILabel new];
        commentCount.font = kAuthorFont;
        commentCount.textColor = kAuthorColor;
        [self addSubview:commentCount];
        [commentCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-kMarginH);
            make.right.equalTo(hitIcon.mas_left).offset(-kMargin);
            make.width.equalTo(@30);
            make.height.equalTo(@kFontHeight);
        }];
        self.commentCount = commentCount;
        
        UIImageView* commentIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment.png"]];
        [self addSubview:commentIcon];
        [commentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-kMarginH);
            make.right.equalTo(commentCount.mas_left).offset(-2);
            make.width.equalTo(@(kFontHeight-2));
            make.height.equalTo(@(kFontHeight-2));
        }];
        
        // 6.标题
        UILabel* title= [UILabel new];
        title.numberOfLines = 0;
        [self addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(2);
            make.left.equalTo(icon.mas_right).offset(kMargin);
            make.bottom.equalTo(author.mas_top).offset(-5);
            make.right.equalTo(self).offset(-kMargin);
        }];
        self.title = title;
    }
    
    return self;
}

- (void)setNews:(JMNewsRst *)news
{
    _news = news;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.news.z_image] placeholderImage:[UIImage imageNamed:@"place_holder.png"]];
    
    self.title.text = self.news.title;
    
    
    JMAuthor* author = [JMAuthor mj_objectWithKeyValues:[self.news.author_list firstObject]];
    self.author.text = author.name;
    CGSize sizeAuthor = [_author sizeThatFits:CGSizeMake(1000, 1000)];
    [_author mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([NSNumber numberWithFloat:MIN(sizeAuthor.width, 60)]);
    }];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:(self.news.publishtime)];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSString* strDate = [formatter stringFromDate:date];
    self.time.text = strDate;
    
    CGSize sizetime = [_time sizeThatFits:CGSizeMake(1000, 1000)];
    [_time mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([NSNumber numberWithFloat:sizetime.width]);
    }];
    
    self.commentCount.text = [NSString stringWithFormat:@"%d", self.news.comment];
    CGSize sizeComment = [_commentCount sizeThatFits:CGSizeMake(1000, 1000)];
    [_commentCount mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([NSNumber numberWithFloat:sizeComment.width]);
    }];
    
    self.hitCount.text = self.news.hit;
    CGSize sizeHit = [_hitCount sizeThatFits:CGSizeMake(1000, 1000)];
    [_hitCount mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([NSNumber numberWithFloat:sizeHit.width]);
    }];
}

@end
