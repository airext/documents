//
//  Documents.h
//  ANXDocuments
//
//  Created by Max Rozdobudko on 6/2/18.
//  Copyright © 2018 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ANXDocuments : NSObject

#pragma mark Shared Instance

+ (ANXDocuments*) sharedInstance;

#pragma mark API

- (void)previewDocumentAt:(NSString*)path;

@end

@interface ANXDocuments (UIDocumentInteractionControllerDelegate) <UIDocumentInteractionControllerDelegate>

@end
