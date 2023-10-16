package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {
	@Override
	protected PasswordAuthentication getPasswordAuthentication() { // protected=same package or diff package subclass
		return new PasswordAuthentication("<admin-email@gmail.com>", "<admin-password>");
	}
}
