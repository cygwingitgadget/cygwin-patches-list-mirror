Return-Path: <cygwin-patches-return-6419-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25428 invoked by alias); 26 Feb 2009 17:55:30 -0000
Received: (qmail 25417 invoked by uid 22791); 26 Feb 2009 17:55:29 -0000
X-SWARE-Spam-Status: No, hits=4.1 required=5.0 	tests=AWL,BAYES_40,BOTNET,J_CHICKENPOX_36
X-Spam-Check-By: sourceware.org
Received: from vms173017pub.verizon.net (HELO vms173017pub.verizon.net) (206.46.173.17)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Feb 2009 17:55:22 +0000
Received: from PHUMBLETLAPXP ([173.9.58.250]) by vms173017.mailsrvcs.net  (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))  with ESMTPA id <0KFO00C0XPRT7NE0@vms173017.mailsrvcs.net> for  cygwin-patches@cygwin.com; Thu, 26 Feb 2009 11:55:11 -0600 (CST)
Message-id: <091301c9983b$5e9debb0$4e0410ac@wirelessworld.airvananet.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
References: <0KFO009T9G34ZQ6E@vms173009.mailsrvcs.net>  <08f301c99827$095c9a20$4e0410ac@wirelessworld.airvananet.com>  <20090226160524.GY18319@calimero.vinschen.de>
Subject: Re: [Patch] gethostbyname2
Date: Thu, 26 Feb 2009 17:55:00 -0000
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
X-SW-Source: 2009-q1/txt/msg00017.txt.bz2


----- Original Message ----- 
From: "Corinna Vinschen"
To: <cygwin-patches>
Sent: Thursday, February 26, 2009 11:05 AM
Subject: Re: [Patch] gethostbyname2


| On Feb 26 10:29, Pierre A. Humblet wrote:
| > At 04:52 AM 2/26/2009, Corinna Vinschen wrote:
| > | >On Feb 25 23:03, Pierre A. Humblet wrote:
| > | > > I tried to compile Exim with IPv6 enabled and Cygwin 1.7, but it needs
| > | > > gethostbyname2.
| > | > > Here is an implementation of that function.
| > | > > In attachment I am including the same patch as well as a short test function.
| > | > >
| > | >
| > | >This is way cool!  I have this function on my TODO list for ages.
| > | >
| > | >But there's a problem.  You're using DnsQuery_A directly, but this
| > | >function only exists since Win2K.  Would it be a big problem to rework
| > | >the function to use the resolver functions instead?  They are part of
| > | >Cygwin now anyway and that would abstract gethostbyname2 from the
| > | >underlying OS capabilities.
| >
| > I was afraid of that. Using res_query was my initial thought, but I realized that when using 
the
| > Windows resolver I would undo in gethostbyname2 all the work done in minires.
|
| I'm sorry, but I really don't understand what you mean.  How are you
| undoing work in minires when using minires in gethostbyname2?!?  Why
| isn't it just possible to call res_query from there?

It is possible of course. But the sequence would be the following
1) External DNS server sends compressed records to Windows resolver
2) Windows resolver uncompresses the records and puts them in nice structures
3) Minires takes the nice structures and recompresses them to wire format
4) Gethostbyname2 uncompresses them into nice structures
    then 5) calls dup_ent,  which copies them in the tls.locals
I would like to streamline the process:
- With Windows resolver: 1, 2, 5  (that's the current patch, ~20% of  which is
         cut&pasted from minires and could be restructured to use a common function)
- Without: Straight fom wire format records to the tls.locals memory block
                 Or: have a routine 2a) in minires that replaces 2. Then it would be 1, 2a, 5.

| > I am still fighting one issue with Windows. On XP, when using the native gethostbyname
| > I can resolve computers on my local net (through NetBIOS or such). But I can't get
| > them with DnsQuery, except my own computer, despite what I think the doc says.
| > Any insight?
|
| I never used the DnsQuery functions myself.  There's a DnsQuery flag
| called DNS_QUERY_NO_NETBT documented in MSDN, maybe there's something
| switched off on your machine so that's the default?

Perhaps. But where is it or how does the native gethostbyname turn it on?
To answer Dave, "DNS Client" service is running, I have never experimented turning it off.

Pierre 
