using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class StoredProcedures
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void ProcedureDateTime (SqlDateTime StartDate, SqlDateTime EndDate)
    {
        SqlCommand command = new SqlCommand();
        command.Connection = new SqlConnection("Context connection = true");
        command.Connection.Open();

        string sql_string = "SELECT B.RouteName 'Название маршрута', COUNT(A.RouteName) 'Количество поездок' FROM (" +
                            "(SELECT RouteName  from[Order] inner join Service on ServiceId = Service.Id  where [Order].OrderDate between @StartDate and @EndDate) as A right outer join" +
                            "(SELECT RouteName from Route) as B on A.RouteName = B.RouteName) Group By B.RouteName; ";
        command.CommandText = sql_string.ToString();

        SqlParameter param = command.Parameters.Add("@StartDate", SqlDbType.DateTime);
        param.Value = StartDate;
        param = command.Parameters.Add("@EndDate", SqlDbType.DateTime);
        param.Value = EndDate;
        SqlContext.Pipe.ExecuteAndSend(command);
        command.Connection.Close();


    }
}
