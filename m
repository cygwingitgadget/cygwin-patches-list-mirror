Return-Path: <cygwin-patches-return-3637-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31878 invoked by alias); 27 Feb 2003 16:45:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31851 invoked from network); 27 Feb 2003 16:45:23 -0000
Date: Thu, 27 Feb 2003 16:45:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: interruptable connect
Message-ID: <20030227164537.GB10601@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0302271616590.314-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0302271616590.314-200000@algeria.intern.net>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00286.txt.bz2

On Thu, Feb 27, 2003 at 04:21:33PM +0100, Thomas Pfaff wrote:
>
>Hi Corinna,
>
>this is a slightly modified version of my proposed solution from
>yesterday. Not tested exhaustiv but seems to work pretty well.

I appreciate the effort that you and Corinna have put into this
very much.

Out of curiousity, is there any way to generalize the (I think) common
code that is now in fhandler_socket::accept and fhandler_socket::connect
into one common function?

cgf

>Thomas
>
>2003-03-27  Thomas Pfaff  <tpfaff@gmx.net>
>
>	* fhandler_socket.cc (fhandler_socket::connect): Add support for
>	an interruptable connect.

>--- fhandler_socket.cc.org	2003-02-27 16:14:49.000000000 +0100
>+++ fhandler_socket.cc	2003-02-27 16:15:59.000000000 +0100
>@@ -431,6 +431,8 @@ out:
> int
> fhandler_socket::connect (const struct sockaddr *name, int namelen)
> {
>+  WSAEVENT ev[2] = { WSA_INVALID_EVENT, signal_arrived };
>+  BOOL interrupted = FALSE;
>   int res = -1;
>   BOOL secret_check_failed = FALSE;
>   BOOL in_progress = FALSE;
>@@ -440,12 +442,63 @@ fhandler_socket::connect (const struct s
>   if (!get_inet_addr (name, namelen, &sin, &namelen, secret))
>     return -1;
> 
>+  if (!is_nonblocking () && !is_connect_pending ())
>+    {
>+      ev[0] = WSACreateEvent ();
>+      WSAEventSelect (get_socket (), ev[0], FD_CONNECT);
>+    }
>+
>   res = ::connect (get_socket (), (sockaddr *) &sin, namelen);
>+  if (res && !is_nonblocking () && !is_connect_pending () &&
>+      WSAGetLastError () == WSAEWOULDBLOCK)
>+    {
>+
>+      WSANETWORKEVENTS sock_event;
>+      int wait_result;
>+
>+      wait_result = WSAWaitForMultipleEvents (2, ev, FALSE, WSA_INFINITE, FALSE);
>+
>+      if (wait_result == WSA_WAIT_EVENT_0)
>+        WSAEnumNetworkEvents (get_socket (), ev[0], &sock_event);
>+
>+      /* Unset events for connecting socket and
>+         switch back to blocking mode */
>+      WSAEventSelect (get_socket (), ev[0], 0);
>+      unsigned long nonblocking = 0;
>+      ioctlsocket (get_socket (), FIONBIO, &nonblocking);
>+
>+      switch (wait_result)
>+        {
>+        case WSA_WAIT_EVENT_0:
>+          if (sock_event.lNetworkEvents & FD_CONNECT)
>+            {
>+              if (sock_event.iErrorCode[FD_CONNECT_BIT])
>+                WSASetLastError (sock_event.iErrorCode[FD_CONNECT_BIT]);
>+              else
>+                res = 0;
>+            }
>+          /* else; : Should never happen since FD_CONNECT is the only
>+             event that has been selected */
>+          break;
>+
>+        case WSA_WAIT_EVENT_0 + 1:
>+          debug_printf ("signal received during connect");
>+          WSASetLastError (WSAEINPROGRESS);
>+          interrupted = TRUE;
>+          break;
>+
>+        case WSA_WAIT_FAILED:
>+        default: /* Should never happen */
>+          WSASetLastError (WSAEFAULT);
>+          break;
>+        }
>+    }
>+
>   if (res)
>     {
>       /* Special handling for connect to return the correct error code
> 	 when called on a non-blocking socket. */
>-      if (is_nonblocking ())
>+      if (is_nonblocking () || is_connect_pending ())
> 	{
> 	  DWORD err = WSAGetLastError ();
> 	  if (err == WSAEWOULDBLOCK || err == WSAEALREADY)
>@@ -493,6 +546,13 @@ fhandler_socket::connect (const struct s
>     set_connect_state (CONNECT_PENDING);
>   else
>     set_connect_state (CONNECTED);
>+
>+  if (ev[0] != WSA_INVALID_EVENT)
>+    WSACloseEvent (ev[0]);
>+
>+  if (interrupted)
>+    set_errno (EINTR);
>+
>   return res;
> }
> 
