//
//  ANXDocumentsConversionRoutines.h
//  ANXDocuments
//
//  Created by Max Rozdobudko on 6/2/18.
//  Copyright © 2018 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

@interface ANXDocumentsConversionRoutines : NSObject

+(FREObject) convertNSStringToFREObject:(NSString*) string;
+(NSString*) convertFREObjectToNSString: (FREObject) string;

+(BOOL) convertFREObjectToBool: (FREObject) value;
+(FREObject) convertBoolToFREObject: (BOOL) value;

@end
