CREATE USER C##migration IDENTIFIED BY migration 
DEFAULT TABLESPACE USERS QUOTA unlimited ON USERS;
drop user migration cascade;
GRANT CONNECT,RESOURCE,CREATE SESSION, CREATE VIEW TO C##migration;


select * from route;
select * from service;
select * from city;
select * from customer;
select * from servicetype;
select * from order_;
SELECT * FROM Order_ where Id = 4;

select max(id) from order_;

execute TCustomer;







