/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ticketing.model;

import java.sql.Timestamp;

public class Task {
    private int taskId;
    private int projectId;
    private String projectName;
    private String taskOwner;
    private String taskDescription;
    private Timestamp taskStartDateTime;
    private Timestamp taskEndDateTime;
    private String taskCollaborators;
    private String status;
    private Timestamp createdDate;
    
    // Default constructor
    public Task() {}
    
    // Constructor with parameters
    public Task(int projectId, String taskOwner, String taskDescription, 
               Timestamp taskStartDateTime, Timestamp taskEndDateTime, String taskCollaborators) {
        this.projectId = projectId;
        this.taskOwner = taskOwner;
        this.taskDescription = taskDescription;
        this.taskStartDateTime = taskStartDateTime;
        this.taskEndDateTime = taskEndDateTime;
        this.taskCollaborators = taskCollaborators;
    }
    
    // Getters and Setters
    public int getTaskId() {
        return taskId;
    }
    
    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }
    
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
    
    public String getTaskOwner() {
        return taskOwner;
    }
    
    public void setTaskOwner(String taskOwner) {
        this.taskOwner = taskOwner;
    }
    
    public String getTaskDescription() {
        return taskDescription;
    }
    
    public void setTaskDescription(String taskDescription) {
        this.taskDescription = taskDescription;
    }
    
    public Timestamp getTaskStartDateTime() {
        return taskStartDateTime;
    }
    
    public void setTaskStartDateTime(Timestamp taskStartDateTime) {
        this.taskStartDateTime = taskStartDateTime;
    }
    
    public Timestamp getTaskEndDateTime() {
        return taskEndDateTime;
    }
    
    public void setTaskEndDateTime(Timestamp taskEndDateTime) {
        this.taskEndDateTime = taskEndDateTime;
    }
    
    public String getTaskCollaborators() {
        return taskCollaborators;
    }
    
    public void setTaskCollaborators(String taskCollaborators) {
        this.taskCollaborators = taskCollaborators;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }
}