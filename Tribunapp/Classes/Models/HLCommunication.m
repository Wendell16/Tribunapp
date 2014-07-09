//
//  FUCommunication.m
//  FitnessUnion
//
//  Created by HanLong on 6/6/13.
//  Copyright (c) 2013 HanLong. All rights reserved.
//
// Web Services ;
#import "FUCommunication.h"
#import "FUUser.h"
#import "FUWorkout.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "FUFeed.h"
#import "Global.h"

#define WEBAPI_URL                  [NSString stringWithFormat:@"%@mobileservice.php", WEB_ABS_URL]

// Sign ;
#define WEBAPI_SIGNIN               @"signin"
#define WEBAPI_SIGNUP               @"signup"
#define WEBAPI_FACEBOOK             @"signinfacebook"
#define WEBAPI_TWITTER              @"signintwitter"

// Follow ;
#define WEBAPI_FOLLOWERADD          @"followeradd"
#define WEBAPI_FOLLOWERREMOVE       @"followerremove"
#define WEBAPI_FOLLOWERS            @"followers"
#define WEBAPI_FOLLOWINGS           @"followings"
#define WEBAPI_USERRECOMMEND        @"userrecommend"
#define WEBAPI_SEARCH            @"search"

// Profile ;
#define WEBAPI_PROFILESET           @"profileset"
#define WEBAPI_PROFILEGET           @"profileget"

// Feed ;
#define WEBAPI_FEEDPOST             @"feedpost"
#define WEBAPI_FEEDCANCEL           @"feedcancel"
#define WEBAPI_FEEDS                @"feeds"
#define WEBAPI_FEEDFRIENDS          @"feedfriends"
#define WEBAPI_FEEDLIKED            @"feedliked"
#define WEBAPI_FEEDRECOMMEND        @"feedrecommend"
#define WEBAPI_FEEDSEARCH        @"feedsearch"

// Like
#define WEBAPI_LIKE                 @"like"
#define WEBAPI_LIKECANCEL           @"likecancel"
#define WEBAPI_LIKES                @"likes"

// Comment ;
#define WEBAPI_COMMENTTEXT          @"commentworkout"
#define WEBAPI_COMMENTCANCEL        @"commentcancel"
#define WEBAPI_COMMENTS             @"comments"

// User search
#define WEBAPI_USERSEARCH           @"searchuser"

// Relation
#define WEBAPI_RELATIONGET          @"getrelation"
#define WEBAPI_RELATIONADD          @"addrelation"
#define WEBAPI_RELATIONDEL          @"delrelation"

@interface FUCommunication ()

// Web Service ;
- ( void ) sendToService : ( NSDictionary* ) _params
                 success : ( void (^)( id _responseObject ) ) _success
                 failure : ( void (^)( NSError* _error ) ) _failure ;

- ( void ) sendToService : ( NSDictionary* ) _params
                    data : ( NSData* ) _data
                    type : ( NSString* ) _type
                 success : ( void (^)( id _responseObject ) ) _success
                 failure : ( void (^)( NSError* _error ) ) _failure ;
- ( void ) sendToService : ( NSDictionary* ) _params
                   photo : ( NSData* ) _photo
              background : ( NSData* ) _background
                 success : ( void (^)( id _responseObject ) ) _success
                 failure : ( void (^)( NSError* _error ) ) _failure;
@end;

@implementation FUCommunication

#pragma mark - Shared Functions
+ ( FUCommunication* ) sharedManager
{
    __strong static FUCommunication* sharedObject = nil ;
	static dispatch_once_t onceToken ;
    
	dispatch_once( &onceToken, ^{
        sharedObject = [ [ FUCommunication alloc ] init ] ;
	} ) ;
    
    return sharedObject ;
}

#pragma mark - FUCommunication
- ( id ) init
{
    self = [ super init ] ;
    
    if( self )
    {
        
    }
    
    return self ;
}

- ( void ) dealloc
{
    [ super dealloc ] ;
}

