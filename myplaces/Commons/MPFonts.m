//
//  SOFonts.m
//  myplaces
//
//  Created by Arpit Agarwal on 04/12/15.
//  Copyright © 2015 saanspit. All rights reserved.
//

#import "MPFonts.h"
#import <CoreText/CoreText.h>

@implementation SOFonts

+ (UIFont *)fontIcon:(NSInteger)size{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        [self loadIconFontFile];
    });
    
    return [UIFont fontWithName:@"mpfontasticfont" size:size];
}

+ (void)loadIconFontFile {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"mpfontasticfont" ofType:@"otf"];
    NSData *inData = [NSData dataWithContentsOfFile:path];
    CFErrorRef error;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)inData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    if (! CTFontManagerRegisterGraphicsFont(font, &error)) {
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        NSLog(@"Failed to load font: %@", errorDescription);
        CFRelease(errorDescription);
    }
    CFRelease(font);
    CFRelease(provider);
}

@end
