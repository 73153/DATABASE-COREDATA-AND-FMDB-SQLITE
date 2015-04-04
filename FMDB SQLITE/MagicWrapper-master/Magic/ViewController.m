#import "ViewController.h"
#import "MagicWrapper.h"

@interface ViewController ()
@property (nonatomic, strong) MTGAPIWrapper *wrapper;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.wrapper = [[MTGAPIWrapper alloc] init];
}

#pragma mark - Private

#pragma mark Types

- (IBAction)cardTypesTapped:(id)sender
{
    MTGCardTypesRequest *request = [[MTGCardTypesRequest alloc] init];
    
    [self.wrapper submitRequest:request
                        success:^(MTGRequest *request, id responseObject) {
                            NSLog(@"==> %@", responseObject);
                        } failure:^(MTGRequest *request, NSError *error) {
                            NSLog(@"==> %@", error.localizedDescription);
                        }];
}

- (IBAction)cardSubtypesTapped:(id)sender
{
    MTGCardSubtypesRequest *request = [[MTGCardSubtypesRequest alloc] init];
    
    [self.wrapper submitRequest:request
                        success:^(MTGRequest *request, id responseObject) {
                            NSLog(@"==> %@", responseObject);
                        } failure:^(MTGRequest *request, NSError *error) {
                            NSLog(@"==> %@", error.localizedDescription);
                        }];
}

#pragma mark Cards

- (IBAction)cardTapped:(id)sender
{
    MTGCardRequest *request = [[MTGCardRequest alloc] initWithCardID:@"123"];
    
    [self.wrapper submitRequest:request
                        success:^(MTGRequest *request, MTGCard *card) {
                            NSLog(@"==> %@", card.description);
                        } failure:^(MTGRequest *request, NSError *error) {
                            NSLog(@"==> %@", error.localizedDescription);
                        }];
}

- (IBAction)cardsTapped:(id)sender
{
    MTGCardsRequest *request = [[MTGCardsRequest alloc] initWithCardIDs:@[@"123", @"321"]];
    
    [self.wrapper submitRequest:request
                        success:^(MTGRequest *request, NSArray *cards) {
                            NSLog(@"==> %@", cards);
                        } failure:^(MTGRequest *request, NSError *error) {
                            NSLog(@"==> %@", error.localizedDescription);
                        }];
}

- (IBAction)cardsFromSetTapped:(id)sender
{
    MTGCardsRequest *request = [[MTGCardsRequest alloc] initWithSetID:@"KTK"];
    request.pagination = NSMakeRange(10, 5);
    
    [self.wrapper submitRequest:request
                        success:^(MTGRequest *request, NSArray *cards) {
                            NSLog(@"==> %@", cards);
                        } failure:^(MTGRequest *request, NSError *error) {
                            NSLog(@"==> %@", error.localizedDescription);
                        }];
}

#pragma mark Sets

- (IBAction)setsTapped:(id)sender
{
    MTGCardSetsRequest *request = [[MTGCardSetsRequest alloc] init];
    
    [self.wrapper submitRequest:request
                        success:^(MTGRequest *request, NSArray *sets) {
                            NSLog(@"==> %@", sets);
                        } failure:^(MTGRequest *request, NSError *error) {
                            NSLog(@"==> %@", error.localizedDescription);
                        }];
}

- (IBAction)selectedSetsTapped:(id)sender
{
    MTGCardSetsRequest *request = [[MTGCardSetsRequest alloc] initWithCardSets:@[@"4ED", @"KTK"]];
    
    [self.wrapper submitRequest:request
                        success:^(MTGRequest *request, NSArray *sets) {
                            NSLog(@"==> %@", sets);
                        } failure:^(MTGRequest *request, NSError *error) {
                            NSLog(@"==> %@", error.localizedDescription);
                        }];
}

- (IBAction)setTapped:(id)sender
{
    MTGCardSetRequest *request = [[MTGCardSetRequest alloc] initWithSetID:@"KTK"];
    
    [self.wrapper submitRequest:request
                        success:^(MTGRequest *request, MTGCardSet *set) {
                            NSLog(@"==> %@", set);
                        } failure:^(MTGRequest *request, NSError *error) {
                            NSLog(@"==> %@", error.localizedDescription);
                        }];
}

#pragma mark Search

- (IBAction)searchTapped:(id)sender
{
    MTGSearchRequest *search = [[MTGSearchRequest alloc] initWithQuery:@{MTGSearchName : @"shivan",
                                                                         MTGSearchConvertedManaCost : @6}];
    search.pagination = NSMakeRange(0, 10);
    
    [self.wrapper submitRequest:search
                        success:^(MTGRequest *request, NSArray *cards) {
                            NSLog(@"==> %@", cards);
                        } failure:^(MTGRequest *request, NSError *error) {
                            NSLog(@"==> %@", error.localizedDescription);
                        }];
}

@end
