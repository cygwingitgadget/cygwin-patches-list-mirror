Return-Path: <cygwin-patches-return-3679-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18005 invoked by alias); 11 Mar 2003 01:08:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17989 invoked from network); 11 Mar 2003 01:08:10 -0000
Message-Id: <3.0.5.32.20030310200902.007f3100@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Tue, 11 Mar 2003 01:08:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: fhandler_socket::dup
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00328.txt.bz2

Corinna,

Here is a patch to have fhandler_socket::dup return success
or failure (related to the problem seen by Jason Tishler).

Pierre

2003-03-11  Pierre Humblet  <pierre.humblet@ieee.org>

	* fhandler_socket.cc (fhandler_socket::fixup_after_fork):
	Set io_handle to INVALID_SOCKET in case of failure.
	(fhandler_socket::dup): Return 0 iff the io_handle is valid.


Index: fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.86
diff -u -p -r1.86 fhandler_socket.cc
--- fhandler_socket.cc  9 Mar 2003 20:31:07 -0000       1.86
+++ fhandler_socket.cc  11 Mar 2003 00:21:18 -0000
@@ -344,6 +344,7 @@ fhandler_socket::fixup_after_fork (HANDL
                                   prot_info_ptr, 0, 0)) == INVALID_SOCKET)
     {
       debug_printf ("WSASocket error");
+      set_io_handle ((HANDLE) new_sock);
       set_winsock_errno ();
     }
   else if (!new_sock && !winsock2_active)
@@ -389,7 +390,7 @@ fhandler_socket::dup (fhandler_base *chi
   if (winsock2_active)
     {
       fhs->fixup_after_fork (hMainProc);
-      return 0;
+      return get_io_handle () == (HANDLE) INVALID_SOCKET;
     }
   return fhandler_base::dup (child);
 }
