Return-Path: <cygwin-patches-return-5180-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8209 invoked by alias); 4 Dec 2004 16:50:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8156 invoked from network); 4 Dec 2004 16:50:29 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.190.188)
  by sourceware.org with SMTP; 4 Dec 2004 16:50:29 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I87IXW-001SEZ-AU
	for cygwin-patches@cygwin.com; Sat, 04 Dec 2004 11:53:56 -0500
Message-Id: <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 04 Dec 2004 16:50:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041204054348.GA14532@trixie.casa.cgf.cx>
References: <3.0.5.32.20041202211311.00820770@incoming.verizon.net>
 <20041120062339.GA31757@trixie.casa.cgf.cx>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
 <20041114051158.GG7554@trixie.casa.cgf.cx>
 <20041116054156.GA17214@trixie.casa.cgf.cx>
 <419A1F7B.8D59A9C9@phumblet.no-ip.org>
 <20041116155640.GA22397@trixie.casa.cgf.cx>
 <20041120062339.GA31757@trixie.casa.cgf.cx>
 <3.0.5.32.20041202211311.00820770@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1102196728==_"
X-SW-Source: 2004-q4/txt/msg00181.txt.bz2

--=====================_1102196728==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 371

At 12:43 AM 12/4/2004 -0500, Christopher Faylor wrote:
>
>I wrote a simple test case to check this and I don't see it -- on XP.  I
>can't easily run Me anymore.  Does the attached program demonstrate this
>behavior when you run it?  It should re-exec itself every time you hit
>CTRL-C.

That test case has no problem, but the attached one does. 
Use kill -30 pid

Pierre

--=====================_1102196728==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="execit3.c"
Content-length: 365

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/signal.h>

void ouch (int sig)
{
  printf ("got signal %d\n", sig);
  return;
}

int
main (int argc, char **argv)
{
  if (getppid() != 1 && fork())
    exit(0);
  signal (SIGUSR1, ouch);
  while (pause ())
    {
      puts ("execing myself");
      execv (argv[0], argv);
    }
  exit (0);
}

--=====================_1102196728==_--
