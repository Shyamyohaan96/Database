import java.sql.Connection;
import java.sql.Statement;
import java.util.Scanner;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.BufferedWriter;


public class indivi_pro {

    // Database credentials
    final static String HOSTNAME = "shyamsundar.database.windows.net";
    final static String DBNAME = "Individual project";
    final static String USERNAME = "mura0007";
    final static String PASSWORD = "Nithya053196*";

    // Database connection string
    final static String URL = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;",
            HOSTNAME, DBNAME, USERNAME, PASSWORD);
    
 // User input prompt//
    final static String PROMPT = 
            "\nPlease select one of the options below: \n" +
            "1) Insert new Customer \n" +
            "2) Insert new Department \n" +		
            "3) Insert  a new process-id and its department together \n" + 
            "4) Insert a new assembly \n" +
            "5) Insert a new account and associate it with the process, assembly, or department\n" +
            "6) Insert  new job, given its job-no, assembly-id, process-id, and date the job commenced\n" +
            "7) Insert date job is completed\n" +
            "8) Insert transactions and update the details in account by adding sup cost with details\n" +
            "9) Retrieve total cost\n" +
            "10) Retrieve total labor time\n" +
            "11) Retrieve process and department\n"+
            "12) Retrieve jobs completed\n"+
            "13) Retrieve the customers\n" +
            "14) Delete all cut jobs with given job no range\n" +
            "15) Update color of paint job\n"+
            "16) Import: enter new customers from a data file until the file is empty\n" +
            "17) Export: Retrieve the customers (in name order) whose category is in a given range\n" +
            "18) Exit!!";

    
    public static void main(String[] args) throws SQLException, NumberFormatException, IOException {
    	
    	// Connecting to the database

        System.out.println("WELCOME TO THE JOB-SHOP ACCOUNTING DATABASE SYSTEM!");

        final Scanner sc = new Scanner(System.in); 
        String option = ""; 
        while (!option.equals("18")) { 
            System.out.println(PROMPT); 
            option = sc.next(); 
            switch (option) {
            	case "1":
            		System.out.println("Enter customer name:");
                    final String cname = sc.next();
                    
                    System.out.println("Enter Address:");
                    final String Addr = sc.next();
                    
                    System.out.println("Enter category:");
                    final int cate = sc.nextInt();
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC insert_test1 @Cname =?, @Addr =?, @Category =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setString(1, cname);
                            statement.setString(2, Addr);
                            statement.setInt(3, cate);

                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            int  res= statement.executeUpdate();
                            System.out.println(res+" customer inserted");
                        }
                    }
                    break;
            	case "2":
            		System.out.println("Enter Department Number:");
                    final int dno = sc.nextInt();
                    
                    System.out.println("Enter Department data:");
                    final String ddata = sc.next();
                   
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC insert_test2 @Dno =?, @Ddata =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, dno);
                            statement.setString(2, ddata);

                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            int  res= statement.executeUpdate();
                            System.out.println(res+" Department inserted");
                        }
                    }
                    break;
            	case "3":
            		System.out.println("Enter Process ID:");
                    final int pid = sc.nextInt();
                    
                    System.out.println("Enter Process data:");
                    final String pdata = sc.next();
                    
                    System.out.println("Enter Department Number:");
                    final int deno = sc.nextInt();
                   
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC insert_test3 @Pid =?, @Pdata =?, @Dno =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, pid);
                            statement.setString(2, pdata);
                            statement.setInt(3, deno);

                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            int  res= statement.executeUpdate();
                            System.out.println(res+" Process & supervises inserted");
                        }
                    }
                    System.out.println("Enter Process type:");
                    final String protype = sc.next();
                    if (protype.equals("Fit"))
                    {
                    	System.out.println("Enter Fit type");
                        final String ftype = sc.next();
                        System.out.println("Connecting to the database...");
                        
                        try (final Connection connection = DriverManager.getConnection(URL)) {
                            try (
                                final PreparedStatement statement = connection.prepareStatement(
                                		"EXEC insert_test3_1 @Pid =?, @Pdata =?, @Ftype =?;")) {
                                // Populate the query template with the data collected from the user
                                statement.setInt(1, pid);
                                statement.setString(2, pdata);
                                statement.setString(3, ftype);

                                System.out.println("Dispatching the query...");
                                // Actually execute the populated query
                                int  res= statement.executeUpdate();
                                System.out.println(res+" Fit inserted");
                            }
                        }
                    }
                    else if(protype.equals("Cut")) {
                    	System.out.println("Enter Cut type");
                        final String ctype = sc.next();
                        
                        System.out.println("Enter machine type");
                        final String mtype = sc.next();
                        
                        try (final Connection connection = DriverManager.getConnection(URL)) {
                            try (
                                final PreparedStatement statement = connection.prepareStatement(
                                		"EXEC insert_test3_2 @Pid =?, @Pdata =?, @Ctype =?, @Mtype =?;")) {
                                // Populate the query template with the data collected from the user
                                statement.setInt(1, pid);
                                statement.setString(2, pdata);
                                statement.setString(3, ctype);
                                statement.setString(4, mtype);

                                System.out.println("Dispatching the query...");
                                // Actually execute the populated query
                                int  res= statement.executeUpdate();
                                System.out.println(res+" Cut inserted");
                            }
                        }
                    }
                    else if(protype.equals("Paint")) {
                    	System.out.println("Enter paint type");
                        final String ptype = sc.next();
                        
                        System.out.println("Enter paint method");
                        final String pmethod = sc.next();
                        
                        try (final Connection connection = DriverManager.getConnection(URL)) {
                            try (
                                final PreparedStatement statement = connection.prepareStatement(
                                		"EXEC insert_test3_3 @Pid =?, @Pdata =?, @Ptype =?, @Pmethod =?;")) {
                                // Populate the query template with the data collected from the user
                                statement.setInt(1, pid);
                                statement.setString(2, pdata);
                                statement.setString(3, ptype);
                                statement.setString(4, pmethod);

                                System.out.println("Dispatching the query...");
                                // Actually execute the populated query
                                int  res= statement.executeUpdate();
                                System.out.println(res+" Paint inserted");
                            }
                        }
                    }
                    break;
            	case "4":
            		System.out.println("Enter Assembly ID:");
                    final int aid = sc.nextInt();
                    
                    System.out.println("Enter date ordered:");
                    final String dordered = sc.next();
                    
                    System.out.println("Enter Assembly details:");
                    final String adet = sc.next();
                    
                    System.out.println("Enter Customer name:");
                    final String cust = sc.next();
                   
                    System.out.println("Enter Process ID:");
                    final int proid = sc.nextInt();
                    
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC insert_test4 @Aid =?, @Dateord =?, @Adetails =?,@Cname =?, @Pid =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, aid);
                            statement.setString(2, dordered);
                            statement.setString(3, adet);
                            statement.setString(4, cust);
                            statement.setInt(5, proid);

                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            int  res= statement.executeUpdate();
                            System.out.println(res+" Assembly & manufactured by inserted");
                        }
                    }
                    break;
            	case "5":
            		System.out.println("Enter Transaction number:");
                    final int tno = sc.nextInt();
                    
                    System.out.println("Enter sup cost:");
                    final int sup = sc.nextInt();
                    
                    System.out.println("Enter Job number:");
                    final int jono = sc.nextInt();
                    
                    System.out.println("Enter Account number:");
                    final int ano = sc.nextInt();
                    
                    System.out.println("Enter date of account created:");
                    final String adate = sc.next();
                    
                    System.out.println("Enter detail amount:");
                    final int damu = sc.nextInt();
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC insert_test5 @Tno =?, @Sup =?, @Jno =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, tno);
                            statement.setInt(2, sup);
                            statement.setInt(3, jono);

                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            int  res= statement.executeUpdate();
                            System.out.println(res+" Transaction inserted");
                        }
                    }
                    System.out.println("Enter Account type:");
                    final String acctype = sc.next();
                    if (acctype.equals("Assembly")) {
                    	System.out.println("Enter Assembly ID:");
                        final int asid = sc.nextInt();
                        System.out.println("Connecting to the database...");
                        
                        try (final Connection connection = DriverManager.getConnection(URL)) {
                            try (
                                final PreparedStatement statement = connection.prepareStatement(
                                		"EXEC insert_test5_1 @Ano =?, @Dateacc =?, @Det1 =?, @Tno =?, @Aid =?;")) {
                                // Populate the query template with the data collected from the user
                                statement.setInt(1, ano);
                                statement.setString(2, adate);
                                statement.setInt(3, damu);
                                statement.setInt(4, tno);
                                statement.setInt(5, asid);

                                System.out.println("Dispatching the query...");
                                // Actually execute the populated query
                                int  res= statement.executeUpdate();
                                System.out.println(res+" Assembly account inserted");
                            }
                        }
                    }
                    else if (acctype.equals("Department")) {
                    	System.out.println("Enter Department number:");
                        final int depno = sc.nextInt();
                        System.out.println("Connecting to the database...");
                        
                        try (final Connection connection = DriverManager.getConnection(URL)) {
                            try (
                                final PreparedStatement statement = connection.prepareStatement(
                                		"EXEC insert_test5_2 @Ano =?, @Dateacc =?, @Det1 =?, @Tno =?, @Dno =?;")) {
                                // Populate the query template with the data collected from the user
                                statement.setInt(1, ano);
                                statement.setString(2, adate);
                                statement.setInt(3, damu);
                                statement.setInt(4, tno);
                                statement.setInt(5, depno);

                                System.out.println("Dispatching the query...");
                                // Actually execute the populated query
                                int  res= statement.executeUpdate();
                                System.out.println(res+" Department account inserted");
                            }
                        }
                    }
                    else if (acctype.equals("Process")) {
                    	System.out.println("Enter Process ID:");
                        final int procid = sc.nextInt();
                        System.out.println("Connecting to the database...");
                        
                        try (final Connection connection = DriverManager.getConnection(URL)) {
                            try (
                                final PreparedStatement statement = connection.prepareStatement(
                                		"EXEC insert_test5_3 @Ano =?, @Dateacc =?, @Det1 =?, @Tno =?, @Pid =?;")) {
                                // Populate the query template with the data collected from the user
                                statement.setInt(1, ano);
                                statement.setString(2, adate);
                                statement.setInt(3, damu);
                                statement.setInt(4, tno);
                                statement.setInt(5, procid);

                                System.out.println("Dispatching the query...");
                                // Actually execute the populated query
                                int  res= statement.executeUpdate();
                                System.out.println(res+" Process account inserted");
                            }
                        }
                    }
                    
                    break;
            	case "6":
                    System.out.println("Enter Job number:");
                    final int jno = sc.nextInt();
                               
                    
                    System.out.println("Enter start date:");
                    final String sdate = sc.next();
                    
                    System.out.println("Enter Additional Info:");
                    final String ainfo = sc.next();
                    
                    System.out.println("Enter assembly id:");
                    final int amid = sc.nextInt();
                    
                    System.out.println("Enter Process ID:");
                    final int psid = sc.nextInt();
                    
                    System.out.println("Enter Labor time:");
                    final String ltime = sc.next();
                    
                    System.out.println("Enter Job type:");
                    final String jotype = sc.next();
                    
                    if(jotype.equals("Cut")) {
                    	System.out.println("Enter Machine type:");
                        final String matype = sc.next();
                        
                        System.out.println("Enter time used:");
                        final String mtime = sc.next();
                        
                        System.out.println("Enter Material:");
                        final String mat = sc.next();
                        
                        System.out.println("Connecting to the database...");
                        
                        try (final Connection connection = DriverManager.getConnection(URL)) {
                            try (
                                final PreparedStatement statement = connection.prepareStatement(
                                		"EXEC insert_test6_1 @Jno =?, @Datesta =?, @Ainfo =?, @Aid =?, @Pid =?, @Mtype =?, @Tused =?, @Mate =?, @Ltime =?;")) {
                                // Populate the query template with the data collected from the user
                                statement.setInt(1, jno);
                                statement.setString(2, sdate);
                                statement.setString(3, ainfo);
                                statement.setInt(4, amid);
                                statement.setInt(5, psid);
                                statement.setString(6, matype);
                                statement.setString(7, mtime);
                                statement.setString(8, mat);
                                statement.setString(9, ltime);

                                System.out.println("Dispatching the query...");
                                // Actually execute the populated query
                                int  res= statement.executeUpdate();
                                System.out.println(res+" Cut job inserted");
                            }
                        }
                        
                    }
                    else if(jotype.equals("Paint")) {
                    	System.out.println("Enter color:");
                        final String col = sc.next();
                        
                        System.out.println("Enter volume:");
                        final int vol = sc.nextInt();
                        
                        System.out.println("Connecting to the database...");
                        
                        try (final Connection connection = DriverManager.getConnection(URL)) {
                            try (
                                final PreparedStatement statement = connection.prepareStatement(
                                		"EXEC insert_test6_2 @Jno =?, @Datesta =?, @Ainfo =?, @Aid =?, @Pid =?, @Color =?, @Vol =?, @Ltime =?;")) {
                                // Populate the query template with the data collected from the user
                                statement.setInt(1, jno);
                                statement.setString(2, sdate);
                                statement.setString(3, ainfo);
                                statement.setInt(4, amid);
                                statement.setInt(5, psid);
                                statement.setString(6, col);
                                statement.setInt(7, vol);
                                statement.setString(8, ltime);

                                System.out.println("Dispatching the query...");
                                // Actually execute the populated query
                                int  res= statement.executeUpdate();
                                System.out.println(res+" Paint job inserted");
                            }
                        }
                        
                    }
                    else if(jotype.equals("Fit")) {
                    	
                        System.out.println("Connecting to the database...");
                        
                        try (final Connection connection = DriverManager.getConnection(URL)) {
                            try (
                                final PreparedStatement statement = connection.prepareStatement(
                                		"EXEC insert_test6_3 @Jno =?, @Datesta =?, @Ainfo =?, @Aid =?, @Pid =?, @Ltime =?;")) {
                                // Populate the query template with the data collected from the user
                                statement.setInt(1, jno);
                                statement.setString(2, sdate);
                                statement.setString(3, ainfo);
                                statement.setInt(4, amid);
                                statement.setInt(5, psid);
                                statement.setString(6, ltime);

                                System.out.println("Dispatching the query...");
                                // Actually execute the populated query
                                int  res= statement.executeUpdate();
                                System.out.println(res+" Fit job inserted");
                            }
                        }
                        
                    }
                     
                    break;
            	case "7":
            		System.out.println("Enter Job number:");
                    final int jobid = sc.nextInt();
                    
                    System.out.println("Enter date ended:");
                    final String dend = sc.next();
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC insert_test7 @Jno =?, @Dateend =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, jobid);
                            statement.setString(2, dend);
                            
                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            int  res= statement.executeUpdate();
                            System.out.println(res+" Job updated");
                        }
                    }
                    break;
            	case "8":
            		System.out.println("Enter Transaction number:");
                    final int trno = sc.nextInt();
                    
                    System.out.println("Enter sup cost:");
                    final int supc = sc.nextInt();
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC insert_test8 @Tno =?, @Sup =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, trno);
                            statement.setInt(2, supc);
                            
                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            int  res= statement.executeUpdate();
                            System.out.println(res+" Account updated");
                        }
                    }
                    break;
            	case "9":
            		System.out.println("Enter Assembly ID:");
                    final int ad = sc.nextInt();
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC retrieve_test9 @Aid =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, ad);
                            
                            
                            System.out.println("Dispatching the query...");
                            // Actually execute the query
                            final ResultSet resultSet = statement.executeQuery();
                            System.out.println("Output:");
                            while (resultSet.next()) {
               				 System.out.println(String.format("%d",
               						 resultSet.getInt(1)));
                            }
                        }
                    }
                    break;
            	case "10":
            		System.out.println("Unable to execute the query since I gave labour time as time datatype");
            		break;
            	case "11":
            		System.out.println("Enter Assembly ID:");
                    final int abd = sc.nextInt();
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC retrieve_test11 @Aid =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, abd);
                            
                            
                            System.out.println("Dispatching the query...");
                            // Actually execute the query
                            final ResultSet resultSet_1 = statement.executeQuery();
                            System.out.println("Output:");
                            while (resultSet_1.next()) {
               				 System.out.println(String.format("%s | %s",
               						 resultSet_1.getString(1),
               						resultSet_1.getString(2)));
                            }
                        }
                    }
                    break;
            	case "12":
            		System.out.println("Enter Department number:");
                    final int dep = sc.nextInt();
                    
                    System.out.println("Enter Date ended:");
                    final String dat = sc.next();
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC retrieve_test12 @Dep =?, @Datee =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, dep);
                            statement.setString(2, dat);
                            
                            
                            System.out.println("Dispatching the query...");
                            // Actually execute the query
                            final ResultSet resultSet_2 = statement.executeQuery();
                            System.out.println("Output:");
                            while (resultSet_2.next()) {
               				 System.out.println(String.format("%d | %s | %s | %d | %s",
               						 resultSet_2.getInt(1),
               						 resultSet_2.getString(2),
               						 resultSet_2.getString(3),
               						 resultSet_2.getInt(4),
               						 resultSet_2.getString(5)));
                            }
                        }
                    }
                    break;
            	case "13":
            		System.out.println("Enter start value:");
                    final int r1 = sc.nextInt();
                    
                    System.out.println("Enter end value:");
                    final int r2 = sc.nextInt();
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC retrieve_test13 @R1 =?, @R2 =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, r1);
                            statement.setInt(2, r2);
                            
                            
                            System.out.println("Dispatching the query...");
                            // Actually execute the query
                            final ResultSet resultSet_3 = statement.executeQuery();
                            System.out.println("Output:");
                            while (resultSet_3.next()) {
               				 System.out.println(String.format("%s",
               						 resultSet_3.getString(1)));
                            }
                        }
                    }
                    break;
            	case "14":
            		System.out.println("Enter start value:");
                    final int s1 = sc.nextInt();
                    
                    System.out.println("Enter end value:");
                    final int s2 = sc.nextInt();
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC delete_test14 @R1 =?, @R2 =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, s1);
                            statement.setInt(2, s2);
                            
                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            int  res= statement.executeUpdate();
                            System.out.println(res+" Cut job deleted");
                        }
                    }
                    break;
            	case "15":
            		System.out.println("Enter color:");
                    final String c = sc.next();
                    
                    System.out.println("Enter Job number:");
                    final int j = sc.nextInt();
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC insert_test15 @Col =?, @Jno =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setString(1, c);
                            statement.setInt(2, j);
                            
                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            int  res= statement.executeUpdate();
                            System.out.println(res+" Color updated");
                        }
                    }
                    break;
            	case "16":
            		System.out.println("Enter file name:");
                    final String f_name = sc.next();
                    File F = new File("E:\\DBMS\\indi_project\\"+f_name);
                    BufferedReader b= new BufferedReader(new FileReader(F));
                    
                    String st;
        			//Importing each row until the file is empty

        			while ((st = b.readLine()) != null) { 
        			String customer[] = st.split(",");
        			String n = customer[0];
        			String a = customer[1];
        			int cat = Integer.parseInt(customer[2]);
        			System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC insert_test1 @Cname =?, @Addr =?, @Category =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setString(1, n);
                            statement.setString(2, a);
                            statement.setInt(3, cat);

                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            int  res= statement.executeUpdate();
                            System.out.println(res+" customer imported");
                        
                    }
        			}
                    
        			}
        			break;
            	case "17":
            		System.out.println("Enter file name:");
                    final String fi = sc.next();
            		
            		System.out.println("Enter start value:");
                    final int c1 = sc.nextInt();
                    
                    System.out.println("Enter end value:");
                    final int c2 = sc.nextInt();
                    
                    FileWriter f=new FileWriter("E:\\DBMS\\indi_project\\"+fi);
                    
                    System.out.println("Connecting to the database...");
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(
                            		"EXEC retrieve_test13 @R1 =?, @R2 =?;")) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, c1);
                            statement.setInt(2, c2);
                            
                            
                            System.out.println("Dispatching the query...");
                            // Actually execute the query
                            final ResultSet resultSet_7 = statement.executeQuery();
                            System.out.println("Output:");
                            while (resultSet_7.next()) {
               				 	f.write(String.format("%s,",
               						 resultSet_7.getString(1)));
                            }
                            f.close();
                        }
                    }
                    break;
            	case "18":
            		System.out.println("Exitting!!!");
            		break;
            		
            }
        }
      }
   
}