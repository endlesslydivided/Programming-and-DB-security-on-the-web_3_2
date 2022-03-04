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
                while(true)
                {
                    Console.Clear();
                    int p = 0;
                    Console.WriteLine("Выберите пункт меню:");
                    Console.WriteLine("1 - CRUD");
                    Console.WriteLine("2 - пространственные данные");
                    Console.WriteLine("3 - выход");
                    if (!int.TryParse(Console.ReadLine(), out p))
                    {
                        Console.WriteLine("Неверный ввод");
                        Console.ReadKey();
                    }
                    switch (p)
                    {
                        case 1:
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

                                    unit.OrderRepository.Insert(new Order("Бабушкина крынка", 8, 100, new DateTime(2019, 1, 1, 13, 00, 00), new DateTime(2019, 1, 3, 13, 50, 00)));

                                    orders = unit.OrderRepository.GetAll();
                                    unit.OrderRepository.PrintTableHeader();
                                    foreach (Order x in orders)
                                    {
                                        unit.OrderRepository.PrintRow(x);
                                    }

                                    if (order != null)
                                    {
                                        order.ServiceId = 15;
                                        unit.OrderRepository.Update(order);
                                        order = unit.OrderRepository.Get(1);
                                        unit.OrderRepository.PrintTableHeader();
                                        unit.OrderRepository.PrintRow(order);
                                    }

                                    unit.OrderRepository.Delete(109);

                                    orders = unit.OrderRepository.GetAll();
                                    unit.OrderRepository.PrintTableHeader();
                                    foreach (Order x in orders)
                                    {
                                        unit.OrderRepository.PrintRow(x);
                                    }
                                    unit.OrderRepository.Execute("SELECT A.ID,A.CustomerName,B.ServiceType,A.UnitsAmount,B.CostPerUnit, A.OrderDate,A.OrderExec FROM [ORDER] A INNER JOIN SERVICE B ON A.SERVICEID = B.ID WHERE A.OrderDate BETWEEN '01/01/2019' AND '05/01/2019'  ORDER BY B.ServiceType");

                                    Console.ReadKey();
                                    break;
                                }
                            }
                        case 2:
                            {
                                using (UnitOfWork unit = new UnitOfWork())
                                {
                                    Console.OutputEncoding = System.Text.Encoding.UTF8;
                                    Console.WriteLine("\n▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬");
                                    unit.CityRepository.getDistance(1,2);
                                    Console.WriteLine("\n▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬");
                                    unit.CityRepository.findNearest(42, 45);
                                    Console.WriteLine("\n▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬");
                                    unit.CityRepository.getIntersect(1,2,3,4);
                                    Console.WriteLine("\n▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬");


                                }
                                Console.ReadKey();
                                break;
                            }
                        case 3:
                            {
                                return;
                            }
                        default:
                            {
                                break;
                            }
                    }
                }
                
            }
            catch(Exception ex)
            {
                Console.WriteLine("Ошибка: " + ex.Message);
            }
        }
    }
}
