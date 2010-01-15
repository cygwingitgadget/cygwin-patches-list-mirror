Return-Path: <cygwin-patches-return-6925-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27593 invoked by alias); 15 Jan 2010 22:03:31 -0000
Received: (qmail 27327 invoked by uid 22791); 15 Jan 2010 22:03:30 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 15 Jan 2010 22:03:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E39BC6D4190; Fri, 15 Jan 2010 23:03:15 +0100 (CET)
Date: Fri, 15 Jan 2010 22:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100115220315.GJ4977@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100114115711.GD3428@calimero.vinschen.de>  <4B4F15FB.1050309@byu.net>  <20100114131744.GA26286@calimero.vinschen.de>  <0KW8000XUOMKUEK7@vms173003.mailsrvcs.net>  <20100114160953.GB26286@calimero.vinschen.de>  <20100115154203.GA5885@calimero.vinschen.de>  <036301ca961d$f1898520$870410ac@wirelessworld.airvananet.com>  <20100115202247.GG4977@calimero.vinschen.de>  <20100115203427.GH4977@calimero.vinschen.de>  <039001ca962a$5eaf9ac0$870410ac@wirelessworld.airvananet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039001ca962a$5eaf9ac0$870410ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00041.txt.bz2

On Jan 15 16:33, Pierre A. Humblet wrote:
> From: "Corinna Vinschen"
> | Oh, hang on.  I guess we should better stick to the BSD behaviour.
> | Any call to WSAAsyncSelect or WSAEventSelect clears Winsock's internal
> | network event queue.  This could lead to connection errors.  Given
> | that, the switch to a specific mode should stay the responsibility
> | of the application, shouldn't it?
> 
> I know next to nothing about this but notice that :accept4 calls fdsock
> which calls init_events which calls WSAEventSelect .
> Isn't that what you want to avoid?

Oh, right.  I'm wondering how this is supposed to work at all in
WinSock, if an application is using, say, blocking listening sockets and
only wants to use event driven IO on the accepted sockets.  It looks
like this is impossible without the danger of losing information.  In
theory, if the peer sends exactly one packet, the accepting socket could
wait forever for the packet if it arrived before WSAEventSelect has been
called.  The FD_READ will never show up.  The alternative is I'm just
exaggerating the potential problem.  I don't know.

> On the other hand I don't see how you can avoid it given this:
> 
> Any WSAEventSelect association and network events selection set for the listening socket apply 
> to the accepted socket. For example, if a listening socket has WSAEventSelect association of 
> hEventObject with FD_ACCEPT, FD_READ, and FD_WRITE, then any socket accepted on that listening 
> socket will also have FD_ACCEPT, FD_READ, and FD_WRITE network events associated with the same 
> hEventObject. If a different hEventObject or network events are desired, the application should 
> call WSAEventSelect, passing the accepted socket and the desired new information.

The event mask is not the problem since the mask given to WSAEventSelect
is always the same in Cygwin, the whole set, regardless of how the
socket is used.  The problem is that every socket needs its own
event object so WSAEventSelect has to be called anyway.

What this means is, the accepted socket isn't in async mode anymore
since the WSAEventSelect call in init_events has ended it.  So the async
flag is erroneously preserved and we will have to apply this patch AFAICS.

Index: fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.258
diff -u -p -r1.258 fhandler_socket.cc
--- fhandler_socket.cc	15 Jan 2010 21:34:27 -0000	1.258
+++ fhandler_socket.cc	15 Jan 2010 22:00:08 -0000
@@ -1216,7 +1216,7 @@ fhandler_socket::accept4 (struct sockadd
 	  fhandler_socket *sock = (fhandler_socket *) res_fd;
 	  sock->set_addr_family (get_addr_family ());
 	  sock->set_socket_type (get_socket_type ());
-	  sock->async_io (async_io ());
+	  sock->async_io (false); /* fdsock switches async mode off. */
 	  if (get_addr_family () == AF_LOCAL)
 	    {
 	      sock->set_sun_path (get_sun_path ());


Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
