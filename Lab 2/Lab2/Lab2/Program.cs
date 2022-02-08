using Lab2.DB;
using Lab2.Models;
using System;
using System.Collections.Generic;

namespace Lab2
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                using (UnitOfWork unit = new UnitOfWork())
                {
                    Order order = unit.OrderRepository.Get(1);

                    unit.OrderRepository.PrintTableHeader();
                    unit.OrderRepository.PrintRow(order);

                    List<Order> orders = unit.OrderRepository.GetAll();
                    unit.OrderRepository.PrintTableHeader();
                    foreach (Order x in orders)
                    {
                        unit.OrderRepository.PrintRow(x);
                    }

                    unit.OrderRepository.Insert(new Order("СильверТур", 8, 100, new DateTime(2019, 1, 1, 13, 00, 00), new DateTime(2019, 1, 3, 13, 50, 00)));

                    orders = unit.OrderRepository.GetAll();
                    unit.OrderRepository.PrintTableHeader();
                    foreach (Order x in orders)
                    {
                        unit.OrderRepository.PrintRow(x);
                    }

                    if (order != null)
                    {
                        order.ServiceId = 10;
                        unit.OrderRepository.Update(order);
                        order = unit.OrderRepository.Get(1);
                        unit.OrderRepository.PrintTableHeader();
                        unit.OrderRepository.PrintRow(order);
                    }

                    unit.OrderRepository.Delete(1007);

                    orders = unit.OrderRepository.GetAll();
                    unit.OrderRepository.PrintTableHeader();
                    foreach (Order x in orders)
                    {
                        unit.OrderRepository.PrintRow(x);
                    }
                    unit.OrderRepository.Execute("SELECT A.ID,A.CustomerName,B.ServiceType,A.UnitsAmount,B.CostPerUnit, A.OrderDate,A.OrderExec FROM [ORDER] A INNER JOIN SERVICE B ON A.SERVICEID = B.ID ORDER BY B.ServiceType");

                }
            }
            catch(Exception ex)
            {
                Console.WriteLine("Ошибка: " + ex.Message);
            }
        }
    }
}
