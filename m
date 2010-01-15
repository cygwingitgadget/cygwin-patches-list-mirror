Return-Path: <cygwin-patches-return-6922-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6194 invoked by alias); 15 Jan 2010 20:23:03 -0000
Received: (qmail 6184 invoked by uid 22791); 15 Jan 2010 20:23:03 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 15 Jan 2010 20:22:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 590436D4190; Fri, 15 Jan 2010 21:22:48 +0100 (CET)
Date: Fri, 15 Jan 2010 20:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100115202247.GG4977@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100113212537.GB14511@calimero.vinschen.de>  <4B4E96D3.90300@byu.net>  <20100114114700.GC3428@calimero.vinschen.de>  <20100114115711.GD3428@calimero.vinschen.de>  <4B4F15FB.1050309@byu.net>  <20100114131744.GA26286@calimero.vinschen.de>  <0KW8000XUOMKUEK7@vms173003.mailsrvcs.net>  <20100114160953.GB26286@calimero.vinschen.de>  <20100115154203.GA5885@calimero.vinschen.de>  <036301ca961d$f1898520$870410ac@wirelessworld.airvananet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <036301ca961d$f1898520$870410ac@wirelessworld.airvananet.com>
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
X-SW-Source: 2010-q1/txt/msg00038.txt.bz2

On Jan 15 15:04, Pierre A. Humblet wrote:
> I see an issue with accept/accept4 and was going to ask you how to
> handle it.
> 
> Before your changes in Cygwin the socket returned by accept had the
> same blocking (and async) property as the listening socket.
> Apparently this conforms to BSD but not to Linux (even old versions
> without accept4),
> http://www.kernel.org/doc/man-pages/online/pages/man2/accept.2.html
> POSIX is silent on the topic.
> 
> After your changes the new socket is non-blocking if either the
> listening socket was non-blocking or SOCK_NONBLOCK is specified. This
> does not conform to Linux.
> 
> Why not have accept4 conform to Linux but keep the old behavior of accept by
> changing accept in net.cc to 
> res = fh->accept4 (peer, len, fh->is_nonblocking () ? SOCK_NONBLOCK : 0);
> 
> There is a similar Linux discrepancy with async_io. 

I have no problem to change the SOCK_NONBLOCK stuff as you proposed.

I don't like the idea to introduce such a new flag for ASYNC which
doesn't exist on Linux, though.  How important is the async mode anyway?
Will we really get any problems with existing apps if we switch to the
Linux behaviour for async?

Index: fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.257
diff -u -p -r1.257 fhandler_socket.cc
--- fhandler_socket.cc  15 Jan 2010 15:40:05 -0000      1.257
+++ fhandler_socket.cc  15 Jan 2010 20:16:56 -0000
@@ -1216,7 +1216,6 @@ fhandler_socket::accept4 (struct sockadd
          fhandler_socket *sock = (fhandler_socket *) res_fd;
          sock->set_addr_family (get_addr_family ());
          sock->set_socket_type (get_socket_type ());
-         sock->async_io (async_io ());
          if (get_addr_family () == AF_LOCAL)
            {
              sock->set_sun_path (get_sun_path ());
@@ -1236,10 +1235,11 @@ fhandler_socket::accept4 (struct sockadd
                    }
                }
            }
-         sock->set_nonblocking (flags & SOCK_NONBLOCK
-                                ? true : is_nonblocking ());
+         sock->set_nonblocking (flags & SOCK_NONBLOCK);
          if (flags & SOCK_CLOEXEC)
            sock->set_close_on_exec (true);
+         WSAEventSelect (sock->get_socket (), wsock_evt, EVENT_MASK);
+         sock->async_io (false);
          /* No locking necessary at this point. */
          sock->wsock_events->events = wsock_events->events | FD_WRITE;
          sock->wsock_events->owner = wsock_events->owner;


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
