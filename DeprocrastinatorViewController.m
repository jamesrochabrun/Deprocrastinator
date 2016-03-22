//
//  DeprocrastinatorViewController.m
//  Deprocrastinator1
//
//  Created by James Rochabrun on 21-03-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "DeprocrastinatorViewController.h"

@interface DeprocrastinatorViewController ()<UITableViewDataSource, UITextFieldDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSMutableArray *tasksArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property UIAlertController *deleteConfirmation;

@end

@implementation DeprocrastinatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tasksArray = [@[@"go shopping", @"take out the trash", @"feed the dog"] mutableCopy];
    
  
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *taskCell = [tableView dequeueReusableCellWithIdentifier:@"task"];

    taskCell.textLabel.text =self.tasksArray[indexPath.row];
    
    return taskCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasksArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor greenColor];
    
    //extra stuff
//    cell.textLabel.textColor = [UIColor whiteColor];
    

    
    
}


//adding a delete method, with the tableView:commitEditingStyle method

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    self.deleteConfirmation = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:@"You can't undo this" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //removing the title in the cell
        [self.tasksArray removeObjectAtIndex:indexPath.row];
        
        
        //finally we reolad the data of the tableView
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
      
    }];
    
    
    [self.deleteConfirmation addAction:confirm];
    [self.deleteConfirmation addAction:cancel];

    [self presentViewController:self.deleteConfirmation animated:true completion:nil];
    
}

- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {
    
    [self.textField becomeFirstResponder];
    [self.tasksArray addObject:self.textField.text];
    [self.tableView reloadData];
    [self.textField endEditing:YES];
    self.textField.text = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField becomeFirstResponder];
    [self.tasksArray addObject:self.textField.text];
    [self.tableView reloadData];
    [self.textField endEditing:YES];
    self.textField.text = nil;
    return YES;
    
    
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    if (self.editing) {
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    } else{
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
        
    }
    
}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender
{

    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        CGPoint swipeLocation = [sender locationInView:self.tableView];
        NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:swipeLocation];
        UITableViewCell* swipedCell = [self.tableView cellForRowAtIndexPath:swipedIndexPath];
        
        
        if ([swipedCell.textLabel.textColor isEqual:[UIColor blackColor]]){
            
            swipedCell.textLabel.textColor = [UIColor greenColor];

        } else if ([swipedCell.textLabel.textColor isEqual:[UIColor greenColor]]){
            swipedCell.textLabel.textColor = [UIColor orangeColor];

        } else if ([swipedCell.textLabel.textColor isEqual:[UIColor orangeColor]]){
        swipedCell.textLabel.textColor = [UIColor redColor];
            
        } else {
            swipedCell.textLabel.textColor = [UIColor blackColor];

        }
    }
}



//adding a delegate method tableView:canMoveRowAtindexPath: and return true

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

//also need to add the delegate method tableView:moveRowAtIndexPath:toIndexPath:

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    
    //we use the sourceIndexPath parameter to asign a title in the array
    NSString *title = [self.tasksArray objectAtIndex:sourceIndexPath.row];
    //we use the title local variable to remove it form the array
    [self.tasksArray removeObject:title];
    //we use the same variable and the destinationIndexPath parameter to insert it in the array
    [self.tasksArray insertObject:title  atIndex:destinationIndexPath.row];
    
    
    
}



@end











