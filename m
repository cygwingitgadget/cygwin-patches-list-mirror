Return-Path: <cygwin-patches-return-6926-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20325 invoked by alias); 15 Jan 2010 22:53:18 -0000
Received: (qmail 20311 invoked by uid 22791); 15 Jan 2010 22:53:18 -0000
X-SWARE-Spam-Status: No, hits=4.1 required=5.0 	tests=AWL,BAYES_40,BOTNET
X-Spam-Check-By: sourceware.org
Received: from vms173013pub.verizon.net (HELO vms173013pub.verizon.net) (206.46.173.13)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 15 Jan 2010 22:53:13 +0000
Received: from PHUMBLETLAPXP ([unknown] [131.239.32.100])  by vms173013.mailsrvcs.net  (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))  with ESMTPA id <0KWB008318W7QTE0@vms173013.mailsrvcs.net> for  cygwin-patches@cygwin.com; Fri, 15 Jan 2010 16:53:08 -0600 (CST)
Message-id: <03ad01ca9635$788f70e0$870410ac@wirelessworld.airvananet.com>
From: "Pierre A. Humblet" <phumblet@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
References: <20100114115711.GD3428@calimero.vinschen.de>  <4B4F15FB.1050309@byu.net>  <20100114131744.GA26286@calimero.vinschen.de>  <0KW8000XUOMKUEK7@vms173003.mailsrvcs.net>  <20100114160953.GB26286@calimero.vinschen.de>  <20100115154203.GA5885@calimero.vinschen.de>  <036301ca961d$f1898520$870410ac@wirelessworld.airvananet.com>  <20100115202247.GG4977@calimero.vinschen.de>  <20100115203427.GH4977@calimero.vinschen.de>  <039001ca962a$5eaf9ac0$870410ac@wirelessworld.airvananet.com>  <20100115220315.GJ4977@calimero.vinschen.de>
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Date: Fri, 15 Jan 2010 22:53:00 -0000
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
X-SW-Source: 2010-q1/txt/msg00042.txt.bz2

----- Original Message ----- 
From: "Corinna Vinschen"
To: <cygwin-patches>
Sent: Friday, January 15, 2010 17:03


| On Jan 15 16:33, Pierre A. Humblet wrote:
| > From: "Corinna Vinschen"
| > | Oh, hang on.  I guess we should better stick to the BSD behaviour.
| > | Any call to WSAAsyncSelect or WSAEventSelect clears Winsock's internal
| > | network event queue.  This could lead to connection errors.  Given
| > | that, the switch to a specific mode should stay the responsibility
| > | of the application, shouldn't it?
| >
| > I know next to nothing about this but notice that :accept4 calls fdsock
| > which calls init_events which calls WSAEventSelect .
| > Isn't that what you want to avoid?
|
| Oh, right.  I'm wondering how this is supposed to work at all in
| WinSock, if an application is using, say, blocking listening sockets and
| only wants to use event driven IO on the accepted sockets.  It looks
| like this is impossible without the danger of losing information.  In
| theory, if the peer sends exactly one packet, the accepting socket could
| wait forever for the packet if it arrived before WSAEventSelect has been
| called.  The FD_READ will never show up.  The alternative is I'm just
| exaggerating the potential problem.  I don't know.
|
| > On the other hand I don't see how you can avoid it given this:
| >
| > Any WSAEventSelect association and network events selection set for the listening socket 
apply
| > to the accepted socket. For example, if a listening socket has WSAEventSelect association of
| > hEventObject with FD_ACCEPT, FD_READ, and FD_WRITE, then any socket accepted on that 
listening
| > socket will also have FD_ACCEPT, FD_READ, and FD_WRITE network events associated with the 
same
| > hEventObject. If a different hEventObject or network events are desired, the application 
should
| > call WSAEventSelect, passing the accepted socket and the desired new information.
|
| The event mask is not the problem since the mask given to WSAEventSelect
| is always the same in Cygwin, the whole set, regardless of how the
| socket is used.  The problem is that every socket needs its own
| event object so WSAEventSelect has to be called anyway.

I agree. It would be nice if the new event could be initialized to the value of the old.
Then we could have too many events for the new socket, but that's OK.

I am also wondering if we are misreading the doc. It says:
For FD_READ, FD_OOB, and FD_ACCEPT network events, network event recording
and event object signaling are level-triggered.
and it goes on to provide an example where the event is reenabled if there is still data.
The example given about the "clears the internal network event record" is of a
completely different nature.
The scenario you describe (one packet only, with a long delay between accept
and WSAEventSelect) could easily be tested to settle the matter.
Put a sleep before fdsock !

| What this means is, the accepted socket isn't in async mode anymore
| since the WSAEventSelect call in init_events has ended it.  So the async
| flag is erroneously preserved and we will have to apply this patch AFAICS.

At least we follow Linux :)

Pierre