#pragma mark - Web Service
- ( void ) sendToService : ( NSDictionary* ) _params
                 success : ( void (^)( id _responseObject ) ) _success
                 failure : ( void (^)( NSError* _error ) ) _failure
{
    NSURL*                  url         = [ NSURL URLWithString : WEBAPI_URL ] ;
    AFHTTPClient*           client      = [ [ AFHTTPClient alloc ] initWithBaseURL : url ] ;
    NSMutableURLRequest*    request     = [ client requestWithMethod : @"POST" path : nil parameters : _params ] ;
    AFHTTPRequestOperation* operation   = [ [ [ AFHTTPRequestOperation alloc ] initWithRequest : request ] autorelease ] ;
    
    [ client registerHTTPOperationClass : [ AFHTTPRequestOperation class ] ] ;
    [ operation setCompletionBlockWithSuccess : ^( AFHTTPRequestOperation* _operation, id _responseObject ) {
        NSString* string = [ [ [ NSString alloc ] initWithData : _responseObject encoding : NSUTF8StringEncoding ] autorelease ] ;
        NSLog( @"response=%@", string ) ;
        
        // Response Object ;
        id responseObject   = [ NSJSONSerialization JSONObjectWithData : _responseObject
                                                               options : kNilOptions
                                                                 error : nil ] ;
        
        // Success ;
        _success( responseObject ) ;
    } failure : ^( AFHTTPRequestOperation* _operation, NSError* _error )
     {
         NSLog( @"%@", _error.description ) ;
         
         // Failture ;
         _failure( _error ) ;
     } ] ;
    [ operation start ] ;
    [ client release ] ;
}

- ( void ) sendToService : ( NSDictionary* ) _params
                    data : ( NSData* ) _data
                    type : ( NSString* ) _type
                 success : ( void (^)( id _responseObject ) ) _success
                 failure : ( void (^)( NSError* _error ) ) _failure
{
    NSURL*                  url         = [ NSURL URLWithString : WEBAPI_URL ] ;
    AFHTTPClient*           client      = [ [ AFHTTPClient alloc ] initWithBaseURL : url ] ;
    NSMutableURLRequest*    request     = [ client multipartFormRequestWithMethod : @"POST"
                                                                             path : nil
                                                                       parameters : _params
                                                        constructingBodyWithBlock : ^( id <AFMultipartFormData > _formData ) {
                                                            if( _data )
                                                            {
                                                                [ _formData appendPartWithFileData : _data name : @"data" fileName : @"data" mimeType : _type ] ;
                                                            }
                                                        } ] ;
    AFHTTPRequestOperation* operation   = [ [ [ AFHTTPRequestOperation alloc ] initWithRequest : request ] autorelease ] ;
    
    [ client registerHTTPOperationClass : [ AFHTTPRequestOperation class ] ] ;
    [ operation setCompletionBlockWithSuccess : ^( AFHTTPRequestOperation* _operation, id _responseObject ) {
        // Response Object ;
        id responseObject   = [ NSJSONSerialization JSONObjectWithData : _responseObject
                                                               options : kNilOptions
                                                                 error : nil ] ;
        
        // Success ;
        _success( responseObject ) ;
    } failure : ^( AFHTTPRequestOperation* _operation, NSError* _error )
     {
         // Failture ;
         _failure( _error ) ;
     } ] ;
    [ operation start ] ;
    [ client release ] ;
}

