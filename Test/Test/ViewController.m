//
//  ViewController.m
//  Test
//
//  Created by 田光鑫 on 15/4/14.
//  Copyright (c) 2015年 Wohai. All rights reserved.
//

#import "ViewController.h"
#import <MQTTKit.h>

@interface ViewController ()
{
    NSString *host;
    NSString *topic;
}
@property (nonatomic,strong)MQTTClient *client;
- (IBAction)btnPressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    host = @"test.mosquitto.org";
    host = @"iot.eclipse.org";
    self.client = [[MQTTClient alloc] initWithClientId:@"tian" cleanSession:YES];
    
    topic = @"Tian/Yang";
    
    // connect the MQTT client
    [self.client connectToHost:host
             completionHandler:^(MQTTConnectionReturnCode code) {
                 if (code == ConnectionAccepted) {
                     // when the client is connected, subscribe to the topic to receive message.
                     [self.client subscribe:topic
                      withCompletionHandler:nil];
                 }
             }];

//    [self.client disconnectWithCompletionHandler:^(NSUInteger code) {
//        // The client is disconnected when this completion handler is called
//        NSLog(@"MQTT client is disconnected");
//    }];
    
        [self.client setMessageHandler:^(MQTTMessage *message) {
            NSString *text = message.payloadString;
    
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"接收到消息" message:text delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                [alert show];
            });
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPressed:(id)sender {
    [self.client connectToHost:host completionHandler:^(MQTTConnectionReturnCode code) {
        if(code == ConnectionAccepted)
        {
            static int a = 0;
            [self.client publishString:[NSString stringWithFormat:@"-------%d－－－－:hello from button test",a] toTopic:topic withQos:AtMostOnce retain:YES completionHandler:^(int mid) {
                
                a++;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息发送成功" message:@"waring" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                    [alert show];
                });
            }];
        }
    }];
}
@end
