Return-Path: <cygwin-patches-return-3696-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12813 invoked by alias); 12 Mar 2003 05:27:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12804 invoked from network); 12 Mar 2003 05:27:45 -0000
Message-Id: <3.0.5.32.20030312001525.007f5310@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Wed, 12 Mar 2003 05:27:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: fhandler_socket::dup
In-Reply-To: <20030311152028.GF13544@cygbert.vinschen.de>
References: <3E6DF617.CA7DC2C0@ieee.org>
 <3.0.5.32.20030310200902.007f3100@mail.attbi.com>
 <20030311102431.GB13544@cygbert.vinschen.de>
 <3E6DF617.CA7DC2C0@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00345.txt.bz2

At 04:20 PM 3/11/2003 +0100, Corinna Vinschen wrote:

>> > I'm seriously concidering to remove all the fixup_before/fixup_after
>> > from fhandler_socket::dup() and just call fhandler_base::dup() on
>> > NT systems.

Corinna,

I like that and I have pushed the logic to also do it on Win9X, without
apparent bad effects. I just delivered 140 e-mails from a WinME to an exim 
server on Win98, ran inetd, ssh, etc... I also tried duping a socket after a 
fork, it worked fine.

The change to the fixup_before/after approach was in Oct 2000. I didn't find
any explanation of the reason for the change in the mail archives around that 
date.

There is no need to include this patch in 1.3.21. I'd like to test it for
a longer period. I hope there are others out there still running the cvs
version and the snapshots on Win9X.

Pierre


2003-03-12  Pierre Humblet  <pierre.humblet@ieee.org>

	* fhandler_socket.cc (fhandler_socket::dup): Always use DuplicateHandle.


Index: fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.88
diff -u -p -r1.88 fhandler_socket.cc
--- fhandler_socket.cc  11 Mar 2003 16:49:58 -0000      1.88
+++ fhandler_socket.cc  12 Mar 2003 04:10:22 -0000
@@ -381,25 +381,10 @@ fhandler_socket::dup (fhandler_base *chi
   debug_printf ("here");
   fhandler_socket *fhs = (fhandler_socket *) child;
   fhs->addr_family = addr_family;
-  fhs->set_io_handle (get_io_handle ());
   if (get_addr_family () == AF_LOCAL)
     fhs->set_sun_path (get_sun_path ());
   fhs->set_socket_type (get_socket_type ());
 
-  /* Using WinSock2 methods for dup'ing sockets seem to collide
-     with user context switches under... some... conditions.  So we
-     drop this for NT systems at all and return to the good ol'
-     DuplicateHandle way of life.  This worked fine all the time on
-     NT anyway and it's even a bit faster. */
-  if (!wincap.has_security ())
-    {
-      fhs->fixup_before_fork_exec (GetCurrentProcessId ());
-      if (winsock2_active)
-       {
-         fhs->fixup_after_fork (hMainProc);
-         return get_io_handle () == (HANDLE) INVALID_SOCKET;
-       }
-    }
   /* We don't call fhandler_base::dup here since that requires to
      have winsock called from fhandler_base and it creates only
      inheritable sockets which is wrong for winsock2. */