- ( void ) sendToService : ( NSDictionary* ) _params
                   photo : ( NSData* ) _photo
              background : ( NSData* ) _background
                 success : ( void (^)( id _responseObject ) ) _success
                 failure : ( void (^)( NSError* _error ) ) _failure
{
    NSURL*                  url         = [ NSURL URLWithString : WEBAPI_URL ] ;
    AFHTTPClient*           client      = [ [ AFHTTPClient alloc ] initWithBaseURL : url ] ;
    NSMutableURLRequest*    request     = [ client multipartFormRequestWithMethod : @"POST"
                                                                             path : nil
                                                                       parameters : _params
                                                        constructingBodyWithBlock : ^( id <AFMultipartFormData > _formData ) {
                                                            if( _photo )
                                                            {
                                                                [ _formData appendPartWithFileData : _photo name : @"photo" fileName : @"photo.jpg" mimeType : @"image/jpeg" ] ;
                                                            }
                                                            if( _background )
                                                            {
                                                                [ _formData appendPartWithFileData : _background name : @"background" fileName : @"background.jpg" mimeType : @"image/jpeg" ] ;
                                                            }
                                                        } ] ;
    AFHTTPRequestOperation* operation   = [ [ [ AFHTTPRequestOperation alloc ] initWithRequest : request ] autorelease ] ;
    
    [ client registerHTTPOperationClass : [ AFHTTPRequestOperation class ] ] ;
    [ operation setCompletionBlockWithSuccess : ^( AFHTTPRequestOperation* _operation, id _responseObject ) {
        // Response Object ;
        NSString* string = [ [ [ NSString alloc ] initWithData : _responseObject encoding : NSUTF8StringEncoding ] autorelease ] ;
        NSLog( @"%@", string ) ;
        
        id responseObject   = [ NSJSONSerialization JSONObjectWithData : _responseObject
                                                               options : kNilOptions
                                                                 error : nil ] ;
        
        // Success ;
        _success( responseObject ) ;
    } failure : ^( AFHTTPRequestOperation* _operation, NSError* _error )
     {
         // Failture ;
         _failure( _error ) ;
     } ] ;
    [ operation start ] ;
    [ client release ] ;
}


#pragma mark - Sign
- ( void ) SignIn : ( NSString* ) _email
         password : ( NSString* ) _password
        successed : ( void (^)( id _responseObject ) ) _success
          failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_SIGNIN forKey : @"action" ] ;
    [ params setObject : _email forKey : @"email" ] ;
    [ params setObject : _password forKey : @"password" ] ;
    //  [ params setObject : [ [ FUUser me ] userDeviceToken ] forKey : @"token" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) SignUp : ( NSString* ) _email
         password : ( NSString* ) _password
        successed : ( void (^)( id _responseObject ) ) _success
          failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_SIGNUP forKey : @"action" ] ;
    [ params setObject : _email forKey : @"email" ] ;
    [ params setObject : _password forKey : @"password" ] ;
    //  [ params setObject : [ [ FUUser me ] userDeviceToken ] forKey : @"token" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) FacebookLogin : ( NSString* ) _facebookId
                fbtoken : ( NSString* ) _facebooktoken
                firstname : (NSString* )_firstname
                lastname : (NSString* )_lastname
                avatar : (NSString* )_avatar
                successed : ( void (^)( id _responseObject ) ) _success
                failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FACEBOOK forKey : @"action" ] ;
    [ params setObject : _facebookId forKey : @"fbId" ] ;
    [ params setObject : _facebooktoken forKey : @"fbToken" ] ;
    [ params setObject : _firstname forKey : @"first" ] ;
    [ params setObject : _lastname forKey : @"last" ] ;
    [ params setObject : _avatar forKey : @"avatar" ] ;
    //  [ params setObject : [ [ FUUser me ] userDeviceToken ] forKey : @"token" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) TwitterLogin : ( NSString* ) _twitterId
                 twtoken : ( NSString* ) _twittertoken
               firstname : (NSString* )_firstname
                lastname : (NSString* )_lastname
                  avatar : (NSString* )_avatar
               successed : ( void (^)( id _responseObject ) ) _success
                 failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FACEBOOK forKey : @"action" ] ;
    [ params setObject : _twitterId forKey : @"twId" ] ;
    [ params setObject : _twittertoken forKey : @"twToken" ] ;
    [ params setObject : _firstname forKey : @"first" ] ;
    [ params setObject : _lastname forKey : @"last" ] ;
    [ params setObject : _avatar forKey : @"avatar" ] ;
    //  [ params setObject : [ [ FUUser me ] userDeviceToken ] forKey : @"token" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

