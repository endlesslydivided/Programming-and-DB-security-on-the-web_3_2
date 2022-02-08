using Lab2.Models;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lab2.DB.Interfaces
{
    interface IServiceRepository
    {
        Service Get(int id);
        SqlDataReader GetAll();
        void Delete(int id);
        void Update(Service service);
        int Insert(Service service);

    }
}
