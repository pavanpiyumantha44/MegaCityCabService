package com.cab.mega.utils.mail;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendEmail {
    private static SendEmail sendEmail;
    public static synchronized SendEmail getEmailSender() {
        if (sendEmail == null) {
            sendEmail = new SendEmail();
        }
        return sendEmail;
    }

    public void generateEmail(String mail, String subject, String body) throws MessagingException {
        final String userEmail = "digiworks44@gmail.com";
        final String password = "ssve pnjt bcbd qvcx";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(userEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(mail));
            message.setSubject(subject);
            message.setText(body);
            Transport.send(message);
            System.out.println("Email has been sent successfully!");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
