Return-Path: <cygwin-patches-return-3980-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32659 invoked by alias); 30 Jun 2003 17:38:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32649 invoked from network); 30 Jun 2003 17:38:02 -0000
X-Originating-IP: [68.80.118.176]
X-Originating-Email: [rkitover@hotmail.com]
From: "Rafael Kitover" <caelum@debian.org>
To: <cygwin-patches@cygwin.com>
Subject: Re: EIO error on background tty reads
Date: Mon, 30 Jun 2003 17:38:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <Law9-OE29YTjr8cU6xf000481f2@hotmail.com>
X-OriginalArrivalTime: 30 Jun 2003 17:38:01.0805 (UTC) FILETIME=[5AA0F7D0:01C33F2E]
X-SW-Source: 2003-q2/txt/msg00207.txt.bz2

>This isn't a cygwin internals special case knowledge type of thing.  A grep
>of cygwin sources shows that bg_check is called with one of two arguments:
>either SIGTTOU or SIGTTIN is used.  So, your change effectively makes the
>final "goto seEIO" a no-op since it specifically checks for both inputs and
>bypasses the final goto.
>
>Sorry, but if this fixes the problem it is a band-aid.
>
>cgf

Sorry about previous email, mouse slipped...

Here's what I understand the fhandler_termios::bg_check method to do:

bg_check_types
fhandler_termios::bg_check (int sig)
{
  if (!myself->pgid || tc->getpgid () == myself->pgid ||
        myself->ctty != tc->ntty ||
        ((sig == SIGTTOU) && !(tc->ti.c_lflag & TOSTOP)))
    return bg_ok;

If the terminal GID is the reading/writing process's GID, or the process's
controlling terminal is not the target tty, or the terminal is being written
to and
it is not stopped (ie, with ctrl+s); then return ok.

  if (pgid_gone)
    goto setEIO;

Raise an error if the process group is gone.

  else if (!sigs_ignored)
    /* nothing */;

If the signal in question, either SIGTTOU or SIGTTIN is not ignored by the
process
requesting the IO, then fall through the if and send the signal to the
process.

  else if (sig == SIGTTOU)
    return bg_ok;               /* Just allow the output */

If all the other conditions are met, and a background write to a terminal is
requested
by a process that has SIGTTOU ignored, allow the write anyway.

  else
    goto setEIO;        /* This is an output error */

This case is only reached if the signal passed to bg_check was SIGTTIN,
there is no
condition to otherwise disallow a background read from a tty, but the
process
requesting the read has SIGTTIN ignored.

The comment says that this is an output error, but in this case input is
being requested.

What I don't understand is if a background write to a terminal without
sending a
SIGTTOU which it explicitly ignores is allowed, why not a background read?

This is what I propose:

Index: cygwin/fhandler_termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.46
diff -u -p -r1.46 fhandler_termios.cc
--- cygwin/fhandler_termios.cc  16 Jun 2003 03:24:10 -0000      1.46
+++ cygwin/fhandler_termios.cc  30 Jun 2003 16:45:35 -0000
@@ -160,10 +160,8 @@ fhandler_termios::bg_check (int sig)
     goto setEIO;
   else if (!sigs_ignored)
     /* nothing */;
-  else if (sig == SIGTTOU)
-    return bg_ok;              /* Just allow the output */
   else
-    goto setEIO;       /* This is an output error */
+    return bg_ok;              /* Just allow the output or input */

   /* Don't raise a SIGTT* signal if we have already been interrupted
      by another signal. */
