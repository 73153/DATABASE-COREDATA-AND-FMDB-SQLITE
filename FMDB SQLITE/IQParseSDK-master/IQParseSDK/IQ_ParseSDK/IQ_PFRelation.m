//
//  IQ_PFRelation.m
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

#import "IQ_PFRelation.h"
#import "IQPFHTTPServiceConstants.h"

@interface IQ_PFObject ()

-(NSDictionary*)coreSerializedAttribute;

@end


@implementation IQ_PFRelation
{
    NSMutableArray *_objectsToAdd;
    NSMutableArray *_objectsToRemove;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _objectsToAdd = [[NSMutableArray alloc] init];
        _objectsToRemove = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSDictionary*)coreSerializedAttribute
{
    return @{ kParse__TypeKey: kParseRelationKey, kParseClassNameKey: self.targetClass};
}


//-(NSDictionary*)deserializedAttributes
//{
//    NSDictionary *addRelation = nil;
//    NSDictionary *removeRelation = nil;
//    
//    if (_objectsToAdd.count)
//    {
//        NSMutableArray *addObjects = [[NSMutableArray alloc] init];
//        
//        for (IQ_PFObject *object in _objectsToAdd)
//        {
//            [addObjects addObject:[object coreSerializedAttribute]];
//        }
//        
//        addRelation = @{kParse__OpKey: kParseAddRelationKey, kParseObjectsKey: addObjects};
//    }
//    
//    if (_objectsToRemove)
//    {
//        NSMutableArray *removeObjects = [[NSMutableArray alloc] init];
//        
//        for (IQ_PFObject *object in _objectsToRemove)
//        {
//            [removeObjects addObject:[object coreSerializedAttribute]];
//        }
//        
//        removeRelation = @{kParse__OpKey: kParseRemoveRelationKey, kParseObjectsKey: removeObjects};
//    }
//    
//    //https://www.parse.com/questions/rest-api-addrelation-and-remove-relation-in-the-one-put
//    if (_objectsToAdd.count && _objectsToRemove)
//    {
//        return @{kParse__OpKey: kParseBatchKey,kParseOpsKey:@[addRelation,removeRelation]};
//    }
//    else if (_objectsToAdd.count)
//    {
//        return addRelation;
//    }
//    else if (_objectsToRemove.count)
//    {
//        return removeRelation;
//    }
//    else
//    {
//        return @{};
//    }
//}
//
//- (IQ_PFQuery *)query
//{
//
//}
//
//- (void)addObject:(IQ_PFObject *)object
//{
//    [_objectsToAdd addObject:object];
//}
//
//- (void)removeObject:(IQ_PFObject *)object
//{
//    [_objectsToRemove addObject:object];
//}

@end





