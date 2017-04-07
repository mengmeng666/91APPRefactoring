//
//  FL2Model.h
//  91助手
//
//  Created by 董晓萌 on 17/1/11.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {

    //免费
    InvitationTypeMianFei = 1,

    //限时免费
    InvitationTypeXianShi = 2,

    //降价
    InvitationTypeJiangJia = 3,

    //收费
    InvitationTypeShouFei = 5,

}InvitationType;
@interface FL2Model : NSObject

@property (nonatomic,strong)NSString * tagName;
@property (nonatomic,strong)NSString * url;
@end
