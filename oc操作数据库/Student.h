

#import <Foundation/Foundation.h>

@interface Student : NSObject

/*** 姓名 ***/
@property (nonatomic,strong) NSString *name;
/*** 年龄 ***/
@property (nonatomic,assign) NSInteger age;

- (instancetype)initWithName:(NSString *)name Age:(NSInteger)age;
- (instancetype)initWithDict:(NSDictionary *)dict;

- (void)insertStudent;

+ (NSArray *)loadData;

@end

