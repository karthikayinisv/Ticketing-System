
package com.ticketing.model;


import java.sql.Date;

public class Project {
    private int projectId;
    private String projectName;
    private String projectOwner;
    private String status;
    private Date startDate;
    private Date endDate;
    private int division;
    private String divisionName;
    
    // Default constructor
    public Project() {}
    
    // Constructor with parameters
    public Project(String projectName, String projectOwner, Date startDate, Date endDate, int division) {
        this.projectName = projectName;
        this.projectOwner = projectOwner;
        this.startDate = startDate;
        this.endDate = endDate;
        this.division = division;
    }
    
    // Getters and Setters
    public int getProjectId() {
        return projectId;
    }
    
    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }
    
    public String getProjectName() {
        return projectName;
    }
    
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }
    
    public String getProjectOwner() {
        return projectOwner;
    }
    
    public void setProjectOwner(String projectOwner) {
        this.projectOwner = projectOwner;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Date getStartDate() {
        return startDate;
    }
    
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    
    public Date getEndDate() {
        return endDate;
    }
    
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
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