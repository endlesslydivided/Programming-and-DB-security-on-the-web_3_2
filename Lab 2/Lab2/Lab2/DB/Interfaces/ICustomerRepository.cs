﻿using Lab2.Models;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lab2.DB.Interfaces
{
    interface ICustomerRepository
    {
        Customer Get(int id);
        SqlDataReader GetAll();
        void Delete(int id);
        void Update(Customer customer);
        int Insert(Customer customer);

    }
}
