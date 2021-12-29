

INSERT into Customer VALUES('Andrew', '2657 classen blvd', 1);
INSERT into Customer VALUES('Tony', '1000 E lindsey st', 5);


/*Query - 1*/
INSERT into Customer VALUES('Strange', '1125 E lindsey st', 10);
/*Query-1*/

select * from Customer;

INSERT INTO Department VALUES(1, 'Development');
INSERT INTO Department VALUES(2, 'Machinery');

/*Query - 2*/
INSERT INTO Department VALUES(3, 'Testing');
/*Query-2*/

SELECT * FROM Department;

INSERT INTO Process VALUES(10,'Cut');
INSERT INTO Process VALUES(13,'Paint');

INSERT INTO Supervises VALUES(13,2);
INSERT INTO Supervises VALUES(10,1);

INSERT INTO Paint VALUES(13, 'Paint completed', 'Eggshell', 'Impesto');
INSERT INTO Cut VALUES(10, 'Cut Completed', 'Plain', 'Large');

/*Query-3*/
INSERT INTO Process VALUES(25,'Fit');
INSERT INTO Supervises VALUES(25,3);
INSERT INTO Fit VALUES(25, 'Fit completed', 'Streamline');
/*Query-3*/ 

SELECT * from Process;
SELECT * FROM Supervises;
SELECT * FROM Fit;

INSERT INTO Assembl VALUES(150, '2021-11-1', 'Motor', 'Andrew');
INSERT INTO Assembl VALUES(213, '2021-11-10', 'Driver', 'Strange');

INSERT INTO Manufactured_by VALUES(150, 10);
INSERT INTO Manufactured_by VALUES(213, 25);

/*Query-4*/
INSERT INTO Assembl VALUES(200, '2021-11-15', 'Screws', 'Tony');
INSERT INTO Manufactured_by VALUES(200, 13);
/*Query-4*/

SELECT * FROM Assembl;
SELECT * FROM Manufactured_by;

/*Query- 6&7*/
INSERT INTO Job VALUES(1, '2021-11-02', '2021-11-04','Job on motor', 150, 10);
INSERT INTO Job VALUES(2, '2021-11-11', '2021-11-12','Job on Driver', 213, 25);
INSERT INTO Job VALUES(3, '2021-11-16', '2021-11-17','Job on Screws', 200, 13);

INSERT INTO Cut_Job VALUES(1, '2021-11-02', '2021-11-04','Job on motor', 150, 10,'Large', '00:30:00', 'Steel','2:00:00');
INSERT INTO Paint_Job VALUES(3, '2021-11-16', '2021-11-17','Job on Screws', 200, 13,'blue',1, '00:30:00');
INSERT INTO Fit_Job VALUES(2, '2021-11-11', '2021-11-12','Job on Driver', 213, 25,'00:25:00');
/*Query- 6&7*/

select * FROM Job;
SELECT * FROM Cut_Job;
SELECT * FROM Paint_Job;
SELECT * FROM Fit_Job;

/*Query-8*/
INSERT INTO Transac VALUES(1000, 500, 1);
INSERT INTO Transac VALUES(2000, 300, 2);
INSERT INTO Transac VALUES(3000, 400, 3);
/*Query-8*/

SELECT * FROM Transac;

/*Query-5*/
INSERT INTO Assembly_account VALUES(123456789, '2020-10-10', 6000, 1000);
INSERT INTO Department_account VALUES(234567891, '2019-9-10', 3000, 2000);
INSERT INTO Process_account VALUES(345678912, '2018-10-10', 5000, 3000);

INSERT INTO Maintained_for VALUES(123456789, 10, NULL, NULL);
INSERT INTO Maintained_for VALUES(345678912, NULL, 3, NULL);
INSERT INTO Maintained_for VALUES(234567891, NULL, NULL, 213);
/*Query-5*/

SELECT * from Assembly_account;
SELECT * FROM Department_account;
SELECT * FROM Process_account;
SELECT * FROM Maintained_for;

