Return-Path: <cygwin-patches-return-4309-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25444 invoked by alias); 23 Oct 2003 22:30:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25435 invoked from network); 23 Oct 2003 22:30:40 -0000
Date: Thu, 23 Oct 2003 22:30:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_tty_slave::ioctl (FIONBIO) return status
Message-ID: <20031023223037.GC14018@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0310231702270.823@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0310231702270.823@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00028.txt.bz2

On Thu, Oct 23, 2003 at 05:14:47PM -0500, Brian Ford wrote:
>I don't really understand the code here in depth, but could someone
>explain to me why the attached trivial patch would'nt fix a minor bug?
>Thanks.
>
>2003-10-23  Brian Ford  <ford@vss.fsi.com>
>
>	* fhandler_tty.c (fhandler_tty_slave::ioctl): Assure correct
>	return value for FIONBIO.

I don't think it makes sense to use get_ttyp ()->ioctl_retval = 0;
here since we aren't actually communicating with the tty.

Does something like this work?

cgf

Index: fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.113
diff -u -p -r1.113 fhandler_tty.cc
--- fhandler_tty.cc	22 Oct 2003 10:07:58 -0000	1.113
+++ fhandler_tty.cc	23 Oct 2003 22:30:15 -0000
@@ -1025,6 +1025,7 @@ fhandler_tty_slave::ioctl (unsigned int 
       raise (SIGTTOU);
     }
 
+  int retval;
   switch (cmd)
     {
     case TIOCGWINSZ:
@@ -1033,6 +1034,7 @@ fhandler_tty_slave::ioctl (unsigned int 
       break;
     case FIONBIO:
       set_nonblocking (*(int *) arg);
+      retval = 0;
       goto out;
     default:
       set_errno (EINVAL);
@@ -1086,9 +1088,9 @@ fhandler_tty_slave::ioctl (unsigned int 
     }
 
   release_output_mutex ();
+  retval = get_ttyp ()->ioctl_retval;
 
 out:
-  int retval = get_ttyp ()->ioctl_retval;
   if (retval < 0)
     {
       set_errno (-retval);
