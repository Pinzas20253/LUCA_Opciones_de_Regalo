package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    public static void enviarCorreo(String destino, String asunto, String mensaje) throws MessagingException {
        String remitente = "tucorreo@dominio.com"; // Cambiar por el correo real de LUCA
        String password = "tucontraseña";          // Contraseña de la cuenta de correo

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // servidor SMTP (Gmail como ejemplo)
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new jakarta.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(remitente, password);
                    }
                });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(remitente));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destino));
        message.setSubject(asunto);
        message.setText(mensaje);

        Transport.send(message);
    }
}