/*Query-8*/
UPDATE Assembly_account SET Details_1= Details_1+T2.sup_cost FROM Assembly_account as T1 JOIN Transac as T2 ON T1.Transaction_no = T2.Transaction_no;
UPDATE Department_account SET Details_2= Details_2+T2.sup_cost FROM Department_account as T1 JOIN Transac as T2 ON T1.Transaction_no = T2.Transaction_no;
UPDATE Process_account SET Details_2= Details_2+T2.sup_cost FROM Process_account as T1 JOIN Transac as T2 ON T1.Transaction_no = T2.Transaction_no;
/*Query-8*/

SELECT * from Assembly_account;
SELECT * FROM Department_account;
SELECT * FROM Process_account;

/*Query-9*/
SELECT T1.Details_1 from Assembly_account as T1 JOIN Maintained_for as T2 on T1.Account_no = T2.Account_no where T2.Assembly_id = 100;
/*Query-9*/


/*Query-11*/
select T5.Process_data, T4.Department_data FROM Manufactured_by as T1 JOIN Assembl as T2 ON T1.Assembly_id = T2.Assembly_id
JOIN Supervises as T3 ON T1.Process_id = T3.Process_id 
JOIN Department as T4 ON T3.Department_no = T4.Department_no
JOIN Process as T5 on T1.Process_id = T5.Process_id
WHERE T1.Assembly_id = 100
ORDER BY T2.Date_ordered;
/*Query-11*/

/*Query-12*/
select T1.Job_no,T1.Date_ended, T1.Additional_info,T1.Assembly_id, T3.Department_data
FROM Job as T1 JOIN Supervises as T2 on T1.Process_id = T2.Process_id
JOIN Department as T3 on T3.Department_no = T2.Department_no
WHERE T1.Date_ended = '2021-11-12' and T3.Department_no = 3;
/*Query-12*/


/*Query-13*/
select Customer_name from Customer WHERE category between 1 and 6;
/*Query-13*/

/*Query-14*/
DELETE FROM Cut_Job where Job_no BETWEEN 1 and 4;
SELECT * FROM Cut_Job;
/*Query-14*/

/*Query-15*/
UPDATE Paint_Job SET Color = 'Green' where Job_no=3;

select * from Paint_Job;

DROP PROCEDURE IF EXISTS insert_test1;
GO
CREATE PROCEDURE insert_test1
    @Cname VARCHAR(20),
    @Addr VARCHAR(50),
    @Category INT 
AS
  BEGIN
        INSERT INTO Customer VALUES(@Cname,@Addr,@Category);

    END


DROP PROCEDURE IF EXISTS insert_test2;
GO
CREATE PROCEDURE insert_test2
    @Dno INT,
    @Ddata VARCHAR(20)
AS
  BEGIN
        INSERT INTO Department VALUES(@Dno,@Ddata);

    END

DROP PROCEDURE IF EXISTS insert_test3;
GO
CREATE PROCEDURE insert_test3
    @Pid INT,
    @Pdata VARCHAR(20),
    @Dno INT
AS
  BEGIN
        INSERT INTO Process VALUES(@Pid,@Pdata);
        INSERT INTO Supervises VALUES(@Pid, @Dno);
    END

DROP PROCEDURE IF EXISTS insert_test3_1;
GO
CREATE PROCEDURE insert_test3_1
    @Pid INT,
    @Pdata VARCHAR(20),
    @Ftype VARCHAR(20)
AS
  BEGIN
        INSERT INTO Fit VALUES(@Pid,@Pdata, @Ftype);
    END

DROP PROCEDURE IF EXISTS insert_test3_2;
GO
CREATE PROCEDURE insert_test3_2
    @Pid INT,
    @Pdata VARCHAR(20),
    @Ctype VARCHAR(20),
    @Mtype VARCHAR(20)
AS
  BEGIN
        INSERT INTO Cut VALUES(@Pid,@Pdata, @Ctype, @Mtype);
    END

