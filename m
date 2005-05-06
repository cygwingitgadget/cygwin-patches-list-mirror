Return-Path: <cygwin-patches-return-5428-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8478 invoked by alias); 6 May 2005 14:55:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8399 invoked from network); 6 May 2005 14:55:36 -0000
Received: from unknown (HELO vms042pub.verizon.net) (206.46.252.42)
  by sourceware.org with SMTP; 6 May 2005 14:55:36 -0000
Received: from PHUMBLETLAP ([12.6.244.2])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IG200KEAPGIDRN1@vms042.mailsrvcs.net> for
 cygwin-patches@cygwin.com; Fri, 06 May 2005 09:55:32 -0500 (CDT)
Date: Fri, 06 May 2005 14:55:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: mkdir -p and network drives
To: <cygwin-patches@cygwin.com>
Reply-to: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Message-id: <00a701c5524b$a66949b0$3e0010ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
References: <002f01c5523f$6d6f38b0$3e0010ac@wirelessworld.airvananet.com>
 <20050506142213.GA20565@trixie.casa.cgf.cx>
X-SW-Source: 2005-q2/txt/msg00024.txt.bz2


----- Original Message ----- 
From: "Christopher Faylor" <cgf-no-personal-reply-please@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Friday, May 06, 2005 10:22 AM
Subject: Re: [Patch]: mkdir -p and network drives

> Well, that was kinda my point.  If we can't remove the "//" handling
because
> it breaks bash then adding opendir/readdir stuff seems premature except
for
> the case of ls //foo which is entirely different from ls //.

Sigh. We need a bash maintainer.
We need to have // working for mkdir -p to work, from what I
understand of the code snippet that was sent to the list.

Pierre

