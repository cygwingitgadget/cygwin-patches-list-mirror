Return-Path: <cygwin-patches-return-6416-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4949 invoked by alias); 26 Feb 2009 15:30:14 -0000
Received: (qmail 4917 invoked by uid 22791); 26 Feb 2009 15:30:12 -0000
X-SWARE-Spam-Status: No, hits=3.8 required=5.0 	tests=AWL,BAYES_50,BOTNET,J_CHICKENPOX_32
X-Spam-Check-By: sourceware.org
Received: from vms173001pub.verizon.net (HELO vms173001pub.verizon.net) (206.46.173.1)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Feb 2009 15:30:04 +0000
Received: from PHUMBLETLAPXP ([173.9.58.250]) by vms173001.mailsrvcs.net  (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))  with ESMTPA id <0KFO007N8J18UMUJ@vms173001.mailsrvcs.net> for  cygwin-patches@cygwin.com; Thu, 26 Feb 2009 09:29:38 -0600 (CST)
Message-id: <08f301c99827$095c9a20$4e0410ac@wirelessworld.airvananet.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
References: <0KFO009T9G34ZQ6E@vms173009.mailsrvcs.net>
Subject: Re: [Patch] gethostbyname2
Date: Thu, 26 Feb 2009 15:30:00 -0000
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
X-SW-Source: 2009-q1/txt/msg00014.txt.bz2

At 04:52 AM 2/26/2009, Corinna Vinschen wrote:
| >On Feb 25 23:03, Pierre A. Humblet wrote:
| > > I tried to compile Exim with IPv6 enabled and Cygwin 1.7, but it needs
| > > gethostbyname2.
| > > Here is an implementation of that function.
| > > In attachment I am including the same patch as well as a short test function.
| > >
| >
| >This is way cool!  I have this function on my TODO list for ages.
| >
| >But there's a problem.  You're using DnsQuery_A directly, but this
| >function only exists since Win2K.  Would it be a big problem to rework
| >the function to use the resolver functions instead?  They are part of
| >Cygwin now anyway and that would abstract gethostbyname2 from the
| >underlying OS capabilities.

I was afraid of that. Using res_query was my initial thought, but I realized that when using the
Windows resolver I would undo in gethostbyname2 all the work done in minires.

I am wondering if gethostbyname2 should not be moved out of  net.cc and integrated
with minires. We could design shortcuts to use the most appropriate method.

I have read RFC 2133, section 6.1 . Do we want to implement having a
RES_OPTIONS in the environment,  in  /etc/resolv.conf, or only by setting the
appropriate flag in _res? What does Linux do?

I am still fighting one issue with Windows. On XP, when using the native gethostbyname
I can resolve computers on my local net (through NetBIOS or such). But I can't get
them with DnsQuery, except my own computer, despite what I think the doc says.
Any insight?

Pierre
