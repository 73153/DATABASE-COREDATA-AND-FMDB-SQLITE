![magicwrapper](https://cloud.githubusercontent.com/assets/139272/5171794/958d3bfa-73cf-11e4-80ca-944765542483.png)
[![Travis-CI](https://img.shields.io/travis/otaviocc/MagicWrapper.svg)](https://travis-ci.org/otaviocc/MagicWrapper) [![CocoaPod Version](https://img.shields.io/cocoapods/v/MagicWrapper.svg)](http://cocoapods.org/?q=MagicWrapper) [![CocoaPod Platform](https://img.shields.io/cocoapods/p/MagicWrapper.svg)](http://cocoapods.org/?q=MagicWrapper) [![License](https://img.shields.io/cocoapods/l/MagicWrapper.svg)](http://cocoapods.org/?q=MagicWrapper)

Magic Wrapper is an Objective-C client/wrapper for [M:tgDb](https://www.mtgdb.info/), the [Magic the Gathering](http://magic.wizards.com/) open database project. It consists of an API wrapper responsible for the network calls (``MTGAPIWrapper``), requests classes (subclasses of the ``MTGRequest`` class), and classes for cards and card sets (``MTGCard`` and ``MTGCardSet``).

Check [DeckBrew Wrapper](https://github.com/otaviocc/DeckBrewWrapper) for my other Magic the Gathering API wrapper. It includes prices and card editions.

---

* [API Wrapper](#api-wrapper)
* Requests
    * [Card Types Requests](#card-types-requests)
    * [Cards Requests](#cards-requests)
    * [Card Sets Requests](#card-sets-requests)
    * [Search Requests](#search-requests) (+ request example)
* Objects
    * [MTGCard](#mtgcard)
    * [MTGCardSet](#mtgcardset)
* [Contributing](#contributing)
* [License](#license)

---

## How to use it?

[CocoaPods](http://cocoapods.org) is the recommended way to consume Magic Wrapper

1. Add MagicWrapper to your Podfile ``pod 'MagicWrapper'``.
    1. Use ``pod search MagicWrapper`` to search for specific versions of MagicWrapper.
1. Install the pod by running `pod install`.
1. Import the MagicWrapper's header file in your product ``#import <MagicWrapper/MagicWrapper.h>``

## API Wrapper

``MTGAPIWrapper`` doesn't have a custom init methods and can be easily initialized with alloc/init,

```objective-c
MTGAPIWrapper *wrapper = [[MTGAPIWrapper alloc] init];
```

and it has one method, responsible for all the API requests:

```objective-c
- (void)submitRequest:(MTGRequest *)request
              success:(void (^)(MTGRequest *request, id responseObject))success
              failure:(void (^)(MTGRequest *request, NSError *error))failure;
```

When requests are submitted, ``responseObject`` can assume different types depending on the request type. Possible types are:

* ``MTGCard``
* ``MTGCardSet``
* ``NSArray`` of
    * ``MTGCard`` objects
    * ``MTGCardSet`` objects

All the possible scenarios are described below.

## Requests

### Card Types Requests

* MTGCardTypesRequest
* MTGCardSubtypesRequest

``MTGCardTypesRequest`` and ``MTGCardSubtypesRequest`` don't have custom init methods. When requests are submitted, ``responseObject`` returns as an ``NSArray`` of ``NSStrings``.

### Cards Requests

* MTGCardRequest
* MTGCardsRequest

``MTGCardRequest`` has a single init method that takes a card id. When the request is submitted, ``responseObject`` returns as a ``MTGCard`` object.

```objective-c
@interface MTGCardRequest : MTGRequest
- (instancetype)initWithCardID:(NSString *)cardId;
@end
```

``MTGCardsRequest`` has two init methods and a pagination property. When submitted, ``responseObject`` returns as an ``NSArray`` of ``MTGCard`` objects.

```objective-c
@interface MTGCardsRequest : MTGRequest
@property (nonatomic) NSRange pagination;
- (instancetype)initWithCardIDs:(NSArray *)cardIDs;
- (instancetype)initWithSetID:(NSString *)setID;
@end
```

### Card Sets Requests

* MTGCardSetRequest
* MTGCardSetsRequest

``MTGCardSetRequest`` has a single init method that takes a set id. When the request is submitted, ``responseObject`` returns as a ``MTGCardSet`` object.

```objective-c
@interface MTGCardSetRequest : MTGRequest
- (instancetype)initWithSetID:(NSString *)setID;
@end
```

``MTGCardSetsRequest`` has two init methods. The first one fetches all the sets available and latter fetches the given sets by ID. When requests are submitted, ``responseObject`` returns as an ``NSArray`` of ``MTGCardSet`` objects.

```objective-c
@interface MTGCardSetsRequest : MTGRequest
- (instancetype)init;
- (instancetype)initWithCardSets:(NSArray *)cardSets;
@end
```

### Search Requests

* MTGSearchRequest

``MTGSearchRequest`` has a single init method that takes a dictionary of searchable items. When the request is submitted, ``responseObject`` returns as an ``NSArray`` of ``MTGCard`` objects.

```objective-c
@interface MTGSearchRequest : MTGRequest
@property (nonatomic) NSRange pagination;
- (instancetype)initWithQuery:(NSDictionary *)query;
@end
```

The ``query`` dictionary should include one or more items of the list below:

```objective-c
extern NSString *const MTGSearchName;
extern NSString *const MTGSearchDescription;
extern NSString *const MTGSearchFlavor;
extern NSString *const MTGSearchColor;
extern NSString *const MTGSearchManaCost;
extern NSString *const MTGSearchConvertedManaCost;
extern NSString *const MTGSearchType;
extern NSString *const MTGSearchSubtype;
extern NSString *const MTGSearchPower;
extern NSString *const MTGSearchToughness;
extern NSString *const MTGSearchLoyalty;
extern NSString *const MTGSearchRarity;
extern NSString *const MTGSearchArtist;
extern NSString *const MTGSearchSetID;
```

Request example:

```objective-c
NSDictionary *queryDictionary = @{MTGSearchName : @"shivan",
                                  MTGSearchConvertedManaCost : @6};

MTGSearchRequest *search = [[MTGSearchRequest alloc] initWithQuery:queryDictionary];

[self.wrapper submitRequest:search
                    success:^(MTGRequest *request, NSArray *cards) {
                        NSLog(@"==> %@", cards);
                    } failure:^(MTGRequest *request, NSError *error) {
                        NSLog(@"==> %@", error.localizedDescription);
                    }];
```

Output from the NSLog above:

```
2014-11-23 10:28:16.975 Magic[22595:387062] ==> (
    "<MTGCard: 0x7be782f0, name: Shivan Dragon, id: 222, type: Creature, mana cost: 6, set id: LEA>",
    "<MTGCard: 0x7be7a340, name: Shivan Dragon, id: 517, type: Creature, mana cost: 6, set id: LEB>",
    "<MTGCard: 0x7be78c10, name: Shivan Dragon, id: 819, type: Creature, mana cost: 6, set id: 2ED>",
    "<MTGCard: 0x7be78c80, name: Shivan Dragon, id: 1318, type: Creature, mana cost: 6, set id: 3ED>",
    "<MTGCard: 0x7be78cf0, name: Shivan Dragon, id: 2303, type: Creature, mana cost: 6, set id: 4ED>",
    "<MTGCard: 0x7be7ae20, name: Viashivan Dragon, id: 3747, type: Creature, mana cost: 6, set id: VIS>",
    "<MTGCard: 0x7be7ae90, name: Shivan Dragon, id: 4088, type: Creature, mana cost: 6, set id: 5ED>",
    "<MTGCard: 0x7be7af00, name: Shivan Phoenix, id: 12423, type: Creature, mana cost: 6, set id: ULG>",
    "<MTGCard: 0x7be7af70, name: Shivan Dragon, id: 25688, type: Creature, mana cost: 6, set id: 7ED>",
    "<MTGCard: 0x7be7afe0, name: Shivan Dragon, id: 26622, type: Creature, mana cost: 6, set id: BTD>"
)
```

## Objects

As mentioned before, ``responseObject`` can assume different types depending on the request type. Possible types are:

* ``MTGCard``
* ``MTGCardSet``
* ``NSArray`` of
    * ``MTGCard`` objects
    * ``MTGCardSet`` objects

### MTGCard

``MTGCard`` represents a Magic: the Gathering card. All properties are read-only. For convenience, it implements the methods ``-isEqual:``, ``-hash``, and it also implements the method ``-description`` as shown below:

```
<MTGCard: 0x7aeab0b0, name: Shivan Dragon, id: 222, type: Creature, mana cost: 6, set id: LEA>
```

### MTGCardSet

``MTGCardSet`` represents a Magic: the Gathering set. All properties are read-only. It implements the methods ``-isEqual:``, ``-hash``, and ``-description`` as shown below:

```
<MTGCardSet: 0x7c0d7150, name: Khans of Tarkir, id: KTK, type: Expansion, n. cards: 269>
```

# Contributing

Want to contribute? Perfect!

1. Fork it.
1. Create a branch (`git checkout -b my_awesome_feature`)
1. Commit your changes (`git commit -am "Added new awesome feature"`)
1. Make sure you have tests for the new feature
1. Push to the branch (`git push origin my_awesome_feature`)
1. Open a Pull Request
1. Enjoy a fancy latte and wait

# License

Copyright (c) 2014 Otavio Cordeiro. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
