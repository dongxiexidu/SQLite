

#import "Student.h"
#import "SQLiteManager.h"

@implementation Student

- (instancetype)initWithName:(NSString *)name Age:(NSInteger)age
{
    if (self = [super init]) {
        self.name = name;
        self.age = age;
    }
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)insertStudent
{
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO t_student (name, age) VALUES ('%@', %ld)",self.name,self.age];
    
    if ([[SQLiteManager shareInstance] execSQL:insertSQL]) {
        NSLog(@"数据插入成功");
    };

}

// 查数据
+ (NSArray *)loadData
{
    // 1.封装查询的语句
    NSString *querySQL = @"SELECT name,age FROM t_student;";
    
    // 2.执行查询语句-->注意标点符号分号,要包括在内
    NSArray *dictArray = [[SQLiteManager shareInstance] querySQL:querySQL];
    
    // 3.字典数组转模型对象数组
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        [tempArray addObject:[[Student alloc] initWithDict:dict]];
    }
    
         return tempArray;
}
@end
