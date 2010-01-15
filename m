Return-Path: <cygwin-patches-return-6924-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27369 invoked by alias); 15 Jan 2010 21:33:52 -0000
Received: (qmail 27358 invoked by uid 22791); 15 Jan 2010 21:33:51 -0000
X-SWARE-Spam-Status: No, hits=3.3 required=5.0 	tests=AWL,BAYES_00,BOTNET
X-Spam-Check-By: sourceware.org
Received: from vms173003pub.verizon.net (HELO vms173003pub.verizon.net) (206.46.173.3)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 15 Jan 2010 21:33:47 +0000
Received: from PHUMBLETLAPXP ([unknown] [131.239.32.100])  by vms173003.mailsrvcs.net  (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))  with ESMTPA id <0KWB007ML57JH7H0@vms173003.mailsrvcs.net> for  cygwin-patches@cygwin.com; Fri, 15 Jan 2010 15:33:37 -0600 (CST)
Message-id: <039001ca962a$5eaf9ac0$870410ac@wirelessworld.airvananet.com>
From: "Pierre A. Humblet" <phumblet@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
References: <4B4E96D3.90300@byu.net>  <20100114114700.GC3428@calimero.vinschen.de>  <20100114115711.GD3428@calimero.vinschen.de>  <4B4F15FB.1050309@byu.net>  <20100114131744.GA26286@calimero.vinschen.de>  <0KW8000XUOMKUEK7@vms173003.mailsrvcs.net>  <20100114160953.GB26286@calimero.vinschen.de>  <20100115154203.GA5885@calimero.vinschen.de>  <036301ca961d$f1898520$870410ac@wirelessworld.airvananet.com>  <20100115202247.GG4977@calimero.vinschen.de>  <20100115203427.GH4977@calimero.vinschen.de>
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Date: Fri, 15 Jan 2010 21:33:00 -0000
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00040.txt.bz2


----- Original Message ----- 
From: "Corinna Vinschen"
To: <cygwin-patches>
Sent: Friday, January 15, 2010 15:34


| On Jan 15 21:22, Corinna Vinschen wrote:
| > On Jan 15 15:04, Pierre A. Humblet wrote:
| > > I see an issue with accept/accept4 and was going to ask you how to
| > > handle it.
| > >
| > > Before your changes in Cygwin the socket returned by accept had the
| > > same blocking (and async) property as the listening socket.
| > > Apparently this conforms to BSD but not to Linux (even old versions
| > > without accept4),
| > > http://www.kernel.org/doc/man-pages/online/pages/man2/accept.2.html
| > > POSIX is silent on the topic.
| > >
| > > After your changes the new socket is non-blocking if either the
| > > listening socket was non-blocking or SOCK_NONBLOCK is specified. This
| > > does not conform to Linux.
| > >
| > > Why not have accept4 conform to Linux but keep the old behavior of accept by
| > > changing accept in net.cc to
| > > res = fh->accept4 (peer, len, fh->is_nonblocking () ? SOCK_NONBLOCK : 0);
| > >
| > > There is a similar Linux discrepancy with async_io.
| >
| > I have no problem to change the SOCK_NONBLOCK stuff as you proposed.
| >
| > I don't like the idea to introduce such a new flag for ASYNC which
| > doesn't exist on Linux, though.  How important is the async mode anyway?
| > Will we really get any problems with existing apps if we switch to the
| > Linux behaviour for async?
|
| Oh, hang on.  I guess we should better stick to the BSD behaviour.
| Any call to WSAAsyncSelect or WSAEventSelect clears Winsock's internal
| network event queue.  This could lead to connection errors.  Given
| that, the switch to a specific mode should stay the responsibility
| of the application, shouldn't it?

I know next to nothing about this but notice that :accept4 calls fdsock
which calls init_events which calls WSAEventSelect .
Isn't that what you want to avoid?
On the other hand I don't see how you can avoid it given this:

Any WSAEventSelect association and network events selection set for the listening socket apply 
to the accepted socket. For example, if a listening socket has WSAEventSelect association of 
hEventObject with FD_ACCEPT, FD_READ, and FD_WRITE, then any socket accepted on that listening 
socket will also have FD_ACCEPT, FD_READ, and FD_WRITE network events associated with the same 
hEventObject. If a different hEventObject or network events are desired, the application should 
call WSAEventSelect, passing the accepted socket and the desired new information.

Pierre


