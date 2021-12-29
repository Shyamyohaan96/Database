CREATE TABLE Customer(
    Customer_name VARCHAR(20),
    Addr VARCHAR(50),
    category INTEGER,
    PRIMARY KEY(Customer_name)
);



CREATE TABLE Assembl(
    Assembly_id INTEGER,
    Date_ordered DATE,
    Assembly_details VARCHAR(50),
    Customer_name VARCHAR(20),
    PRIMARY KEY(Assembly_id),
    FOREIGN KEY(Customer_name) REFERENCES Customer(Customer_name)
);



CREATE TABLE Process(
    Process_id INTEGER,
    Process_data VARCHAR(30),
    PRIMARY KEY(Process_id)
);

CREATE TABLE Manufactured_by(
    Assembly_id INTEGER,
    Process_id INTEGER,
    PRIMARY KEY(Assembly_id, Process_id),
    FOREIGN KEY(Assembly_id) REFERENCES Assembl(Assembly_id),
    FOREIGN KEY(Process_id) REFERENCES Process(Process_id)
);


CREATE TABLE Fit(
    Process_id INTEGER,
    Process_data VARCHAR(30),
    Fit_type VARCHAR(20),
    PRIMARY KEY(Process_id),
    FOREIGN KEY(Process_id) REFERENCES Process(Process_id)
);

CREATE TABLE Paint(
    Process_id INTEGER,
    Process_data VARCHAR(30),
    Paint_type VARCHAR(20),
    Paint_method VARCHAR(20),
    PRIMARY KEY(Process_id),
    FOREIGN KEY(Process_id) REFERENCES Process(Process_id)
);

CREATE TABLE Cut(
    Process_id INTEGER,
    Process_data VARCHAR(30),
    Cut_type VARCHAR(20),
    Machine_type VARCHAR(20),
    PRIMARY KEY(Process_id),
    FOREIGN KEY(Process_id) REFERENCES Process(Process_id)
);

CREATE TABLE Department(
    Department_no INTEGER,
    Department_data VARCHAR(30),
    PRIMARY KEY(Department_no)
);

CREATE TABLE Supervises(
    Process_id INTEGER,
    Department_no INTEGER,
    PRIMARY KEY(Process_id),
    FOREIGN KEY(Process_id) REFERENCES Process(Process_id),
    FOREIGN KEY(Department_no) REFERENCES Department(Department_no)
);

CREATE TABLE Job(
    Job_no INTEGER,
    Date_started DATE,
    Date_ended DATE,
    Additional_info VARCHAR(30),
    Assembly_id INTEGER,
    Process_id INTEGER,
    PRIMARY KEY(Job_no),
    FOREIGN KEY(Assembly_id) REFERENCES Assembl(Assembly_id),
    FOREIGN KEY(Process_id) REFERENCES Process(Process_id)
);

CREATE TABLE Cut_Job(
    Job_no INTEGER,
    Date_started DATE,
    Date_ended DATE,
    Additional_info VARCHAR(30),
    Assembly_id INTEGER,
    Process_id INTEGER,
    PRIMARY KEY(Job_no),
    FOREIGN KEY(Assembly_id) REFERENCES Assembl(Assembly_id),
    FOREIGN KEY(Process_id) REFERENCES Process(Process_id),
    FOREIGN KEY(Job_no) REFERENCES Job(Job_no),
    Machine_type VARCHAR(20),
    Time_machine_used TIME,
    Material VARCHAR(20),
    Labor_time TIME
);

CREATE TABLE Paint_Job(
    Job_no INTEGER,
    Date_started DATE,
    Date_ended DATE,
    Additional_info VARCHAR(30),
    Assembly_id INTEGER,
    Process_id INTEGER,
    PRIMARY KEY(Job_no),
    FOREIGN KEY(Assembly_id) REFERENCES Assembl(Assembly_id),
    FOREIGN KEY(Process_id) REFERENCES Process(Process_id),
    FOREIGN KEY(Job_no) REFERENCES Job(Job_no),
    Color VARCHAR(20),
    Volume INTEGER,
    Labor_time TIME
);

CREATE TABLE Fit_Job(
    Job_no INTEGER,
    Date_started DATE,
    Date_ended DATE,
    Additional_info VARCHAR(30),
    Assembly_id INTEGER,
    Process_id INTEGER,
    PRIMARY KEY(Job_no),
    FOREIGN KEY(Assembly_id) REFERENCES Assembl(Assembly_id),
    FOREIGN KEY(Process_id) REFERENCES Process(Process_id),
    FOREIGN KEY(Job_no) REFERENCES Job(Job_no),
    Labor_time TIME
);

CREATE TABLE Transac(
    Transaction_no INTEGER,
    sup_cost INTEGER,
    Job_no INTEGER,
    PRIMARY KEY(Transaction_no),
    FOREIGN KEY(Job_no) REFERENCES Job(Job_no),
);

CREATE TABLE Assembly_account(
    Account_no INTEGER,
    date_account DATE,
    Details_1 INTEGER,
    Transaction_no INTEGER,
    PRIMARY KEY(Account_no),
    FOREIGN KEY(Transaction_no) REFERENCES Transac(Transaction_no)
);

CREATE TABLE Department_account(
    Account_no INTEGER,
    date_account DATE,
    Details_2 INTEGER,
    Transaction_no INTEGER,
    PRIMARY KEY(Account_no),
    FOREIGN KEY(Transaction_no) REFERENCES Transac(Transaction_no)
);

CREATE TABLE Process_account(
    Account_no INTEGER,
    date_account DATE,
    Details_2 INTEGER,
    Transaction_no INTEGER,
    PRIMARY KEY(Account_no),
    FOREIGN KEY(Transaction_no) REFERENCES Transac(Transaction_no)
);

CREATE TABLE Maintained_for(
    Account_no INTEGER,
    Process_id INTEGER,
    Department_no INTEGER,
    Assembly_id INTEGER,
    PRIMARY KEY(Account_no),
    FOREIGN KEY(Assembly_id) REFERENCES Assembl(Assembly_id),
    FOREIGN KEY(Process_id) REFERENCES Process(Process_id),
    FOREIGN KEY(Department_no) REFERENCES Department(Department_no)
);



/*Storage procedures*/
CREATE INDEX cust ON Customer(category);
CREATE INDEX manu ON Manufactured_by(Assembly_id);
CREATE INDEX supe ON Supervises(Process_id);
CREATE INDEX mai ON Maintained_for(Account_no);