//
//  ViewController.m
//  searchVCTest
//
//  Created by zhaoP on 16/8/5.
//  Copyright © 2016年 langya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *searchList;
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,strong) UISearchController *searchVC;
@end

@implementation ViewController



- (void)viewDidLoad {
	[super viewDidLoad];
//	self.navigationController.navigationBar.translucent = NO;
	self.dataList = @[@"aaababa",@"sdfa",@"cdsaa",@"eeee",@"efa",@"ssss",@"qqqqq"];
	self.searchList = [NSMutableArray array];
	_tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
	_tableView.backgroundColor = [UIColor redColor];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	[self.view addSubview:_tableView];

	NSString *testByDeskSearch = @"testByDeskSearch";
	
	_searchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
	_searchVC.searchResultsUpdater = self;
	_searchVC.dimsBackgroundDuringPresentation = NO;
	self.definesPresentationContext = YES;//UISearchControll默认支持OverCurrentContext,他会向上寻找一个definesPresentationContext为yes的真父视图控制器，并且在他之上显示这个视图。
	_searchVC.searchBar.placeholder = @"请输入搜索内容";
	_tableView.tableHeaderView = _searchVC.searchBar;
	
	
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
	[self filterContentForSearchText:searchController.searchBar.text];
}

-(void)filterContentForSearchText:(NSString *)searchText{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",searchText];
	if (self.searchList != nil) {
		[self.searchList removeAllObjects];
	}
	self.searchList = [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:predicate]];
	[self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (self.searchVC.active) {
		// 返回搜索后的数组
		return self.searchList.count;
	} else {
		return self.dataList.count;
	}
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *cellId = @"cellID";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
	}
	
	if (self.searchVC.active) {
		cell.textLabel.text = self.searchList[indexPath.row];
	}else{
		cell.textLabel.text = self.dataList[indexPath.row];
	}
	
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	cell.backgroundColor = [UIColor greenColor];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UIViewController *vc = [[UIViewController alloc] init];
	vc.view.backgroundColor = [UIColor redColor];
	[self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
