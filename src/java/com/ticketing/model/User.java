package com.ticketing.model;

public class User {
    private int userId;
    private String username;
    private String employeeNumber;
    private String password;
    private String email;
    private int division;
    private String divisionName;
    
    // Default constructor
    public User() {}
    
    // Constructor with parameters
    public User(int userId, String username, String employeeNumber, String email, int division, String divisionName) {
        this.userId = userId;
        this.username = username;
        this.employeeNumber = employeeNumber;
        this.email = email;
        this.division = division;
        this.divisionName = divisionName;
    }
    
    // Getters and Setters
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getEmployeeNumber() {
        return employeeNumber;
    }
    
    public void setEmployeeNumber(String employeeNumber) {
        this.employeeNumber = employeeNumber;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public int getDivision() {
        return division;
    }
    
    public void setDivision(int division) {
        this.division = division;
    }
    
    public String getDivisionName() {
        return divisionName;
    }
    
    public void setDivisionName(String divisionName) {
        this.divisionName = divisionName;
    }
}