#include <iostream>
#include <sql.h>
#include <sqlext.h>

void printErrorMessage(SQLHANDLE handle, SQLSMALLINT handleType) {
    SQLCHAR sqlstate[6];
    SQLCHAR errmsg[SQL_MAX_MESSAGE_LENGTH];
    SQLINTEGER nativeerr;
    SQLSMALLINT length;
    while (SQLGetDiagRec(handleType, handle, 1, sqlstate, &nativeerr, errmsg, SQL_MAX_MESSAGE_LENGTH, &length) != SQL_NO_DATA) {
        std::cerr << "SQLSTATE: " << sqlstate << " Native Error: " << nativeerr << " Message: " << errmsg << std::endl;
    }
}

void executeQuery(SQLHDBC hdbc, const std::string& query) {
    SQLHSTMT hstmt;
    SQLRETURN ret;
    ret = SQLAllocHandle(SQL_HANDLE_STMT, hdbc, &hstmt);
    ret = SQLExecDirect(hstmt, (SQLCHAR *)query.c_str(), SQL_NTS);
    if (ret != SQL_SUCCESS && ret != SQL_SUCCESS_WITH_INFO) {
        std::cerr << "Error executing query: " << query << std::endl;
        printErrorMessage(hstmt, SQL_HANDLE_STMT);
    } else {
        std::cout << "Query executed successfully: " << query << std::endl;
    }
    SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
}

int main() {

    SQLHENV henv; 
    SQLHDBC hdbc; 
    SQLRETURN ret;

    ret = SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &henv);
    ret = SQLSetEnvAttr(henv, SQL_ATTR_ODBC_VERSION, (SQLPOINTER)SQL_OV_ODBC3, 0);

    ret = SQLAllocHandle(SQL_HANDLE_DBC, henv, &hdbc);

    ret = SQLDriverConnect(hdbc, NULL, (SQLCHAR *)"DRIVER={PostgreSQL ANSI};Servername=localhost;Port=5432;Database=hospital_network;Username=hospital;Password=123;", SQL_NTS, NULL, 0, NULL, SQL_DRIVER_COMPLETE);

    if (ret != SQL_SUCCESS && ret != SQL_SUCCESS_WITH_INFO) {
        printErrorMessage(hdbc, SQL_HANDLE_DBC);
        return 1;
    }

    executeQuery(hdbc, "SELECT * FROM Doctor");

    executeQuery(hdbc, "INSERT INTO Doctor (doctor_id, department_id, doctor_name, phone_number, start_working, end_working) VALUES (206, 102, 'Dr. Parker', '5553333', '08:00:00', '16:00:00')");

    executeQuery(hdbc, "UPDATE Doctor SET doctor_name = 'Dr. Parker, MD' WHERE doctor_id = 206");

    executeQuery(hdbc, "DELETE FROM Doctor WHERE doctor_id = 205");

    SQLDisconnect(hdbc);
    SQLFreeHandle(SQL_HANDLE_DBC, hdbc);
    SQLFreeHandle(SQL_HANDLE_ENV, henv);

    return 0;
}




