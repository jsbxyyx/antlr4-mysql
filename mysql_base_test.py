#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# @author jsbxyyx
# @since 1.0
from mysql_base import MySqlBase, MysqlStatementVisitor, MysqlOutputVisitor

if __name__ == '__main__':
    sql = """
    select * from test where name = ? and id = ?;
    select * from test where name = ? and id = ? order by t.id asc, t.name desc limit 10, 0 for update;
    insert into test(id, name) values(?,?), (?,?), (?, 1), (?, '1'), (?, 1.1);
    update test t set t.id = ?, name = ? where t.id in (?,?) and t.like like '%1%';
    update test t set t.id = ?, name = ? where t.id in (?,?) and t.like like '%1%' order by t.id, t.name desc limit 1;
    delete t from test t where t.id = ? and t.name in (?,?);
    delete t from test t where t.id between 10 and 30 and t.name = '';
    delete t from test t where t.id between 10 and 30 and t.name = '' order by t1.name desc limit 1;
    delete t from test t where t.name = 0x1 and t.name = x'11' and t.name = b'1' order by t1.name desc limit 1;
    """
    parser = MySqlBase.parser(sql)
    ss = parser.sqlStatements().sqlStatement()

    idx = 0
    s = MysqlStatementVisitor().visit(ss[idx].dmlStatement().selectStatement())
    print('*' * 100)
    output = list()
    MysqlOutputVisitor().visitSelectStatement(s, output)
    string = ' '.join(output)
    print(string)

    idx += 1
    s = MysqlStatementVisitor().visit(ss[idx].dmlStatement().selectStatement())
    print('*' * 100)
    output = list()
    MysqlOutputVisitor().visitSelectStatement(s, output)
    string = ' '.join(output)
    print(string)

    idx += 1
    i = MysqlStatementVisitor().visit(ss[idx].dmlStatement().insertStatement())
    print('*' * 100)
    output = list()
    MysqlOutputVisitor().visitInsertStatement(i, output)
    string = ' '.join(output)
    print(string)

    idx += 1
    u = MysqlStatementVisitor().visit(ss[idx].dmlStatement().updateStatement())
    print('*' * 100)
    output = list()
    MysqlOutputVisitor().visitUpdateStatement(u, output)
    string = ' '.join(output)
    print(string)

    idx += 1
    u = MysqlStatementVisitor().visit(ss[idx].dmlStatement().updateStatement())
    print('*' * 100)
    output = list()
    MysqlOutputVisitor().visitUpdateStatement(u, output)
    string = ' '.join(output)
    print(string)

    idx += 1
    d = MysqlStatementVisitor().visit(ss[idx].dmlStatement().deleteStatement())
    print('*' * 100)
    output = list()
    MysqlOutputVisitor().visitDeleteStatement(d, output)
    string = ' '.join(output)
    print(string)

    idx += 1
    d = MysqlStatementVisitor().visit(ss[idx].dmlStatement().deleteStatement())
    print('*' * 100)
    output = list()
    MysqlOutputVisitor().visitDeleteStatement(d, output)
    string = ' '.join(output)
    print(string)

    idx += 1
    d = MysqlStatementVisitor().visit(ss[idx].dmlStatement().deleteStatement())
    print('*' * 100)
    output = list()
    MysqlOutputVisitor().visitDeleteStatement(d, output)
    string = ' '.join(output)
    print(string)

    idx += 1
    d = MysqlStatementVisitor().visit(ss[idx].dmlStatement().deleteStatement())
    print('*' * 100)
    output = list()
    MysqlOutputVisitor().visitDeleteStatement(d, output)
    string = ' '.join(output)
    print(string)
    print('*' * 100)

    print()
