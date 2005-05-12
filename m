Return-Path: <cygwin-patches-return-5446-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10549 invoked by alias); 12 May 2005 19:49:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10530 invoked from network); 12 May 2005 19:49:30 -0000
Received: from unknown (HELO vms046pub.verizon.net) (206.46.252.46)
  by sourceware.org with SMTP; 12 May 2005 19:49:30 -0000
Received: from PHUMBLETLAP ([12.6.244.2])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IGE00MNU72A0MB1@vms046.mailsrvcs.net> for
 cygwin-patches@cygwin.com; Thu, 12 May 2005 14:49:26 -0500 (CDT)
Date: Thu, 12 May 2005 19:49:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: mkdir -p and network drives
To: <cygwin-patches@cygwin.com>
Reply-to: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Message-id: <007b01c5572b$b3925890$3e0010ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
References: <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net>
 <3.0.5.32.20050505225708.00b64250@incoming.verizon.net>
 <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net>
 <3.0.5.32.20050510205301.00b4b658@incoming.verizon.net>
 <20050511085307.GA2805@calimero.vinschen.de>
X-SW-Source: 2005-q2/txt/msg00042.txt.bz2


----- Original Message ----- 
From: "Corinna Vinschen" <corinna-cygwin@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Wednesday, May 11, 2005 4:53 AM
Subject: Re: [Patch]: mkdir -p and network drives


> I don't like the idea of isrofs being an inline function in dir.cc.
> Wouldn't that be better a method in path_conv?  It would be helpful
> for other functions, too.  For instance, unlink and symlink_worker.
> In the (not so) long run we should really move all of these functions
> into the fhandlers, though.

After looking into it, moving mkdir and rmdir to fhandlers should be
quite simple. I will do that early next week.

Pierre

