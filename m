Return-Path: <cygwin-patches-return-3981-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8147 invoked by alias); 30 Jun 2003 17:55:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8133 invoked from network); 30 Jun 2003 17:55:36 -0000
Date: Mon, 30 Jun 2003 17:55:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: EIO error on background tty reads
Message-ID: <20030630175536.GA31655@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Law9-OE29YTjr8cU6xf000481f2@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law9-OE29YTjr8cU6xf000481f2@hotmail.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00208.txt.bz2

On Mon, Jun 30, 2003 at 01:37:47PM -0400, Rafael Kitover wrote:
>  else
>    goto setEIO;        /* This is an output error */
>
>This case is only reached if the signal passed to bg_check was SIGTTIN,
>there is no condition to otherwise disallow a background read from a
>tty, but the process requesting the read has SIGTTIN ignored.

Right.  Good analysis.  I noticed the comment was wrong yesterday but I
haven't fixed it yet.

>The comment says that this is an output error, but in this case input is
>being requested.
>
>What I don't understand is if a background write to a terminal without
>sending a
>SIGTTOU which it explicitly ignores is allowed, why not a background read?

Because that's the way it works.  Have you tried this with linux?  I wrote
a test case yesterday.  linux raises an EIO when a background read is
attempted, SIGTTIN is ignored, and the process is not a member of the
terminal's process group.  Test case below.

>This is what I propose:
>
>Index: cygwin/fhandler_termios.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
>retrieving revision 1.46
>diff -u -p -r1.46 fhandler_termios.cc
>--- cygwin/fhandler_termios.cc  16 Jun 2003 03:24:10 -0000      1.46
>+++ cygwin/fhandler_termios.cc  30 Jun 2003 16:45:35 -0000
>@@ -160,10 +160,8 @@ fhandler_termios::bg_check (int sig)
>     goto setEIO;
>   else if (!sigs_ignored)
>     /* nothing */;
>-  else if (sig == SIGTTOU)
>-    return bg_ok;              /* Just allow the output */
>   else
>-    goto setEIO;       /* This is an output error */
>+    return bg_ok;              /* Just allow the output or input */
>
>   /* Don't raise a SIGTT* signal if we have already been interrupted
>      by another signal. */

I don't think this would satisfy the requirement that an EIO be sent
for the above scenario.

cgf

#include <stdio.h>
#include <signal.h>
#include <errno.h>

int
main (int argc, char **argv)
{
  setbuf (stdout, NULL);
  if (fork () == 0)
    {
      char buf[10];
      setpgrp (getpid ());
      signal (SIGTTIN, SIG_IGN);
      puts ("reading");
      printf ("%d = read\n", read (0, buf, 10));
      printf ("errno %d\n", errno);
      perror ("");
      exit (0);
    }
  sleep (4);
}