#pragma mark - Profile
- ( void ) ProfileGet : (NSInteger) userId
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_PROFILEGET forKey : @"action" ] ;
    [ params setObject : [NSString stringWithFormat:@"%d", userId, nil] forKey : @"sender" ] ;
    [ params setObject : [[FUUser me] userIdString] forKey : @"myId" ] ;

    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

#pragma mark - Profile
- ( void ) ProfileSet : ( NSData* ) _avatar
           background : ( NSData* ) _background
          description : ( NSString* ) _descrption
          firstname   : (NSString*) _firstname
           lastname   : (NSString*) _lastname
                age   : ( int ) _age
               gender : ( int ) _gender
             city     : ( NSString* ) _city
             province : ( NSString* ) _province
             country  : ( NSString* ) _country
             fullname : ( NSString* ) _fullname
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_PROFILESET forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
//    [ params setObject : _descrption forKey : @"description" ] ;
    [ params setObject : _firstname forKey : @"firstname" ] ;
    [ params setObject : _lastname forKey : @"lastname" ] ;
    [ params setObject : [NSString stringWithFormat:@"%d", _age] forKey : @"age" ] ;
    [ params setObject : [NSString stringWithFormat:@"%d", _gender] forKey : @"gender" ] ;
    [ params setObject : _city forKey : @"city" ] ;
    [ params setObject : _province forKey : @"province" ] ;
    [ params setObject : _country forKey : @"country" ] ;
    [ params setObject : _fullname forKey : @"fullname" ] ;
    // Web Service ;
    [ self sendToService:params photo:_avatar background:_background success:_success failure:_failure];
}

- ( void ) ProfileSetPersonType : ( NSString* ) _type
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_PROFILESET forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    [ params setObject : _type forKey : @"persontype" ] ;

    // Web Service ;
    [ self sendToService:params success:_success failure:_failure];
}


#pragma mark - Follow
- ( void ) FollowerAdd : ( FUUser* ) _user
             successed : ( void (^)( id _responseObject ) ) _success
               failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FOLLOWERADD forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    [ params setObject : [ _user userIdString ] forKey : @"follower" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) FollowerRemove : (int) _userId
                successed : ( void (^)( id _responseObject ) ) _success
                  failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FOLLOWERREMOVE forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    [ params setObject : [NSString stringWithFormat:@"%d", _userId, nil] forKey : @"follower" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) Followers : ( FUUser* ) _user
           successed : ( void (^)( id _responseObject ) ) _success
             failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FOLLOWERS forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    [ params setObject : [ _user userIdString ] forKey : @"to" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) Followings : ( FUUser* ) _user
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FOLLOWINGS forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    [ params setObject : [ _user userIdString ] forKey : @"from" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) UserRecommend : ( FUUser* ) _user
        successed : ( void (^)( id _responseObject ) ) _success
          failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_USERRECOMMEND forKey : @"action" ] ;
    [ params setObject : _user.userIdString forKey : @"sender" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) Search : ( NSString* ) _key
        successed : ( void (^)( id _responseObject ) ) _success
          failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_SEARCH forKey : @"action" ] ;
    [ params setObject : _key forKey : @"key" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

#pragma mark - Feed
- ( void ) FeedPost : ( FUFeed* ) _feed
               photo: (NSData*)photoData
          successed : ( void (^)( id _responseObject ) ) _success
            failure : ( void (^)( NSError* _error ) ) _failure ;
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FEEDPOST forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;

    //workout params
    [ params setObject : _feed.workout.mName        forKey : @"workout_name" ] ;
    [ params setObject : _feed.workout.mType        forKey : @"workout_type" ] ;
    [ params setObject : _feed.workout.mDescription forKey : @"workout_desc" ] ;
    [ params setObject : _feed.workout.mPostType    forKey : @"post_type" ] ;
    
    // Web Service ;
    [self sendToService:params photo:photoData background:nil success:_success failure:_failure];
}

