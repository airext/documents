//
//  Documents.m
//  ANXDocuments
//
//  Created by Max Rozdobudko on 6/2/18.
//  Copyright © 2018 Max Rozdobudko. All rights reserved.
//

#import "ANXDocuments.h"

@implementation ANXDocuments {
    NSTimer* _statusBarTimer;
}

#pragma mark Shared Instance

static ANXDocuments* _sharedInstance = nil;
+ (ANXDocuments*)sharedInstance {
    if (_sharedInstance == nil) {
        _sharedInstance = [[super allocWithZone:NULL] init];
    }
    return _sharedInstance;
}

#pragma mark API

- (void)previewDocumentAt:(NSString*)filePath {
    NSString* filename = [filePath lastPathComponent];
    NSString* directory = [filePath stringByDeletingLastPathComponent];
    NSString* resourceName = [filename stringByDeletingPathExtension];
    NSString* resourceType = [filename pathExtension];

    NSLog(@"ANXDocuments: directory:%@, filename:%@, resourceName:%@, resourceType:%@", directory, filename, resourceName, resourceType);

    NSString* resourcePath = [NSBundle.mainBundle pathForResource:resourceName ofType:resourceType inDirectory:directory];
    if (resourcePath == nil) {
        return;
    }

    NSLog(@"ANXDocuments: resourcePath:%@", resourcePath);

    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if (rootViewController == nil) {
        return;
    }

    NSURL* url = [NSURL fileURLWithPath:resourcePath];
    if (url == nil) {
        return;
    }

    NSLog(@"ANXDocuments: url:%@", url);

    UIDocumentInteractionController* interactionController = [UIDocumentInteractionController interactionControllerWithURL:url];
    interactionController.delegate = self;
    [interactionController presentPreviewAnimated:YES];
}

@end

@implementation ANXDocuments (UIDocumentInteractionControllerDelegate)

- (void)documentInteractionControllerWillBeginPreview:(UIDocumentInteractionController *)controller {
    NSString* path = [NSBundle.mainBundle pathForResource:@"Info" ofType:@"plist"];
    if (!path) {
        return;
    }

    NSLog(@"ANXDocuments: path:%@", path);

    NSDictionary* info = [NSDictionary dictionaryWithContentsOfFile:path];
    if (!info) {
        return;
    }

    NSLog(@"ANXDocuments: info:%@", info);

    if ([[info objectForKey:@"UIViewControllerBasedStatusBarAppearance"] boolValue]) {
        return;
    }

    if (!UIApplication.sharedApplication.statusBarHidden) {
        return;
    }

    NSLog(@"ANXDocuments: install _statusBarTimer");

    _statusBarTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(handleStatusBarTimer:) userInfo:nil repeats:YES];
}

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller {
    if (_statusBarTimer) {
        NSLog(@"ANXDocuments: remove _statusBarTimer");
        [_statusBarTimer invalidate];
        _statusBarTimer = nil;
        UIApplication.sharedApplication.statusBarHidden = YES;
    }
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return [[[UIApplication sharedApplication] keyWindow] rootViewController];
}

- (void)handleStatusBarTimer:(NSTimer*)timer {
    UIApplication.sharedApplication.statusBarHidden = YES;
}

@end
