Return-Path: <cygwin-patches-return-3977-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32706 invoked by alias); 29 Jun 2003 22:13:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32695 invoked from network); 29 Jun 2003 22:13:07 -0000
Date: Sun, 29 Jun 2003 22:13:00 -0000
From: Christopher Faylor <cgf-rcm@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: EIO error on background tty reads
Message-ID: <20030629221306.GA2167@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Law9-OE43Uu7CmzZazu00052307@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law9-OE43Uu7CmzZazu00052307@hotmail.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00204.txt.bz2

On Sun, Jun 29, 2003 at 11:41:56AM -0400, Rafael Kitover wrote:
>While working on my port of screen for cygwin, I have tracked down the issue
>that did not allow me to reattach detached screens.
>
>A detached screen process owns a certain tty to which the new, attaching
>screen process connects to and reads/writes to.
>
>Recent builds of cygwin return an EIO on a read from the tty, the following
>small change fixes this, but I have to admit that
>this is my first time swimming in the bowels of cygwin itself and I don't
>know if this makes sense or not.

This isn't a cygwin internals special case knowledge type of thing.  A grep
of cygwin sources shows that bg_check is called with one of two arguments:
either SIGTTOU or SIGTTIN is used.  So, your change effectively makes the
final "goto seEIO" a no-op since it specifically checks for both inputs and
bypasses the final goto.

Sorry, but if this fixes the problem it is a band-aid.

cgf

>2003-06-29  Rafael Kitover  <caelum@debian.org>
>
>    * Fix EIO errors on background reads from a tty.
>
>Index: cygwin/fhandler_termios.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
>retrieving revision 1.46
>diff -u -p -r1.46 fhandler_termios.cc
>--- cygwin/fhandler_termios.cc  16 Jun 2003 03:24:10 -0000      1.46
>+++ cygwin/fhandler_termios.cc  29 Jun 2003 14:59:13 -0000
>@@ -160,7 +160,7 @@ fhandler_termios::bg_check (int sig)
>     goto setEIO;
>   else if (!sigs_ignored)
>     /* nothing */;
>-  else if (sig == SIGTTOU)
>+  else if (sig == SIGTTOU || sig == SIGTTIN)
>     return bg_ok;              /* Just allow the output */
>   else
>     goto setEIO;       /* This is an output error */
