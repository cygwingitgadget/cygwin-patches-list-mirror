Return-Path: <cygwin-patches-return-5918-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18114 invoked by alias); 7 Jul 2006 00:41:15 -0000
Received: (qmail 18103 invoked by uid 22791); 7 Jul 2006 00:41:15 -0000
X-Spam-Check-By: sourceware.org
Received: from okigate.oki.co.jp (HELO iscan1.intra.oki.co.jp) (202.226.91.194)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Jul 2006 00:41:12 +0000
Received: from s24c53.dm1.oii.oki.co.jp (IDENT:root@localhost.localdomain [127.0.0.1]) 	by iscan1.intra.oki.co.jp (8.9.3/8.9.3) with ESMTP id JAA05714; 	Fri, 7 Jul 2006 09:41:09 +0900
Received: from [10.161.35.40] (suzuki611-note.ngo.okisoft.co.jp [10.161.35.40]) 	by s24c53.dm1.oii.oki.co.jp (8.11.6/8.11.2) with ESMTP id k670f8d25093; 	Fri, 7 Jul 2006 09:41:09 +0900
Message-ID: <44ADADD0.8000803@oki.com>
Date: Fri, 07 Jul 2006 00:41:00 -0000
From: SUZUKI Hisao <suzuki611@oki.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060516)
MIME-Version: 1.0
To: Dave Korn <dave.korn@artimi.com>, cygwin-patches@cygwin.com
Subject: Re: UTF-8 Cygwin
References: <037101c6a0f5$749bb130$a501a8c0@CAM.ARTIMI.COM>
In-Reply-To: <037101c6a0f5$749bb130$a501a8c0@CAM.ARTIMI.COM>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00013.txt.bz2

Dave Korn wrote:
> On 06 July 2006 07:28, SUZUKI Hisao wrote:
> 
> 
>> Sorry, but I cannot access to CVS server because of firewall.  So the
>> patch file was made from the cygwin-1.5.20-1-src.
> 
>   Here it is, blindly applied to current CVS and then regenerated.  I've
> checked that it still builds and I've installed and started running with it.
> I'll report any quirks I find, but I'm not likely to be using the UTF-8
> features; I'll just look out for any possible breakage of existing stuff.

Thank you!

>   Just a couple of comments that I noticed straight away: there's lots of
> commented out blocks that should be removed if they aren't going to be used,
> and there's a worrying number of XXX tags that suggest some work remains to be
> done....?

The tags had meant so in the early stage of development
circa 1 March indeed.  During testing and debugging, they
have been remained and used as the marks where I touched
the source specifically.  Generally, I have replaced every
occurrence of ANSI-WIN32 API that operates on a file name
with macros in winsup.h

And a few tags means some work remains yet really.  They
are in miscfuncs.cc, where I put codes that replace ANSI-
WIN32 API generally:

u_mbstowcs:  combining form conversion needs work on
    combining grave, acute etc. especially.

GetCommandLineU:  a large fixed-size dynamic buffer is
    used.  It just works fine for most cases, and falls
    back gracefully for ASCII input.  It operates well
    in 99% cases.  For the rest cases, it needs work
    (in such cases, you will see wrong conversion of
    non-ASCII characters for now).

I'm sorry for confusion.

>     cheers,
>       DaveK

Regards,
-- SUZUKI Hisao
