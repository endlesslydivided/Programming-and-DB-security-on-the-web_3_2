using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml.Serialization;
using Microsoft.SqlServer.Server;


[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedType(Format.Native,
     IsByteOrdered = true, ValidationMethodName = "ValidateRoute")]
public struct RouteType: INullable
{
    
    private SqlDouble _distance;

    private bool _null;

    public RouteType(SqlDouble distance)
    {
        _distance = distance;
        _null = false;
    }

    public bool IsNull
    {
        get
        {
            return _null;
        }
    }

    public override string ToString()
    {
        if (this._null)
            return "NULL";
        else
        {
            StringBuilder builder = new StringBuilder();
            
            builder.Append(_distance);
            builder.Append(" km");
            return builder.ToString();
        }
    }
    
    public static RouteType Null
    {
        get
        {
            RouteType h = new RouteType();
            h._null = true;
            return h;
        }
    }

    public static RouteType Parse(SqlString s)
    {
        if (s.IsNull)
            return Null;
        RouteType u = new RouteType();
        string[] route = s.Value.Split(",".ToCharArray());
        if (Regex.IsMatch(route[0], @"^\d+\,\d+$"))
        {
            u._distance = SqlDouble.Parse(route[0]);
        }
        else
        {
            throw new ArgumentException("Invalid type values!");
        }
        return u;
    }

    public SqlDouble Distance
    {
        get { return _distance; }
        set
        {
            SqlDouble temp = _distance;
            _distance = value;
            if (ValidateRoute())
            {
                _distance = temp;
                throw new ArgumentException("Invalid _distance value");
            }
        }
    }

    private bool ValidateRoute()
    {
        if (_distance.Value > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }


}