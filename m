Return-Path: <cygwin-patches-return-5363-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16463 invoked by alias); 4 Mar 2005 04:38:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15967 invoked from network); 4 Mar 2005 04:38:22 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.154.17)
  by sourceware.org with SMTP; 4 Mar 2005 04:38:22 -0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.50)
	id ICT8RF-0002HG-63
	for cygwin-patches@cygwin.com; Thu, 03 Mar 2005 23:36:59 -0500
Message-Id: <3.0.5.32.20050303233658.00b50ad0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 04 Mar 2005 04:38:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: fhandler_socket::ioctl
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2005-q1/txt/msg00066.txt.bz2

This patch avoids the unnecessary creation of the win thread in window.cc
It fails to create the invisible window (error 5) when running exim
as a service under a privileged non SYSTEM account (XP home, SP 2).

Pierre

2005-03-04  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler_socket.cc (fhandler_socket::ioctl): Only cancel 
 	 WSAAsyncSelect when async mode is on.


Index: fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.150
diff -u -p -r1.150 fhandler_socket.cc
--- fhandler_socket.cc  28 Feb 2005 13:11:49 -0000      1.150
+++ fhandler_socket.cc  4 Mar 2005 00:32:57 -0000
@@ -1594,7 +1594,7 @@ fhandler_socket::ioctl (unsigned int cmd
       /* We must cancel WSAAsyncSelect (if any) before setting socket to
        * blocking mode
        */
-      if (cmd == FIONBIO && *(int *) p == 0)
+      if (cmd == FIONBIO && async_io () && *(int *) p == 0)
        WSAAsyncSelect (get_socket (), winmsg, 0, 0);
       res = ioctlsocket (get_socket (), cmd, (unsigned long *) p);
       if (res == SOCKET_ERROR)
