//
//  CHMasterViewController.m
//  CHTumbletailActivity
//
//  Created by nya on 2012/10/02.
//  Copyright (c) 2012年 cathand.org. All rights reserved.
//

#import "CHMasterViewController.h"
#import "CHTumbletailActivity.h"

@interface CHMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation CHMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)dealloc
{
	[_objects release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;

	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

	NSDate *object = _objects[indexPath.row];
	cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}
*/

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	UIViewController *vc = nil;
	NSArray *activities = [NSArray arrayWithObjects:[[[CHTumbletailActivityPhoto alloc] init] autorelease], [[[CHTumbletailActivityQuote alloc] init] autorelease], [[[CHTumbletailActivityLink alloc] init] autorelease], nil];
	
	NSString *title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
	if ([title isEqualToString:@"Photo"]) {
		UIActivityViewController *activityView = [[[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObject:[UIImage imageNamed:@"sample.jpg"]] applicationActivities:activities] autorelease];
		vc = activityView;
	} else if ([title isEqualToString:@"Quote"]) {
		UIActivityViewController *activityView = [[[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObject:@"test qupte"] applicationActivities:activities] autorelease];
		vc = activityView;
	} else if ([title isEqualToString:@"Link"]) {
		UIActivityViewController *activityView = [[[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObject:[NSURL URLWithString:@"http://cathand.org/"]] applicationActivities:activities] autorelease];
		vc = activityView;
	}
	
	if (vc) {
		[self presentViewController:vc animated:YES completion:^{
		}];
	}
}

@end
