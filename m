Return-Path: <cygwin-patches-return-5686-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13056 invoked by alias); 7 Dec 2005 21:19:17 -0000
Received: (qmail 13045 invoked by uid 22791); 7 Dec 2005 21:19:16 -0000
X-Spam-Check-By: sourceware.org
Received: from nproxy.gmail.com (HELO nproxy.gmail.com) (64.233.182.206)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 07 Dec 2005 21:19:14 +0000
Received: by nproxy.gmail.com with SMTP id o25so150871nfa         for <cygwin-patches@cygwin.com>; Wed, 07 Dec 2005 13:19:12 -0800 (PST)
Received: by 10.49.41.2 with SMTP id t2mr127310nfj;         Wed, 07 Dec 2005 13:19:12 -0800 (PST)
Received: by 10.49.3.12 with HTTP; Wed, 7 Dec 2005 13:19:12 -0800 (PST)
Message-ID: <80fd4e750512071319r4ae0bc2fj9c0fb5b9e29c398f@mail.gmail.com>
Date: Wed, 07 Dec 2005 21:19:00 -0000
From: Pekka Pessi <ppessi@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [patch] Handling non-winsock flags in fhandler_socket.cc
MIME-Version: 1.0
Content-Type: multipart/mixed;  	boundary="----=_Part_6046_1783718.1133990352233"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00028.txt.bz2

------=_Part_6046_1783718.1133990352233
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-length: 440

Hello,

 I found a problem with sendmsg() failng when MSG_NOSIGNAL is used. It
looks like MSG_WINMASK is used in sendto() but not in sendmsg().

The patch that should fix the problem is made against
fhandler_socket.cc revision 1.176 ("should" because I did not get
around to compile the whole shebang). It clears extra flags when
calling ws2 functions in all cases of sendmsg(), recvmsg() and
recvfrom().

--
Pekka.Pessi@{nokia.com,iki.fi}

------=_Part_6046_1783718.1133990352233
Content-Type: text/x-patch; name=sendmsg-flags.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sendmsg-flags.patch"
Content-length: 1726

--- fhandler_socket.cc.virgin	2005-12-07 16:54:41.888415954 +0200
+++ fhandler_socket.cc	2005-12-07 16:58:43.031808869 +0200
@@ -1041,7 +1041,7 @@ fhandler_socket::recvfrom (void *ptr, si
 	{
 	  do
 	    {
-	      DWORD lflags = (DWORD) flags;
+	      DWORD lflags = (DWORD) (MSG_WINMASK & flags);
 	      res = WSARecvFrom (get_socket (), &wsabuf, 1, &ret, &lflags,
 				 from, fromlen, NULL, NULL);
 	    }
@@ -1118,8 +1118,9 @@ fhandler_socket::recvmsg (struct msghdr 
   DWORD ret = 0;
 
   if (is_nonblocking () || closed () || async_io ())
+    DWORD lflags = (DWORD) (MSG_WINMASK & flags);
     res = WSARecvFrom (get_socket (), wsabuf, iovcnt, &ret,
-		       (DWORD *) &flags, from, fromlen, NULL, NULL);
+		       &lflags, from, fromlen, NULL, NULL);
   else
     {
       HANDLE evt;
@@ -1127,7 +1128,7 @@ fhandler_socket::recvmsg (struct msghdr 
 	{
 	  do
 	    {
-	      DWORD lflags = (DWORD) flags;
+	      DWORD lflags = (DWORD) (MSG_WINMASK & flags);
 	      res = WSARecvFrom (get_socket (), wsabuf, iovcnt, &ret,
 				 &lflags, from, fromlen, NULL, NULL);
 	    }
@@ -1271,7 +1272,7 @@ fhandler_socket::sendmsg (const struct m
 
   if (is_nonblocking () || closed () || async_io ())
     res = WSASendTo (get_socket (), wsabuf, iovcnt, &ret,
-		     flags, (struct sockaddr *) msg->msg_name,
+		     flags & MSG_WINMASK, (struct sockaddr *) msg->msg_name,
 		     msg->msg_namelen, NULL, NULL);
   else
     {
@@ -1281,7 +1282,7 @@ fhandler_socket::sendmsg (const struct m
 	  do
 	    {
 	      res = WSASendTo (get_socket (), wsabuf, iovcnt,
-			       &ret, flags,
+			       &ret, flags & MSG_WINMASK,
 			       (struct sockaddr *) msg->msg_name,
 			       msg->msg_namelen, NULL, NULL);
 	    }




------=_Part_6046_1783718.1133990352233--
