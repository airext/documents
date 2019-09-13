//
//  Documents.m
//  Documents
//
//  Created by Max Rozdobudko on 6/2/18.
//  Copyright © 2018 Max Rozdobudko. All rights reserved.
//

#import "ANXDocumentsFacade.h"
#import "FlashRuntimeExtensions.h"
#import "ANXDocumentsConversionRoutines.h"
#import "ANXDocuments.h"

@implementation ANXDocumentsFacade

@end

#pragma mark API

FREObject ANXDocumentsIsSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDocumentsIsSupported");
    FREObject result;
    FRENewObjectFromBool(YES, &result);
    return result;
}

FREObject ANXDocumentsPreview(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDocumentsPreview");

    if (argc == 0) {
        return NULL;
    }

    NSString* filepath = [ANXDocumentsConversionRoutines convertFREObjectToNSString:argv[0]];

    [ANXDocuments.sharedInstance previewDocumentAt:filepath];

    return NULL;
}

FREObject ANXDocumentsClear(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDocumentsPreview");
    return NULL;
}

#pragma mark ContextInitialize/ContextFinalizer

void ANXDocumentsContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet){
    NSLog(@"ANXDocumentsContextInitializer");

    *numFunctionsToSet = 3;

    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToSet));

    // functions

    func[0].name = (const uint8_t*) "isSupported";
    func[0].functionData = NULL;
    func[0].function = &ANXDocumentsIsSupported;

    func[1].name = (const uint8_t*) "preview";
    func[1].functionData = NULL;
    func[1].function = &ANXDocumentsPreview;


    func[2].name = (const uint8_t*) "clear";
    func[2].functionData = NULL;
    func[2].function = &ANXDocumentsClear;

    *functionsToSet = func;
}

void ANXDocumentsContextFinalizer(FREContext ctx)
{
    NSLog(@"ANXDocumentsContextFinalizer");
}

#pragma mark Initializer/Finalizer

void ANXDocumentsInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    NSLog(@"ANXDocumentsInitializer");

    *extDataToSet = NULL;

    *ctxInitializerToSet = &ANXDocumentsContextInitializer;
    *ctxFinalizerToSet = &ANXDocumentsContextFinalizer;
}

void ANXDocumentsFinalizer(void* extData)
{
    NSLog(@"ANXDocumentsFinalizer");
}
