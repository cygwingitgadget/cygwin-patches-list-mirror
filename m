Return-Path: <cygwin-patches-return-6921-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2132 invoked by alias); 15 Jan 2010 20:05:22 -0000
Received: (qmail 2120 invoked by uid 22791); 15 Jan 2010 20:05:20 -0000
X-SWARE-Spam-Status: No, hits=4.3 required=5.0 	tests=BAYES_20,BOTNET
X-Spam-Check-By: sourceware.org
Received: from vms173003pub.verizon.net (HELO vms173003pub.verizon.net) (206.46.173.3)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 15 Jan 2010 20:05:15 +0000
Received: from PHUMBLETLAPXP ([unknown] [131.239.32.100])  by vms173003.mailsrvcs.net  (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))  with ESMTPA id <0KWB00E5C13RDWG0@vms173003.mailsrvcs.net> for  cygwin-patches@cygwin.com; Fri, 15 Jan 2010 14:04:52 -0600 (CST)
Message-id: <036301ca961d$f1898520$870410ac@wirelessworld.airvananet.com>
From: "Pierre A. Humblet" <phumblet@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
References: <20100113212537.GB14511@calimero.vinschen.de>  <4B4E96D3.90300@byu.net>  <20100114114700.GC3428@calimero.vinschen.de>  <20100114115711.GD3428@calimero.vinschen.de>  <4B4F15FB.1050309@byu.net>  <20100114131744.GA26286@calimero.vinschen.de>  <0KW8000XUOMKUEK7@vms173003.mailsrvcs.net>  <20100114160953.GB26286@calimero.vinschen.de>  <20100115154203.GA5885@calimero.vinschen.de>
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Date: Fri, 15 Jan 2010 20:05:00 -0000
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
X-SW-Source: 2010-q1/txt/msg00037.txt.bz2

----- Original Message ----- 
From: "Corinna Vinschen" 
To: <cygwin-patches>
Sent: Friday, January 15, 2010 10:42

| On Jan 14 17:09, Corinna Vinschen wrote:
| > On Jan 14 08:39, Pierre A. Humblet wrote:
| > > 
| > > For the same reason we should also have SOCK_CLOEXEC, and
| > > SOCK_NONBLOCK while we are at it. I would use them in minires.
| > 
| > Sure, but probably not yet, as far as my hack time is concerned.  But
| > of course SHTDI, PTC, and all that.  I'd be glad for it, actually.
| 
| It was simpler than I anticipated.  I just applied a patch to implement
| accept4, and SOCK_NONBLOCK as well as SOCK_CLOEXEC for socket,
| socketpair and accept4.
 
Thanks, I was just looking into that.
I see an issue with accept/accept4 and was going to ask you how to handle it.

Before your changes in Cygwin the socket returned by accept had the same blocking
(and async) property as the listening socket.
Apparently this conforms to BSD but not to Linux (even old versions without accept4),
http://www.kernel.org/doc/man-pages/online/pages/man2/accept.2.html
POSIX is silent on the topic.

After your changes the new socket is non-blocking if either the listening socket was
non-blocking or SOCK_NONBLOCK is specified. This does not conform to Linux.

Why not have accept4 conform to Linux but keep the old behavior of accept by
changing accept in net.cc to 
res = fh->accept4 (peer, len, fh->is_nonblocking () ? SOCK_NONBLOCK : 0);

There is a similar Linux discrepancy with async_io. 

Pierre
