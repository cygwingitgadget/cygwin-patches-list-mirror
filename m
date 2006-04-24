Return-Path: <cygwin-patches-return-5840-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28860 invoked by alias); 24 Apr 2006 16:17:57 -0000
Received: (qmail 28848 invoked by uid 22791); 24 Apr 2006 16:17:56 -0000
X-Spam-Check-By: sourceware.org
Received: from vms042pub.verizon.net (HELO vms042pub.verizon.net) (206.46.252.42)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 24 Apr 2006 16:17:54 +0000
Received: from PHUMBLETXP ([12.6.244.2])  by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep  9 2005)) with ESMTPA id <0IY800LKPILRQFF0@vms042.mailsrvcs.net> for  cygwin-patches@cygwin.com; Mon, 24 Apr 2006 11:17:52 -0500 (CDT)
Date: Mon, 24 Apr 2006 16:17:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Make getenv() functional before the environment is  initialized
To: <cygwin-patches@cygwin.com>
Message-id: <029001c667ba$754ff470$280010ac@wirelessworld.airvananet.com>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Content-transfer-encoding: 7bit
References: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com>  <20060421172328.GD7685@calimero.vinschen.de>  <01ca01c66574$b295c7d0$280010ac@wirelessworld.airvananet.com>  <20060421191314.GA11311@trixie.casa.cgf.cx>  <01fc01c6657c$347794c0$280010ac@wirelessworld.airvananet.com>  <20060421201200.GA8588@trixie.casa.cgf.cx>  <022b01c66582$b3d396a0$280010ac@wirelessworld.airvananet.com>  <20060421213928.GC31141@trixie.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00028.txt.bz2

----- Original Message ----- 
From: "Christopher Faylor"
To: <cygwin-patches@cygwin.com>
Sent: Friday, April 21, 2006 5:39 PM
Subject: Re: [Patch] Make getenv() functional before the environment is 
initialized


>I just talked to Corinna about this on IRC and neither of us really
> cares enough about this to merit a long discussion so I've just checked
> in a variation of the cmalloc patch.  The only change that I made was to
> define a HEAP_2_STR value so that the HEAP_1_MAX usage is confined to
> cygheap.cc where I'd intended it.

Thanks a lot, Chris & Corinna.

Now that I am trying it, it doesn't work anymore when launched from Cygwin.

I am starting to wonder if the current
*ptr[len] == '='
is equivalent to the former
*(*ptr + s) == '='
when s = len and ptr is a char **

Pierre 
