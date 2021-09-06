parser grammar MySqlBaseParser;

options { tokenVocab=MySqlBaseLexer; }

root
    : sqlStatements? MINUSMINUS? EOF
    ;

sqlStatements
    : (sqlStatement MINUSMINUS? SEMI? | emptyStatement)*
    (sqlStatement (MINUSMINUS? SEMI)? | emptyStatement)
    ;

sqlStatement
    : dmlStatement
    ;

emptyStatement
    : SEMI
    ;

dmlStatement
    : selectStatement | insertStatement | updateStatement
    | deleteStatement
    ;

selectStatement
    : SELECT selectElements FROM tableSource (whereClause)? (orderByClause)? (limitClause)? (lockClause)?
    ;

insertStatement
    : INSERT IGNORE? INTO tableSource (LR_BRACKET uidList RR_BRACKET)? (VALUE|VALUES) insertStatementValue
    ;

updateStatement
    : UPDATE IGNORE? tableSource SET updatedElement (',' updatedElement)* (whereClause)? (orderByClause)? (limitClause)?
    ;

deleteStatement
    : DELETE IGNORE? tableAlias? FROM tableSource (whereClause)? (orderByClause)? (LIMIT decimalLiteral)?
    ;

insertStatementValue
    : (LR_BRACKET expressions RR_BRACKET) (COMMA LR_BRACKET expressions RR_BRACKET)*
    ;

selectElements
    : (star='*' | selectElement ) (COMMA selectElement)*
    ;

selectElement
    : fullId DOT STAR                   # selectStarElement
    | fullColumnName (AS? uid)?         # selectColumnElement
    ;

tableSource
    : tableName (AS? tableAlias)?
    ;

tableName
    : fullId
    ;

tableAlias
    : uid
    ;

fullId
    : uid (DOT uid)?
    ;

//fullColumnName
//    : uid (DOT uid)?
//    ;

fullColumnName
    : uid (dottedId dottedId? )?
    | . dottedId dottedId?
    ;

dottedId
    : DOT_ID
    | '.' uid
    ;

uidList
    : uid (COMMA uid)*
    ;

uid
    : ID
    | keywordsCanBeId
    | stringLiteral
    ;

updatedElement
    : fullColumnName '=' (expression | DEFAULT)
    ;

whereClause
    : WHERE expression
    ;

expressions
    : expression (',' expression)*
    ;

expression
    : predicate NOT? IN LR_BRACKET (expressions) RR_BRACKET         # inPredicate
    | predicate comparisonOperator predicate                        # comparisonPredicate
    | predicate IS NOT? NULL                                        # nullPredicate
    | predicate NOT? BETWEEN predicate AND predicate                # betweenPredicate
    | predicate NOT? LIKE predicate                                 # likePredicate
    | NOT expression                                                # notExpression
    | expression logicalOperator expression                         # logicalExpression
    | predicate                                                     # expressionAtomPredicate
    ;

predicate
    : fullColumnName
    | constant
    ;

comparisonOperator
    : '=' | '>' | '<' | '<' '=' | '>' '='
    | '<' '>' | '!' '=' | '<' '=' '>'
    ;

logicalOperator
    : AND | '&' '&' | XOR | OR | '|' '|'
    ;

