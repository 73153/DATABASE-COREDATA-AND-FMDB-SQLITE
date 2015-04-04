//
//  IQ_PFACL.h
// https://github.com/hackiftekhar/IQParseSDK
// Copyright (c) 2013-14 Iftekhar Qurashi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <Foundation/Foundation.h>

@class IQ_PFRole, IQ_PFUser;

@interface IQ_PFACL : NSObject

//+ (IQ_PFACL *)ACL;
//+ (IQ_PFACL *)ACLWithUser:(IQ_PFUser *)user;
//- (void)setPublicReadAccess:(BOOL)allowed;
//- (BOOL)getPublicReadAccess;
//- (void)setPublicWriteAccess:(BOOL)allowed;
//- (BOOL)getPublicWriteAccess;
//- (void)setReadAccess:(BOOL)allowed forUserId:(NSString *)userId;
//- (BOOL)getReadAccessForUserId:(NSString *)userId;
//- (void)setWriteAccess:(BOOL)allowed forUserId:(NSString *)userId;
//- (BOOL)getWriteAccessForUserId:(NSString *)userId;
//- (void)setReadAccess:(BOOL)allowed forUser:(IQ_PFUser *)user;
//- (BOOL)getReadAccessForUser:(IQ_PFUser *)user;
//- (void)setWriteAccess:(BOOL)allowed forUser:(IQ_PFUser *)user;
//- (BOOL)getWriteAccessForUser:(IQ_PFUser *)user;
//- (BOOL)getReadAccessForRoleWithName:(NSString *)name;
//- (void)setReadAccess:(BOOL)allowed forRoleWithName:(NSString *)name;
//- (BOOL)getWriteAccessForRoleWithName:(NSString *)name;
//- (void)setWriteAccess:(BOOL)allowed forRoleWithName:(NSString *)name;
//- (BOOL)getReadAccessForRole:(IQ_PFRole *)role;
//- (void)setReadAccess:(BOOL)allowed forRole:(IQ_PFRole *)role;
//- (BOOL)getWriteAccessForRole:(IQ_PFRole *)role;
//- (void)setWriteAccess:(BOOL)allowed forRole:(IQ_PFRole *)role;
//+ (void)setDefaultACL:(IQ_PFACL *)acl withAccessForCurrentUser:(BOOL)currentUserAccess;

@end
