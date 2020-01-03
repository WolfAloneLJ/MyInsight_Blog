## GRDB使用

### 创建数据库管理类
创建数据库管理类
```swift

```

Demo中全部代码内容如下:
`DataManager.swift`
```swift
import GRDB

struct DataBaseName {
    /// 数据库名字
    static let test = "test.db"
}

/// 数据库表名
struct TableName {
    /// 学生
    static let student = "student"
}

/// 数据库连接
class DBManager: NSObject {
    /// 数据库路径
    private static var dbPath: String = {
        // 获取工程内容数据库名字
        let filePath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!.appending("/\(DataBaseName.test)")
        
        //print("数据库地址：", filePath as Any)
        return filePath
    }()
    
    /// 数据库配置
    private static var configuration: Configuration = {
        // 配置
        var configuration = Configuration()
        // 设置超时
        configuration.busyMode = Database.BusyMode.timeout(5.0)
        // 试图访问锁着的数据
        //configuration.busyMode = Database.BusyMode.immediateError
        
        return configuration
    }()
    
    // MARK: 创建数据 多线程
    /// 数据库 用于多线程事务处理
    static var dbQueue: DatabaseQueue = {
        // 创建数据库
        let db = try! DatabaseQueue(path: DBManager.dbPath, configuration: DBManager.configuration)
        db.releaseMemory()
        // 设备版本
        return db
    }()
}
```

学生类处理:`Student.swift`
```swift
import GRDB

/// 学生类
struct Student: Codable {
    /// 名字
    var name: String?
    /// 昵称
    var nick_name: String?
    /// 年龄
    var age: Int?
    /// 性别
    var gender: Bool?
    
    /// 设置行名
    private enum Columns: String, CodingKey, ColumnExpression {
        /// 名字
        case name
        /// 昵称
        case nick_name
        /// 年龄
        case age
        /// 性别
        case gender
    }
}

extension Student: MutablePersistableRecord, FetchableRecord {
    /// 获取数据库对象
    private static let dbQueue: DatabaseQueue = DBManager.dbQueue
    
    //MARK: 创建
    /// 创建数据库
    private static func createTable() -> Void {
        try! self.dbQueue.inDatabase { (db) -> Void in
            // 判断是否存在数据库
            if try db.tableExists(TableName.student) {
                //debugPrint("表已经存在")
                return
            }
            // 创建数据库表
            try db.create(table: TableName.student, temporary: false, ifNotExists: true, body: { (t) in
                // ID
                t.column(Columns.name.rawValue, Database.ColumnType.text)
                // 名字
                t.column(Columns.nick_name.rawValue, Database.ColumnType.text)
                // 朝代
                t.column(Columns.age.rawValue, Database.ColumnType.integer)
                // 简介
                t.column(Columns.gender.rawValue, Database.ColumnType.boolean)
            })
        }
    }
    
    //MARK: 插入
    /// 插入单个数据
    static func insert(student: Student) -> Void {
        // 判断是否存在
        guard Student.query(name: student.name!) == nil else {
            debugPrint("插入学生 内容重复")
            // 更新
            self.update(student: student)
            return
        }
        
        // 创建表
        self.createTable()
        // 事务
        try! self.dbQueue.inTransaction { (db) -> Database.TransactionCompletion in
            do {
                var studentTemp = student
                // 插入到数据库
                try studentTemp.insert(db)
                return Database.TransactionCompletion.commit
            } catch {
                return Database.TransactionCompletion.rollback
            }
        }
    }
    
    //MARK: 查询
    static func query(name: String) -> Student? {
        // 创建数据库
        self.createTable()
        // 返回查询结果
        return try! self.dbQueue.unsafeRead({ (db) -> Student? in
            return try Student.filter(Column(Columns.name.rawValue) == name).fetchOne(db)
        })
    }
    
    /// 查询所有
    static func queryAll() -> [Student] {
        // 创建数据库
        self.createTable()
        // 返回查询结果
        return try! self.dbQueue.unsafeRead({ (db) -> [Student] in
            return try Student.fetchAll(db)
        })
    }
    
    //MARK: 更新
    /// 更新
    static func update(student: Student) -> Void {
        /// 创建数据库表
        self.createTable()
        // 事务 更新场景
        try! self.dbQueue.inTransaction { (db) -> Database.TransactionCompletion in
            do {
                // 赋值
                try student.update(db)
                return Database.TransactionCompletion.commit
            } catch {
                return Database.TransactionCompletion.rollback
            }
        }
    }
    
    //MARK: 删除
    /// 根据名字删除学生
    static func delete(name: String) -> Void {
        // 查询
        guard let student = self.query(name: name) else {
            return
        }
        // 删除
        self.delete(student: student)
    }
    
    /// 删除单个学生
    static func delete(student: Student) -> Void {
        // 是否有数据库表
        self.createTable()
        // 事务
        try! self.dbQueue.inTransaction { (db) -> Database.TransactionCompletion in
            do {
                // 删除数据
                try student.delete(db)
                return Database.TransactionCompletion.commit
            } catch {
                return Database.TransactionCompletion.rollback
            }
        }
    }
}
```

GRBD数据库操作:
```swift
    // 插入数据
    let stu = Student(name: "张三", nick_name: "哈皮", age: 30, gender: true)
    Student.insert(student: stu)

    // 查询数据
    debugPrint("查询所有数据:", Student.queryAll())
```

####参考
[groue/GRDB.swift](https://github.com/groue/GRDB.swift#dealing-with-external-connections)  

 http://swift-salaryman.com/grdb.php
 
 Swift SQLite ORM 框架 - GRDB.swift 使用
 https://blog.csdn.net/a794561799/article/details/94492714#_334
 
 GRDB.swift as a Solution for iOS Database
 https://www.netguru.com/codestories/grdb.swift-as-a-solution-for-ios-database
 
 Swift - 第三方SQLite库FMDB使用详解4（实体类与数据库表的关联映射）
 https://www.hangge.com/blog/cache/detail_2318.html
 