keywordsCanBeId
    : ACCOUNT | ACTION | AFTER | AGGREGATE | ALGORITHM | ANY
    | AT | AUDIT_ADMIN | AUTHORS | AUTOCOMMIT | AUTOEXTEND_SIZE
    | AUTO_INCREMENT | AVG | AVG_ROW_LENGTH | BACKUP_ADMIN | BEGIN | BINLOG | BINLOG_ADMIN | BINLOG_ENCRYPTION_ADMIN | BIT | BIT_AND | BIT_OR | BIT_XOR
    | BLOCK | BOOL | BOOLEAN | BTREE | CACHE | CASCADED | CHAIN | CHANGED
    | CHANNEL | CHECKSUM | PAGE_CHECKSUM | CATALOG_NAME | CIPHER
    | CLASS_ORIGIN | CLIENT | CLONE_ADMIN | CLOSE | COALESCE | CODE
    | COLUMNS | COLUMN_FORMAT | COLUMN_NAME | COMMENT | COMMIT | COMPACT
    | COMPLETION | COMPRESSED | COMPRESSION | CONCURRENT | CONNECT
    | CONNECTION | CONNECTION_ADMIN | CONSISTENT | CONSTRAINT_CATALOG | CONSTRAINT_NAME
    | CONSTRAINT_SCHEMA | CONTAINS | CONTEXT
    | CONTRIBUTORS | COPY | COUNT | CPU | CURRENT | CURSOR_NAME
    | DATA | DATAFILE | DEALLOCATE
    | DEFAULT_AUTH | DEFINER | DELAY_KEY_WRITE | DES_KEY_FILE | DIAGNOSTICS | DIRECTORY
    | DISABLE | DISCARD | DISK | DO | DUMPFILE | DUPLICATE
    | DYNAMIC | ENABLE | ENCRYPTION | ENCRYPTION_KEY_ADMIN | END | ENDS | ENGINE | ENGINES
    | ERROR | ERRORS | ESCAPE | EVEN | EVENT | EVENTS | EVERY
    | EXCHANGE | EXCLUSIVE | EXPIRE | EXPORT | EXTENDED | EXTENT_SIZE | FAST | FAULTS
    | FIELDS | FILE_BLOCK_SIZE | FILTER | FIREWALL_ADMIN | FIREWALL_USER | FIRST | FIXED | FLUSH
    | FOLLOWS | FOUND | FULL | FUNCTION | GENERAL | GLOBAL | GRANTS | GROUP | GROUP_CONCAT
    | GROUP_REPLICATION | GROUP_REPLICATION_ADMIN | HANDLER | HASH | HELP | HOST | HOSTS | IDENTIFIED
    | IGNORE_SERVER_IDS | IMPORT | INDEXES | INITIAL_SIZE | INNODB_REDO_LOG_ARCHIVE
    | INPLACE | INSERT_METHOD | INSTALL | INSTANCE | INTERNAL | INVOKER | IO
    | IO_THREAD | IPC | ISOLATION | ISSUER | JSON | KEY_BLOCK_SIZE
    | LANGUAGE | LAST | LEAVES | LESS | LEVEL | LIST | LOCAL
    | LOGFILE | LOGS | MASTER | MASTER_AUTO_POSITION
    | MASTER_CONNECT_RETRY | MASTER_DELAY
    | MASTER_HEARTBEAT_PERIOD | MASTER_HOST | MASTER_LOG_FILE
    | MASTER_LOG_POS | MASTER_PASSWORD | MASTER_PORT
    | MASTER_RETRY_COUNT | MASTER_SSL | MASTER_SSL_CA
    | MASTER_SSL_CAPATH | MASTER_SSL_CERT | MASTER_SSL_CIPHER
    | MASTER_SSL_CRL | MASTER_SSL_CRLPATH | MASTER_SSL_KEY
    | MASTER_TLS_VERSION | MASTER_USER
    | MAX_CONNECTIONS_PER_HOUR | MAX_QUERIES_PER_HOUR
    | MAX | MAX_ROWS | MAX_SIZE | MAX_UPDATES_PER_HOUR
    | MAX_USER_CONNECTIONS | MEDIUM | MEMBER | MEMORY | MERGE | MESSAGE_TEXT
    | MID | MIGRATE
    | MIN | MIN_ROWS | MODE | MODIFY | MUTEX | MYSQL | MYSQL_ERRNO | NAME | NAMES
    | NCHAR | NDB_STORED_USER | NEVER | NEXT | NO | NODEGROUP | NONE | NUMBER | OFFLINE | ODBC | OFFSET
    | OF | OJ | OLD_PASSWORD | ONE | ONLINE | ONLY | OPEN | OPTIMIZER_COSTS
    | OPTIONAL | OPTIONS | ORDER | OWNER | PACK_KEYS | PAGE | PARSER | PARTIAL
    | PARTITIONING | PARTITIONS | PASSWORD | PERSIST_RO_VARIABLES_ADMIN | PHASE | PLUGINS
    | PLUGIN_DIR | PLUGIN | PORT | PRECEDES | PREPARE | PRESERVE | PREV
    | PROCESSLIST | PROFILE | PROFILES | PROXY | QUERY | QUICK
    | REBUILD | RECOVER | REDO_BUFFER_SIZE | REDUNDANT
    | RELAY | RELAYLOG | RELAY_LOG_FILE | RELAY_LOG_POS | REMOVE
    | REORGANIZE | REPAIR | REPLICATE_DO_DB | REPLICATE_DO_TABLE
    | REPLICATE_IGNORE_DB | REPLICATE_IGNORE_TABLE
    | REPLICATE_REWRITE_DB | REPLICATE_WILD_DO_TABLE
    | REPLICATE_WILD_IGNORE_TABLE | REPLICATION | REPLICATION_APPLIER | REPLICATION_SLAVE_ADMIN | RESET
    | RESOURCE_GROUP_ADMIN | RESOURCE_GROUP_USER | RESUME
    | RETURNED_SQLSTATE | RETURNS | ROLE | ROLE_ADMIN | ROLLBACK | ROLLUP | ROTATE | ROW | ROWS
    | ROW_FORMAT | SAVEPOINT | SCHEDULE | SCHEMA_NAME | SECURITY | SERIAL | SERVER
    | SESSION | SESSION_VARIABLES_ADMIN | SET_USER_ID | SHARE | SHARED | SHOW_ROUTINE | SIGNED | SIMPLE | SLAVE
    | SLOW | SNAPSHOT | SOCKET | SOME | SONAME | SOUNDS | SOURCE
    | SQL_AFTER_GTIDS | SQL_AFTER_MTS_GAPS | SQL_BEFORE_GTIDS
    | SQL_BUFFER_RESULT | SQL_CACHE | SQL_NO_CACHE | SQL_THREAD
    | STACKED | START | STARTS | STATS_AUTO_RECALC | STATS_PERSISTENT
    | STATS_SAMPLE_PAGES | STATUS | STD | STDDEV | STDDEV_POP | STDDEV_SAMP | STOP | STORAGE | STRING
    | SUBCLASS_ORIGIN | SUBJECT | SUBPARTITION | SUBPARTITIONS | SUM | SUSPEND | SWAPS
    | SWITCHES | SYSTEM_VARIABLES_ADMIN | TABLE_NAME | TABLESPACE | TABLE_ENCRYPTION_ADMIN
    | TEMPORARY | TEMPTABLE | THAN | TRADITIONAL
    | TRANSACTION | TRANSACTIONAL | TRIGGERS | TRUNCATE | UNDEFINED | UNDOFILE
    | UNDO_BUFFER_SIZE | UNINSTALL | UNKNOWN | UNTIL | UPGRADE | USER | USE_FRM | USER_RESOURCES
    | VALIDATION | VALUE | VAR_POP | VAR_SAMP | VARIABLES | VARIANCE | VERSION_TOKEN_ADMIN | VIEW | WAIT | WARNINGS | WITHOUT
    | WORK | WRAPPER | X509 | XA | XA_RECOVER_ADMIN | XML
    ;

constant
    : parameterMarker
    | stringLiteral
    | decimalLiteral
    | '-' decimalLiteral
    | hexadecimalLiteral
    | booleanLiteral
    | realLiteral
    | bitString
    ;

realLiteral
    : REAL_LITERAL
    ;

bitString
    : BIT_STRING
    ;

booleanLiteral
    : TRUE
    | FALSE
    ;

stringLiteral
    : STRING_LITERAL
    ;

decimalLiteral
    : DECIMAL_LITERAL | ZERO_DECIMAL | ONE_DECIMAL | TWO_DECIMAL
    ;

hexadecimalLiteral
    : HEXADECIMAL_LITERAL
    ;

orderByClause
    : ORDER BY orderByExpression (',' orderByExpression)*
    ;

orderByExpression
    : expression order=(ASC | DESC)?
    ;

limitClause
    : LIMIT (decimalLiteral? COMMA)? decimalLiteral
    ;

lockClause
    : FOR UPDATE | LOCK IN SHARE MODE
    ;

parameterMarker
	: QUESTION_
	| PERCENT_S_
	;

