


package com.ticketing.service;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class Email {
    // Email configuration - Update with your SMTP settings
    private static final String SMTP_HOST = "smtp.gmail.com"; // Change as per your SMTP server
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_USERNAME = "no-reply@aurolab.com"; // Your email
    private static final String EMAIL_PASSWORD = "Go@Mail2023@)@#"; // Your app password
    private static final String FROM_EMAIL = "ticketingsystem@gmail.com";
    
    public static boolean sendTaskAssignmentEmail(String toEmail, String taskDescription, 
                                                String projectName, String dueDate) {
        try {
            // Set up mail server properties
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            
            // Create session with authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            
            // Create message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("New Task Assignment - " + projectName);
            
            // Create email content
            String emailContent = createTaskAssignmentEmailContent(taskDescription, projectName, dueDate);
            message.setContent(emailContent, "text/html");
            
            // Send message
            Transport.send(message);
            
            System.out.println("Email sent successfully to: " + toEmail);
            return true;
            
        } catch (MessagingException e) {
            System.err.println("Error sending email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    private static String createTaskAssignmentEmailContent(String taskDescription, 
                                                         String projectName, String dueDate) {
        StringBuilder content = new StringBuilder();
        content.append("<html><body>");
        content.append("<div style='font-family: Arial, sans-serif; padding: 20px;'>");
        content.append("<h2 style='color: #007bff;'>New Task Assignment</h2>");
        content.append("<p>Hello,</p>");
        content.append("<p>You have been assigned a new task:</p>");
        content.append("<div style='background-color: #f8f9fa; padding: 15px; border-left: 4px solid #007bff; margin: 15px 0;'>");
        content.append("<p><strong>Project:</strong> ").append(projectName).append("</p>");
        content.append("<p><strong>Task Description:</strong> ").append(taskDescription).append("</p>");
        content.append("<p><strong>Due Date:</strong> ").append(dueDate).append("</p>");
        content.append("</div>");
        content.append("<p>Please log in to the ticketing system to view more details.</p>");
        content.append("<p>Best regards,<br>Ticketing System</p>");
        content.append("</div>");
        content.append("</body></html>");
        
        return content.toString();
    }
    
    public static boolean sendNotification(String toEmail, String subject, String message) {
        try {
            // Set up mail server properties
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            
            // Create session with authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            
            // Create message
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM_EMAIL));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            msg.setSubject(subject);
            msg.setText(message);
            
            // Send message
            Transport.send(msg);
            
            return true;
            
        } catch (MessagingException e) {
            System.err.println("Error sending notification email: " + e.getMessage());
            return false;
        }
    }
    public boolean sendEmail(String toEmail, String subject, String body) {
    try {
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM_EMAIL));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);
        message.setText(body);

        Transport.send(message);
        System.out.println("Email sent successfully to: " + toEmail);
        return true;

    } catch (MessagingException e) {
        System.err.println("Error sending email: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}

}