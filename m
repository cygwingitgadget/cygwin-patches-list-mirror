Return-Path: <cygwin-patches-return-6927-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19426 invoked by alias); 18 Jan 2010 03:35:51 -0000
Received: (qmail 19416 invoked by uid 22791); 18 Jan 2010 03:35:50 -0000
X-SWARE-Spam-Status: Yes, hits=5.0 required=5.0 	tests=BAYES_50,BOTNET
X-Spam-Check-By: sourceware.org
Received: from vms173003pub.verizon.net (HELO vms173003pub.verizon.net) (206.46.173.3)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 18 Jan 2010 03:35:46 +0000
Received: from pool-68-239-42-250.bos.east.verizon.net  ([unknown] [68.239.42.250]) by vms173003.mailsrvcs.net  (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))  with ESMTPA id <0KWF00L0DBBHWK15@vms173003.mailsrvcs.net> for  cygwin-patches@cygwin.com; Sun, 17 Jan 2010 21:35:42 -0600 (CST)
Message-id: <0KWF00L0JBBIWK15@vms173003.mailsrvcs.net>
Date: Mon, 18 Jan 2010 03:35:00 -0000
To: <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <phumblet@phumblet.no-ip.org>
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
In-reply-to: <03ad01ca9635$788f70e0$870410ac@wirelessworld.airvananet.co m>
References: <20100114115711.GD3428@calimero.vinschen.de>  <4B4F15FB.1050309@byu.net> <20100114131744.GA26286@calimero.vinschen.de>  <0KW8000XUOMKUEK7@vms173003.mailsrvcs.net>  <20100114160953.GB26286@calimero.vinschen.de>  <20100115154203.GA5885@calimero.vinschen.de>  <036301ca961d$f1898520$870410ac@wirelessworld.airvananet.com>  <20100115202247.GG4977@calimero.vinschen.de>  <20100115203427.GH4977@calimero.vinschen.de>  <039001ca962a$5eaf9ac0$870410ac@wirelessworld.airvananet.com>  <20100115220315.GJ4977@calimero.vinschen.de>  <03ad01ca9635$788f70e0$870410ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
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
X-SW-Source: 2010-q1/txt/msg00043.txt.bz2

At 05:52 PM 1/15/2010, Pierre A. Humblet wrote:

>The scenario you describe (one packet only, with a long delay between accept
>and WSAEventSelect) could easily be tested to settle the matter.
>Put a sleep before fdsock !

To close the matter, I have done just that, putting a 60 s sleep in 
:accept4 between the call to Windows accept and fdsock. Packet 
doesn't get lost :)
Server:
2010_1_17.22:31:41 Listening
2010_1_17.22:32:43 Accepted
2010_1_17.22:32:43 Read 6 hello
Client:
2010_1_17.22:31:43 Connecting to localhost
2010_1_17.22:31:43 Connected to localhost
2010_1_17.22:31:43 Written 6 hello
2010_1_17.22:32:58 Exiting

Pierre
