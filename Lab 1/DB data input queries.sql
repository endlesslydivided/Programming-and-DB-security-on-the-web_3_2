use TRANS;

INSERT into City values
('�����'),('�������'),('�����'),('�������'),('������'),
('������'),('������'),('�������'),('�������'),
('��������'),('����');

INSERT into ServiceType values 
('��������� �����','�������'),
('��������� �����������','���������'),
('��������� ���������','���������'),
('��������� ��������� ������� ��������������','����'),
('��������� ��������� ���������� ��������������','����');

INSERT into Route values
('�����-��������-�������','212','�����','�������'),
('�����-����-�������','294','�����','�������'),
('�������-�����','246','�������','�����'),
('�����-������','213','�����','������'),
('������-�����','213','������','�����'),
('�����-������','246','�����','������'),
('������-�����','246','������','�����'),
('�����-�����','234','�����','�����'),
('�����-�����','234','�����','�����'),
('�����-������','586','�����','������'),
('�����-�������','601','�����','�������'),
('�����-��������','496','�����','��������'),
('�����-����','563','�����','����');

INSERT into Service values
('��������� �����','�����-��������-�������','5'),
('��������� �����','�����-����-�������','4'),
('��������� �����','�����-�������','10'),
('��������� �����','�����-��������','8'),
('��������� �����','�����-����','9'),
('��������� �����','�������-�����','3'),

('��������� ��������� ���������� ��������������','�����-������','15'),
('��������� ��������� ������� ��������������','�����-������','12'),
('��������� ���������','�����-������','10'),
('��������� �����������','�����-������','25'),

('��������� ��������� ���������� ��������������','�����-�����','16'),
('��������� ��������� ������� ��������������','�����-�����','13'),
('��������� ���������','�����-�����','11'),
('��������� �����������','�����-�����','26'),

('��������� ��������� ���������� ��������������','�����-������','15'),
('��������� ��������� ������� ��������������','�����-������','12'),
('��������� ���������','�����-������','10'),
('��������� �����������','�����-������','25');

INSERT into Customer values
('������'),('�����������'),('��������'),('����������'),('������'),('��������� ������');