DROP PROCEDURE IF EXISTS insert_test3_3;
GO
CREATE PROCEDURE insert_test3_3
    @Pid INT,
    @Pdata VARCHAR(20),
    @Ptype VARCHAR(20),
    @Pmethod VARCHAR(20)
AS
  BEGIN
        INSERT INTO Paint VALUES(@Pid,@Pdata, @Ptype, @Pmethod);
    END

DROP PROCEDURE IF EXISTS insert_test4;
GO
CREATE PROCEDURE insert_test4
    @Aid INT,
    @Dateord DATE,
    @Adetails VARCHAR(20),
    @Cname VARCHAR(20),
    @Pid INT
AS
  BEGIN
        INSERT INTO Assembl VALUES(@Aid,@Dateord, @Adetails, @Cname);
        INSERT INTO Manufactured_by VALUES(@Aid, @Pid);
    END

DROP PROCEDURE IF EXISTS insert_test5;
GO
CREATE PROCEDURE insert_test5
    @Tno INT,
    @Sup INT,
    @Jno INT
AS
  BEGIN
        INSERT into Transac VALUES(@Tno, @Sup, @Jno);
    END

DROP PROCEDURE IF EXISTS insert_test5_1;
GO
CREATE PROCEDURE insert_test5_1
    @Ano INT,
    @Dateacc DATE,
    @Det1 INT,
    @Tno INT,
    @Aid INT
AS
  BEGIN
        INSERT INTO Assembly_account VALUES(@Ano,@Dateacc, @Det1, @Tno);
        INSERT INTO Maintained_for VALUES(@Ano, NULL, NULL, @Aid);
    END

DROP PROCEDURE IF EXISTS insert_test5_2;
GO
CREATE PROCEDURE insert_test5_2
    @Ano INT,
    @Dateacc DATE,
    @Det1 INT,
    @Tno INT,
    @Dno INT
AS
  BEGIN
        INSERT INTO Department_account VALUES(@Ano,@Dateacc, @Det1, @Tno);
        INSERT INTO Maintained_for VALUES(@Ano, NULL, @Dno, NULL);
    END

DROP PROCEDURE IF EXISTS insert_test5_3;
GO
CREATE PROCEDURE insert_test5_3
    @Ano INT,
    @Dateacc DATE,
    @Det1 INT,
    @Tno INT,
    @Pid INT
AS
  BEGIN
        INSERT INTO Process_account VALUES(@Ano,@Dateacc, @Det1, @Tno);
        INSERT INTO Maintained_for VALUES(@Ano, @Pid, NULL, NULL);
    END

DROP PROCEDURE IF EXISTS insert_test6_1;
GO
CREATE PROCEDURE insert_test6_1
    @Jno INT,
    @Datesta DATE,
    @Ainfo VARCHAR(30),
    @Aid INT,
    @Pid INT,
    @Mtype VARCHAR(20),
    @Tused TIME,
    @Mate VARCHAR(20),
    @Ltime TIME
AS
  BEGIN
        INSERT INTO Job VALUES(@Jno,@Datesta, NULL, @Ainfo, @Aid,@Pid);
        INSERT INTO Cut_Job VALUES(@Jno,@Datesta, NULL, @Ainfo, @Aid,@Pid,@Mtype,@Tused,@Mate,@Ltime);

    END

DROP PROCEDURE IF EXISTS insert_test6_2;
GO
CREATE PROCEDURE insert_test6_2
    @Jno INT,
    @Datesta DATE,
    @Ainfo VARCHAR(30),
    @Aid INT,
    @Pid INT,
    @Color VARCHAR(20),
    @Vol INT,
    @Ltime TIME
AS
  BEGIN
        INSERT INTO Job VALUES(@Jno,@Datesta, NULL, @Ainfo, @Aid,@Pid);
        INSERT INTO Paint_Job VALUES(@Jno,@Datesta, NULL, @Ainfo, @Aid,@Pid,@Color,@Vol,@Ltime);

    END

