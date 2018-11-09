//
//  ViewController.m
//  MyInsight_Blog
//
//  Created by SongMenglong on 2018/11/8.
//  Copyright © 2018年 SongMenglong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.name.text = @"滚滚长江";
    
    
}


@end
