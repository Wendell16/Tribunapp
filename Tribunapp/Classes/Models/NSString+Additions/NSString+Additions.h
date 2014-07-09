//
//  NSString+Additions.h
//  Tiles
//

#import <Foundation/Foundation.h>


@interface NSString (Additions)

- (void)drawCenteredInRect:(CGRect)rect withFont:(UIFont *)font;

+(NSString*)valueOrEmptyString:(NSString*)_value;

+(BOOL)compareStrings:(NSString*)_firstString secondString:(NSString*)_secondString;

@end