DROP PROCEDURE IF EXISTS insert_test6_3;
GO
CREATE PROCEDURE insert_test6_3
    @Jno INT,
    @Datesta DATE,
    @Ainfo VARCHAR(30),
    @Aid INT,
    @Pid INT,
    @Ltime TIME
AS
  BEGIN
        INSERT INTO Job VALUES(@Jno,@Datesta, NULL, @Ainfo, @Aid,@Pid);
        INSERT INTO Fit_Job VALUES(@Jno,@Datesta, NULL, @Ainfo, @Aid,@Pid,@Ltime);

    END

DROP PROCEDURE IF EXISTS insert_test7;
GO
CREATE PROCEDURE insert_test7
    @Jno INT,
    @Dateend DATE
AS
  BEGIN
        UPDATE Job SET Date_ended = @Dateend WHERE Job_no = @Jno;
        UPDATE Cut_Job SET Date_ended = @Dateend WHERE Job_no = @Jno;
        UPDATE Paint_Job SET Date_ended = @Dateend WHERE Job_no = @Jno;
        UPDATE Fit_Job SET Date_ended = @Dateend WHERE Job_no = @Jno;

    END

DROP PROCEDURE IF EXISTS insert_test8;
GO
CREATE PROCEDURE insert_test8
    @Tno INT,
    @Sup INT
AS
  BEGIN
     UPDATE Assembly_account SET Details_1= Details_1+@Sup WHERE Transaction_no = @Tno;
     UPDATE Department_account SET Details_2= Details_2+@Sup WHERE Transaction_no = @Tno;
     UPDATE Process_account SET Details_2= Details_2+@Sup WHERE Transaction_no = @Tno;
  END

DROP PROCEDURE IF EXISTS retrieve_test9;
GO
CREATE PROCEDURE retrieve_test9
    @Aid INT
AS
  BEGIN
     SELECT T1.Details_1 from Assembly_account as T1 JOIN Maintained_for as T2 on T1.Account_no = T2.Account_no where T2.Assembly_id = @Aid;
  END

DROP PROCEDURE IF EXISTS retrieve_test11;
GO
CREATE PROCEDURE retrieve_test11
    @Aid INT
AS
  BEGIN
     select T5.Process_data, T4.Department_data FROM Manufactured_by as T1 JOIN Assembl as T2 ON T1.Assembly_id = T2.Assembly_id
     JOIN Supervises as T3 ON T1.Process_id = T3.Process_id 
     JOIN Department as T4 ON T3.Department_no = T4.Department_no
     JOIN Process as T5 on T1.Process_id = T5.Process_id
     WHERE T1.Assembly_id = @Aid
     ORDER BY T2.Date_ordered;
  END

DROP PROCEDURE IF EXISTS retrieve_test12;
GO
CREATE PROCEDURE retrieve_test12
    @Dep INT,
    @Datee DATE
AS
  BEGIN
     select T1.Job_no,T1.Date_ended, T1.Additional_info,T1.Assembly_id, T3.Department_data
     FROM Job as T1 JOIN Supervises as T2 on T1.Process_id = T2.Process_id
     JOIN Department as T3 on T3.Department_no = T2.Department_no
     WHERE T1.Date_ended = @Datee  and T3.Department_no = @Dep;
  END

  DROP PROCEDURE IF EXISTS retrieve_test13;
GO
CREATE PROCEDURE retrieve_test13
    @R1 INT,
    @R2 INT
AS
  BEGIN
     select Customer_name from Customer WHERE category between @R1 and @R2;
  END

DROP PROCEDURE IF EXISTS delete_test14;
GO
CREATE PROCEDURE delete_test14
    @R1 INT,
    @R2 INT
AS
  BEGIN
     DELETE FROM Cut_Job where Job_no BETWEEN @R1 and @R2;
  END

DROP PROCEDURE IF EXISTS insert_test15;
GO
CREATE PROCEDURE insert_test15
    @Col VARCHAR(20),
    @Jno INT
AS
  BEGIN
     UPDATE Paint_Job SET Color = @Col where Job_no=@Jno;
  END

select * from customer;
