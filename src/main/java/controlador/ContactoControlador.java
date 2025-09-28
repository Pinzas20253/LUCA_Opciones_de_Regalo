package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Properties;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@WebServlet("/contacto")
public class ContactoControlador extends HttpServlet {

    private static final String SMTP_HOST = "smtp.gmail.com"; // Servidor SMTP de Gmail
    private static final int SMTP_PORT = 587; // 587 para TLS
    private static final String SMTP_USER = "lucaopcionesderegalo@gmail.com"; // Tu correo de Gmail
    private static final String SMTP_PASS = "xdiz kpux thqw yigz"; // Reemplaza esto por la contraseña de aplicación de 16 caracteres

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String mensajeUsuario = request.getParameter("mensaje");

        boolean enviado = enviarCorreo(nombre, correo, mensajeUsuario);

        if (enviado) {
            request.setAttribute("mensajeExito", "Mensaje enviado correctamente");
        } else {
            request.setAttribute("mensajeError", "Error al enviar el mensaje");
        }

        request.getRequestDispatcher("contacto.jsp").forward(request, response);
    }

    private boolean enviarCorreo(String nombre, String correo, String mensajeUsuario) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected jakarta.mail.PasswordAuthentication getPasswordAuthentication() {
                return new jakarta.mail.PasswordAuthentication(SMTP_USER, SMTP_PASS);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_USER));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(SMTP_USER)); // Aquí puedes poner otro correo receptor si quieres
            message.setSubject("Nuevo mensaje de contacto de " + nombre);
            message.setText("Nombre: " + nombre + "\nCorreo: " + correo + "\nMensaje: " + mensajeUsuario);

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
