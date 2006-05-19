Return-Path: <cygwin-patches-return-5851-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8386 invoked by alias); 19 May 2006 15:19:49 -0000
Received: (qmail 8376 invoked by uid 22791); 19 May 2006 15:19:49 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.183)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 19 May 2006 15:19:47 +0000
Received: by py-out-1112.google.com with SMTP id o67so910822pye         for <cygwin-patches@cygwin.com>; Fri, 19 May 2006 08:19:45 -0700 (PDT)
Received: by 10.35.78.9 with SMTP id f9mr2171006pyl;         Fri, 19 May 2006 08:19:45 -0700 (PDT)
Received: by 10.35.9.14 with HTTP; Fri, 19 May 2006 08:19:45 -0700 (PDT)
Message-ID: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com>
Date: Fri, 19 May 2006 15:19:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Open sockets non-overlapped?
MIME-Version: 1.0
Content-Type: multipart/mixed;  	boundary="----=_Part_53154_163053.1148051985442"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00039.txt.bz2


------=_Part_53154_163053.1148051985442
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-length: 927

Here's a trivial little patch for your consideration (while I wait for
my copyright assignment to go through).

It makes it so that cygwin sockets can be passed usefully to windows
processes. Eg:
$ cmd /c dir > /dev/tcp/localhost/5001
However, it's not perfect -- if the windows process just exits, then
the connection is reset, not shut down gracefully. Playing with
SO_LINGER doesn't seem to help here. Only way I can think of to make
it work would be to have the cygwin stub that waits for windows
processes to exit, to keep a handle on the socket, poll for when the
windows process closes the socket (using NtQuerySystemInformation
SystemHandleInformation?) and when it does, close down the socket
gracefully.

Anyway, this adds new functionality and doesn't seem to break anything
that worked before.

2006-05-15 Lev Bishop <lev.bishop+cygwin@gmail.com>
=09
	* net.cc (cygwin_socket): Don't open socket for overlapped IO.

------=_Part_53154_163053.1148051985442
Content-Type: text/plain; name=sockpatch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_enennrzg
Content-Disposition: attachment; filename="sockpatch"
Content-length: 594

Index: cygwin/net.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.206
diff -u -p -r1.206 net.cc
--- cygwin/net.cc	5 Apr 2006 16:53:12 -0000	1.206
+++ cygwin/net.cc	19 May 2006 04:24:05 -0000
@@ -578,7 +578,7 @@ cygwin_socket (int af, int type, int pro
 
   debug_printf ("socket (%d, %d, %d)", af, type, protocol);
 
-  soc = socket (AF_INET, type, af == AF_LOCAL ? 0 : protocol);
+  soc = WSASocket (AF_INET, type, af == AF_LOCAL ? 0 : protocol, 0, 0, 0);
 
   if (soc == INVALID_SOCKET)
     {








------=_Part_53154_163053.1148051985442--
