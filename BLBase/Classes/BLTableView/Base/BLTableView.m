//
//  BLTableView.m
//  BLTableView
//
//  Created by boundlessocean on 2018/10/24.
//

#import "BLTableView.h"
@interface BLTableView ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation BLTableView


+ (instancetype)bs_tableView{
    
    
    return [BLTableView bs_tableViewWithStyle:UITableViewStylePlain];
}

+ (instancetype)bs_tableViewWithStyle:(UITableViewStyle)style{
    return [[BLTableView alloc] initWithFrame:kDefaultTableFrame style:style];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_configTable];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self p_configTable];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self p_configTable];
    }
    return self;
}



#pragma mark - - Private
- (void)p_configTable{
    self.dataSource = self;
    self.delegate = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor clearColor];
    _bs_registeType = MTTableViewRegisteTypeNib;
    _bs_isFristLoad = YES;
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
#if __has_include(<BLBase/BLTableView+EmptyDataSource.h>)
    if ([self respondsToSelector:NSSelectorFromString(@"bs_configEmptyTable")]) {
        [self performSelectorOnMainThread:NSSelectorFromString(@"bs_configEmptyTable") withObject:nil waitUntilDone:YES];
    }
#endif
    
#if __has_include(<BLBase/BLTableView+Refresh.h>)
    if ([self respondsToSelector:NSSelectorFromString(@"bs_configRefreshTable")]) {
        [self performSelectorOnMainThread:NSSelectorFromString(@"bs_configRefreshTable") withObject:nil waitUntilDone:YES];
    }
#endif
}


#pragma mark - - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  !_bs_sectionCountBlock ? 1 : _bs_sectionCountBlock();
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return !_bs_rowCountBlock ? self.bs_dataArray.count : _bs_rowCountBlock(section);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_bs_rowCountBlock && indexPath.row >= self.bs_dataArray.count) return [UITableViewCell new];
    /** 当实现了 _bs_sectionCountBlock 并且 _bs_identifiers只有一个标识 的时候取第一个 */
    NSString *identifier = _bs_sectionCountBlock && _bs_identifiers.count == 1 ? _bs_identifiers.firstObject : _bs_identifiers[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = !_bs_cellBlock ? cell : _bs_cellBlock(cell,indexPath);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return !_bs_headerBlock ? [UIView new] : _bs_headerBlock(section);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return !_bs_headerHeightBlock ? CGFLOAT_MIN : _bs_headerHeightBlock(section);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return !_bs_footerBlock ? [UIView new] : _bs_footerBlock(section);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return !_bs_footerHeightBlock ? CGFLOAT_MIN : _bs_footerHeightBlock(section);
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return !_bs_sectionIndexTitlesBlock ? nil : _bs_sectionIndexTitlesBlock();
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index{
    return !_bs_sectionIndexSelectedBlock ? 0 : _bs_sectionIndexSelectedBlock(title,index);
}

#pragma mark - - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_bs_rowCountBlock && indexPath.row >= self.bs_dataArray.count) return 0;
    return _bs_rowHeightBlock ? _bs_rowHeightBlock(indexPath) : tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    !_bs_cellSelectedBlock ? : _bs_cellSelectedBlock(indexPath);
}


#pragma mark - - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    !_bs_viewDidScroll ? : _bs_viewDidScroll(scrollView);
}


#pragma mark - - Getter
- (NSMutableArray *)bs_identifiers{
    if (!_bs_identifiers) {
        _bs_identifiers = [NSMutableArray arrayWithCapacity:0];
    }
    return _bs_identifiers;
}

- (NSMutableArray *)bs_dataArray{
    if (!_bs_dataArray) {
        _bs_dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _bs_dataArray;
}

#pragma mark - - Setter

- (void)setBs_identifier:(NSString *)bs_identifier{
    _bs_identifier = bs_identifier;
    [self.bs_identifiers addObject:bs_identifier];
    [self registeForCellReuseType:_bs_registeType identifier:_bs_identifier];
}

- (void)registeForCellReuseType:(MTTableViewRegisteType)type identifier:(NSString *)identifier{
    if (type == MTTableViewRegisteTypeClass) {
        [self registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
    } else{
        [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    }
}


#pragma mark - - Public
- (void)bs_tableViewScrollToBottom{
    [self layoutIfNeeded];
    if (self.bs_dataArray.count > 1) {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.bs_dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }
}

@end
