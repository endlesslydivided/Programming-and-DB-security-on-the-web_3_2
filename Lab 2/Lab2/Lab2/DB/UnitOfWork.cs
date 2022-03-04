using Lab2.DB.Impl;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lab2.DB
{
    class UnitOfWork : IDisposable
    {
        private SqlConnection connection = new SqlConnection(@"Server=localhost;Database=TRANS;Trusted_Connection=True;");     
        

        private OrderRepository orderRepository;
        private CityRepository cityRepository;
        private CustomerRepository customerRepository;
        private RouteRepository routeRepository;
        private ServiceRepository serviceRepository;
        private ServiceTypeRepository serviceTypeRepository;


        public OrderRepository OrderRepository
        {
            get
            {
                if (orderRepository == null)
                    orderRepository = new OrderRepository(connection);
                return orderRepository;
            }
        }

        public CityRepository CityRepository
        {
            get
            {
                if (cityRepository == null)
                    cityRepository = new CityRepository(connection);
                return cityRepository;
            }
        }

        public CustomerRepository CustomerRepository
        {
            get
            {
                if (customerRepository == null)
                    customerRepository = new CustomerRepository(connection);
                return customerRepository;
            }
        }

        public RouteRepository RouteRepository
        {
            get
            {
                if (routeRepository == null)
                    routeRepository = new RouteRepository(connection);
                return routeRepository;
            }
        }

        public ServiceRepository ServiceRepository
        {
            get
            {
                if (serviceRepository == null)
                    serviceRepository = new ServiceRepository(connection);
                return serviceRepository;
            }
        }

        public ServiceTypeRepository ServiceTypeRepository
        {
            get
            {
                if (serviceTypeRepository == null)
                    serviceTypeRepository = new ServiceTypeRepository(connection);
                return serviceTypeRepository;
            }
        }

        private bool disposed = false;

        public virtual void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    connection.Close();
                }
                this.disposed = true;
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
