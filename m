Return-Path: <cygwin-patches-return-4843-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1720 invoked by alias); 23 Jun 2004 02:56:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1705 invoked from network); 23 Jun 2004 02:56:48 -0000
Message-Id: <3.0.5.32.20040622225313.008093a0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 23 Jun 2004 02:56:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: rlogin problems
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00195.txt.bz2


2004-06-23  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler_socket.cc (fhandler_socket::release): Call
	WSASetLastError last.


Index: fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.138
diff -u -p -r1.138 fhandler_socket.cc
--- fhandler_socket.cc  28 May 2004 19:50:05 -0000      1.138
+++ fhandler_socket.cc  23 Jun 2004 02:49:31 -0000
@@ -792,12 +792,12 @@ fhandler_socket::release (HANDLE event)
   int last_err = WSAGetLastError ();
   /* KB 168349: NT4 fails if the event parameter is not NULL. */
   WSAEventSelect (get_socket (), NULL, 0);
+  WSACloseEvent (event);
   unsigned long non_block = 0;
   if (ioctlsocket (get_socket (), FIONBIO, &non_block))
     debug_printf ("return to blocking failed: %d", WSAGetLastError ());
   else
     WSASetLastError (last_err);
-  WSACloseEvent (event);
 }
 
 int
