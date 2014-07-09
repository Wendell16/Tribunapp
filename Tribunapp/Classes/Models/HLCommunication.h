//
//  FUCommunication.h
//  FitnessUnion
//
//  Created by HanLong on 6/6/13.
//  Copyright (c) 2013 HanLong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FUUser;
@class FUFeed;
@class FUComment;
@class FUWorkout;

@interface FUCommunication : NSObject
// Functions ;
+ ( FUCommunication* ) sharedManager ;

// Sign ;
- ( void ) SignIn : ( NSString* ) _email
         password : ( NSString* ) _password
        successed : ( void (^)( id _responseObject ) ) _success
          failure : ( void (^)( NSError* _error ) ) _failure ;

- ( void ) SignUp : ( NSString* ) _email
         password : ( NSString* ) _password
        successed : ( void (^)( id _responseObject ) ) _success
          failure : ( void (^)( NSError* _error ) ) _failure ;

- ( void ) FacebookLogin : ( NSString* ) _facebookId
                 fbtoken : ( NSString* ) _facebooktoken
               firstname : (NSString* )_firstname
                lastname : (NSString* )_lastname
                  avatar : (NSString* )_avatar
               successed : ( void (^)( id _responseObject ) ) _success
                 failure : ( void (^)( NSError* _error ) ) _failure;

- ( void ) TwitterLogin : ( NSString* ) _twitterId
                twtoken : ( NSString* ) _twittertoken
              firstname : (NSString* )_firstname
               lastname : (NSString* )_lastname
                 avatar : (NSString* )_avatar
              successed : ( void (^)( id _responseObject ) ) _success
                failure : ( void (^)( NSError* _error ) ) _failure;

//Profile get/set
- ( void ) ProfileGet : (NSInteger) userId
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure ;
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
              failure : ( void (^)( NSError* _error ) ) _failure;
- ( void ) ProfileSetPersonType : ( NSString* ) _type
                      successed : ( void (^)( id _responseObject ) ) _success
                        failure : ( void (^)( NSError* _error ) ) _failure;
// Follows ;
- ( void ) FollowerAdd : ( FUUser* ) _user
             successed : ( void (^)( id _responseObject ) ) _success
               failure : ( void (^)( NSError* _error ) ) _failure ;

- ( void ) FollowerRemove : (int) _userId
                successed : ( void (^)( id _responseObject ) ) _success
                  failure : ( void (^)( NSError* _error ) ) _failure ;

- ( void ) Followers : ( FUUser* ) _user
           successed : ( void (^)( id _responseObject ) ) _success
             failure : ( void (^)( NSError* _error ) ) _failure ;

- ( void ) Followings : ( FUUser* ) _user
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure ;

- ( void ) UserRecommend : ( FUUser* ) _user
               successed : ( void (^)( id _responseObject ) ) _success
                 failure : ( void (^)( NSError* _error ) ) _failure;

- ( void ) Search : ( NSString* ) _key
        successed : ( void (^)( id _responseObject ) ) _success
          failure : ( void (^)( NSError* _error ) ) _failure ;

// Feed ;
- ( void ) FeedPost : ( FUFeed* ) _feed
               photo: (NSData*)photoData
          successed : ( void (^)( id _responseObject ) ) _success
            failure : ( void (^)( NSError* _error ) ) _failure ;

- ( void ) FeedCancel : ( FUFeed* ) _feed
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure ;

- ( void ) Feeds : ( FUUser* ) _user
       successed : ( void (^)( id _responseObject ) ) _success
         failure : ( void (^)( NSError* _error ) ) _failure ;

- ( void ) FeedFriends : ( FUUser* ) _user
             successed : ( void (^)( id _responseObject ) ) _success
               failure : ( void (^)( NSError* _error ) ) _failure ;
/*
- ( void ) FeedLiked : ( FUUser* ) _user
           successed : ( void (^)( id _responseObject ) ) _success
             failure : ( void (^)( NSError* _error ) ) _failure ;
*/
- ( void ) FeedRecommend : ( FUUser* ) _user
               successed : ( void (^)( id _responseObject ) ) _success
                 failure : ( void (^)( NSError* _error ) ) _failure;
- ( void ) FeedSearch : ( NSString* ) _searchKey
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure;

// Like ;
- ( void ) Like : ( FUFeed* ) _feed
      successed : ( void (^)( id _responseObject ) ) _success
        failure : ( void (^)( NSError* _error ) ) _failure ;

- ( void ) LikeCancel : ( FUFeed* ) _feed
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure ;

- ( void ) Likes : ( FUFeed* ) _feed
       successed : ( void (^)( id _responseObject ) ) _success
         failure : ( void (^)( NSError* _error ) ) _failure ;

// Comment ;
- ( void ) CommentWorkout : ( FUFeed* ) _feed
               comment : ( NSString* ) _comment
             successed : ( void (^)( id _responseObject ) ) _success
               failure : ( void (^)( NSError* _error ) ) _failure ;
- ( void ) Comments : ( FUFeed* ) _feed
          successed : ( void (^)( id _responseObject ) ) _success
            failure : ( void (^)( NSError* _error ) ) _failure ;

// User search

- ( void ) UserSearch : ( NSString* ) username
             usertype : ( NSString* ) usertype
                 page : ( int ) page
            successed : ( void (^)( id _responseObject ) ) _success
              failure : ( void (^)( NSError* _error ) ) _failure ;

// Relation

- ( void ) RelationGet : ( NSString* ) fromuser
             searchkey : ( NSString* ) searchkey
             successed : ( void (^)( id _responseObject ) ) _success
               failure : ( void (^)( NSError* _error ) ) _failure;

- ( void ) RelationAdd : ( NSString* ) fromuser
                touser : ( NSString* ) touser
             successed : ( void (^)( id _responseObject ) ) _success
               failure : ( void (^)( NSError* _error ) ) _failure;

- ( void ) RelationDel : ( NSString* ) fromuser
                touser : ( NSString* ) touser
             successed : ( void (^)( id _responseObject ) ) _success
               failure : ( void (^)( NSError* _error ) ) _failure;

@end
