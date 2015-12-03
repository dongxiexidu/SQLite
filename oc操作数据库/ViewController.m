
#import "ViewController.h"
#import "Student.h"
#import "SQLiteManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     * NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
     filePath = [filePath stringByAppendingPathComponent:@"student.sqlite"];

     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 创建20条模拟数据
//    for (int i = 0; i < 20; i++) {
//        NSString *name = [NSString stringWithFormat:@"zs%d", arc4random_uniform(10)];
//        NSInteger age = arc4random_uniform(10) + 15;
//        Student *stu = [[Student alloc] initWithName:name Age:age];
//        [stu insertStudent];
//    }

// 更新数据库
 // [self updateData];
    
    NSArray *dataArray =  [Student loadData];
    NSLog(@"%@",dataArray);
}

- (void)updateData
{
    // 1.封装更新数据库的SQL语句
    NSString *sql = @"UPDATE t_student SET name = 'zs10' WHERE age >= 22;";

    if ([[SQLiteManager shareInstance] execSQL:sql]) {
        NSLog(@"更新成功");
    }
}

@end
