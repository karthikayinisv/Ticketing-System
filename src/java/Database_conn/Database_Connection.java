package Database_conn;




import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database_Connection {

    // Corrected JDBC URL with SQL Server connection format


    private static String url = "jdbc:sqlserver://172.17.50.27:1433;databaseName=project_management";
    private static String username = "sa";
    private static String password = "Sql123";
    private static Connection conn = null;

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        if (conn == null || conn.isClosed()) {
            try {
                // Load the SQL Server JDBC Driver
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

                // Establish the connection
                conn = DriverManager.getConnection(url, username, password);
            } catch (SQLException | ClassNotFoundException e) {
                throw new SQLException("Connection error: " + e.getMessage());
            }
        }
        return conn;
    }
}
