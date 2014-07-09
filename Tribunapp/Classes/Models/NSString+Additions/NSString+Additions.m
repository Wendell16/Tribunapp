//
//  NSString+Additions.m
//  Tiles
//

#import "NSString+Additions.h"

static const int CORRECTOR = 2;

@implementation NSString (Additions)


- (void)drawCenteredInRect:(CGRect)rect withFont:(UIFont *)font 
{
    CGSize size = [self sizeWithFont:font];
    
    CGRect textBounds = CGRectMake(rect.origin.x + (rect.size.width - size.width) / 2,
                                   rect.origin.y + (rect.size.height - size.height+CORRECTOR),
                                   size.width, size.height);
    [self drawInRect:textBounds withFont:font];    
}

+(NSString*)valueOrEmptyString:(NSString*)_value
{
	if(_value == nil)
		return @"";
	else
		return _value;
}

+(BOOL)compareStrings:(NSString*)_firstString secondString:(NSString*)_secondString
{
	BOOL result = FALSE;
	if(_firstString && _secondString)
	{
		result = [_firstString isEqualToString:_secondString];
	}
	else if(!_firstString && !_secondString)
	{
		result = TRUE;
	}
	else if( (!_firstString && [_secondString isEqualToString:@""]) ||
			 (!_secondString && [ _firstString isEqualToString:@""]) )
	{
		result = TRUE;
	}
	
	return result;
}

@end
