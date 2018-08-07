//
//  JMChanelCell.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/10.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMChanelCell.h"
#import "JMChannel.h"

@interface JMChanelCell()

@property (weak, nonatomic) IBOutlet UILabel *nameCh;
@property (weak, nonatomic) IBOutlet UILabel *nameEn;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation JMChanelCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setChannel:(JMChannel *)channel
{
    _channel = channel;
    
    self.nameCh.text = _channel.name;
    self.nameEn.text = _channel.app_en_name;
    
    self.addButton.enabled = YES;
    
    if (_channel.isEdit == YES) {
        self.addButton.hidden = NO;
    } else {
        self.addButton.hidden = YES;
    }
    
}

- (IBAction)clickAddButton:(id)sender
{
    UIButton* btn = sender;
    btn.enabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
//    NSLog(@"cell selected!");
}

@end
