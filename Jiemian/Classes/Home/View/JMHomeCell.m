//
//  JMHomeCell.m
//  Jiemian
//
//  Created by Kevin Chen on 16/5/12.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMHomeCell.h"
#import "JMNews.h"

@implementation JMHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.numberOfLines = 0;
    }
    
    return self;
}

- (void)setNews:(JMNews *)news
{
    _news = news;
    
    self.textLabel.text = news.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
