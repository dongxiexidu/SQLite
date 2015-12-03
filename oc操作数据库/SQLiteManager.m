

#import "SQLiteManager.h"
#import <sqlite3.h>

@interface SQLiteManager ()
@property (nonatomic,assign) sqlite3 *db;
@end

@implementation SQLiteManager
static id _instance;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[SQLiteManager alloc] init];
    });
    return _instance;
}

// 打开数据库
- (BOOL)openDB
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
   filePath = [filePath stringByAppendingPathComponent:@"student.sqlite"];
    
    // 打开一个数据库文件:如果存在则直接打开,如果不存在,先创建在打开
    if (sqlite3_open(filePath.UTF8String, &_db) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return NO;
    }
    
    return [self creatTable];

}

- (BOOL)creatTable{
    // 封装创建表的语句
    NSString *createTable = @"CREATE TABLE IF NOT EXISTS 't_student' ( 'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'name' TEXT,'age' INTEGER);";

    return [self execSQL:createTable];
}

- (BOOL)execSQL:(NSString *)sql
{
    return sqlite3_exec(self.db, sql.UTF8String, nil, nil, nil) == SQLITE_OK;
}
// 返回一个装有数据的数组
- (NSArray *)querySQL:(NSString *)querySQL
{
    // 定义游标对象
    sqlite3_stmt *stmt = nil;
    
    // 准备查询
    if (sqlite3_prepare_v2(self.db, querySQL.UTF8String, -1, &stmt, nil) != SQLITE_OK) {
        NSLog(@"准备查询失败");
        return nil;
    }
    
    NSMutableArray *dictArray = [NSMutableArray array];
    // 准备成功,开始查询
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        // 获取一共多少列
        int count = sqlite3_column_count(stmt);
        
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        for (int i = 0; i<count; i++) {
            // 取出i对应的字段名,作为字典的key
            const char *ckey =  sqlite3_column_name(stmt, i);
            NSString *key = [NSString stringWithUTF8String:ckey];
            
             // 取出i对应储存的值,作为字典的value
            const char *cValue = (const char *)sqlite3_column_text(stmt, i);
            NSString *value = [NSString stringWithUTF8String:cValue];
            
          //  dictM[key] = value;
            [dictM setValue:value forKey:key];
        }
        
        [dictArray addObject:dictM];
    }
    return dictArray;

}


@end
