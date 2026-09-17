| Category | Meaning                      | Main commands                         |
| -------- | ---------------------------- | ------------------------------------- |
| **DDL**  | Data Definition Language     | `CREATE`, `ALTER`, `DROP`             |
| **DML**  | Data Manipulation Language   | `INSERT`, `UPDATE`, `DELETE`, `MERGE` |
| **DQL**  | Data Query Language          | `SELECT`                              |
| **DCL**  | Data Control Language        | `GRANT`, `REVOKE`                     |
| **TCL**  | Transaction Control Language | `BEGIN`, `COMMIT`, `ROLLBACK`         |


sql/
├── ddl/
│   ├── tables/
│   ├── streams/
│   ├── tasks/
│   │   ├── create_tasks.sql
│   │   └── alter_tasks.sql
│   ├── alerts/
│   └── dynamic_tables/
├── dml/
├── dql/
├── dcl/
├── ops/
│   └── tasks/
│       ├── resume_tasks.sql
│       ├── suspend_tasks.sql
│       └── execute_tasks.sql
└── dags/

