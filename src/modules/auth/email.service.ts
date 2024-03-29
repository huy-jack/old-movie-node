import { Injectable } from '@nestjs/common';
import * as nodemailer from 'nodemailer';

@Injectable()
export class EmailService {
  private transporter: nodemailer.Transporter;

  constructor() {
    this.transporter = nodemailer.createTransport({
      host: 'smtp.gmail.com',
      port: 465,
      secure: true,
      auth: {
        user: process.env.TRANSPORT_USER,
        pass: process.env.TRANSPORT_PASS,
      },
    });
  }

  async sendVerificationEmail(
    email: string,
    verificationNumber: string,
  ): Promise<void> {
    const mailOptions: nodemailer.SendMailOptions = {
      from: 'oldmovie391@gmail.com',
      to: email,
      subject: 'Verification Code',
      html: `<p>Here is your verification code: ${verificationNumber}</p>`,
    };
    try {
      await this.transporter.sendMail(mailOptions);
      console.log(`Verification number sent to ${email}`);
    } catch (error) {
      console.log(`Failed to send verification number to ${email}`);
    }
  }

  async sendResetPasswordEmail(email: string, resetToken: string): Promise<void> {
    const mailOptions: nodemailer.SendMailOptions = {
      from: 'oldmovie391@gmail.com',
      to: email,
      subject: 'Password Reset',
      html: `<p>Click the following link to reset your password: <a href="http://localhost:3333/api/auth/reset-password/${resetToken}">Reset Password</a></p>`,
    };

    try {
      await this.transporter.sendMail(mailOptions);
      console.log(`Password reset email sent to ${email}`);
    } catch (error) {
      console.error(`Error sending password reset email to ${email}:`, error);
      throw new Error('Failed to send password reset email');
    }
  }
}