- ( void ) FeedCancel : ( FUFeed* ) _feed
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FEEDCANCEL forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    [ params setObject : [ _feed  feedIdString] forKey : @"post" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) Feeds : ( FUUser* ) _user
       successed : ( void (^)( id _responseObject ) ) _success
         failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FEEDS forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    [ params setObject : [ _user userIdString ] forKey : @"poster" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) FeedFriends : ( FUUser* ) _user
             successed : ( void (^)( id _responseObject ) ) _success
               failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FEEDFRIENDS forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}
/*
- ( void ) FeedLiked : ( FUUser* ) _user
           successed : ( void (^)( id _responseObject ) ) _success
             failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FEEDLIKED forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}
*/
- ( void ) FeedRecommend : ( FUUser* ) _user
           successed : ( void (^)( id _responseObject ) ) _success
             failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FEEDRECOMMEND forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;

    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) FeedSearch : ( NSString* ) _searchKey
               successed : ( void (^)( id _responseObject ) ) _success
                 failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_FEEDSEARCH forKey : @"action" ] ;
    [ params setObject : _searchKey forKey : @"key" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}


#pragma mark - Like
- ( void ) Like : ( FUFeed* ) _feed
      successed : ( void (^)( id _responseObject ) ) _success
        failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_LIKE forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    [ params setObject : [ _feed feedIdString ] forKey : @"post" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) LikeCancel : ( FUFeed* ) _feed
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_LIKECANCEL forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    [ params setObject : [_feed feedIdString ] forKey : @"post" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) Likes : ( FUFeed* ) _feed
       successed : ( void (^)( id _responseObject ) ) _success
         failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_LIKES forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    [ params setObject : [_feed feedIdString] forKey : @"post" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

#pragma mark - Comment
- ( void ) CommentWorkout : ( FUFeed* ) _feed
               comment : ( NSString* ) _comment
             successed : ( void (^)( id _responseObject ) ) _success
               failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_COMMENTTEXT forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    [ params setObject : [ _feed feedIdString ] forKey : @"post" ] ;
    [ params setObject : _comment forKey : @"text" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) Comments : ( FUFeed* ) _feed
          successed : ( void (^)( id _responseObject ) ) _success
            failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_COMMENTS forKey : @"action" ] ;
    [ params setObject : [ [ FUUser me ] userIdString ] forKey : @"sender" ] ;
    [ params setObject : [_feed feedIdString ] forKey : @"post" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

#pragma mark - User search

- ( void ) UserSearch : ( NSString* ) username
                        usertype : ( NSString* ) usertype
                        page : ( int ) page
                        successed : ( void (^)( id _responseObject ) ) _success
                        failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_USERSEARCH forKey : @"action" ] ;
    [ params setObject : username forKey : @"username" ] ;
    [ params setObject : usertype forKey : @"usertype" ] ;
    [ params setObject : [NSString stringWithFormat: @"%d", page] forKey : @"page" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

#pragma mark - Relation

- ( void ) RelationGet : ( NSString* ) fromuser
             searchkey : ( NSString* ) searchkey
             successed : ( void (^)( id _responseObject ) ) _success
               failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_RELATIONGET forKey : @"action" ] ;
    [ params setObject : fromuser forKey : @"user_id" ] ;
    [ params setObject : searchkey forKey : @"search_key" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) RelationAdd : ( NSString* ) fromuser
             touser : ( NSString* ) touser
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_RELATIONADD forKey : @"action" ] ;
    [ params setObject : fromuser forKey : @"fromuser" ] ;
    [ params setObject : touser forKey : @"touser" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}

- ( void ) RelationDel : ( NSString* ) fromuser
                touser : ( NSString* ) touser
             successed : ( void (^)( id _responseObject ) ) _success
               failure : ( void (^)( NSError* _error ) ) _failure
{
    // Params ;
    NSMutableDictionary*    params  = [ NSMutableDictionary dictionary ] ;
    
    [ params setObject : WEBAPI_RELATIONDEL forKey : @"action" ] ;
    [ params setObject : fromuser forKey : @"fromuser" ] ;
    [ params setObject : touser forKey : @"touser" ] ;
    
    // Web Service ;
    [ self sendToService : params success : _success failure : _failure ] ;
}


@end
