Return-Path: <cygwin-patches-return-3106-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5964 invoked by alias); 4 Nov 2002 01:34:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5909 invoked from network); 4 Nov 2002 01:34:37 -0000
Message-ID: <004501c283a2$0b263870$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: <cygwin-patches@cygwin.com>
References: <002701c28394$ce2fc1f0$0201a8c0@sos> <20021104003759.GA22976@redhat.com> <003c01c2839c$355bf130$0201a8c0@sos> <20021104011150.GA23246@redhat.com>
Subject: Re: fhandler_tty patch
Date: Sun, 03 Nov 2002 17:34:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00057.txt.bz2


----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Sunday, November 03, 2002 8:11 PM
Subject: Re: fhandler_tty patch


> Ok.  I haven't looked closely at this code before.  I just am not sure
> what use setting the size on a pty master would entail.  I wonder if it
> is supposed to be propagated to the slave.  Also, isn't the master
> supposed to be notified of size changes in the slave?

No. Slave only gets the notification. From HP-UX manual page:

              When an M_IOCTL message of type TIOCSWINSZ is received in its
              write queue, ptem saves the information passed to it in the
              winsize structure and sends an M_PCSIG (with the signal number
              set to SIGWINCH) upstream to the pty slave process if the
              window size is changed.

             When an M_IOCTL message of type TIOCSWINSZ is received in its
              read queue, ptem saves the information passed to it in the
              winsize structure and sends an M_PCSIG (with the signal number
              is set to SIGWINCH) upstream to the pty slave process if the
              window size is changed.

Note that the signal in both cases is sent to slave pty and only if the
window size is changed.

>
> I'll apply the patch but I suspect that this is still not exactly right
> wrt UNIX emulation.

Cygwin is not exactly right UNIX emulation - the PID of init process != 1:-)

Sergey Okhapkin
Somerset, NJ

