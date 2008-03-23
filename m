Return-Path: <cygwin-patches-return-6326-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30315 invoked by alias); 23 Mar 2008 20:50:40 -0000
Received: (qmail 30303 invoked by uid 22791); 23 Mar 2008 20:50:40 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 23 Mar 2008 20:50:21 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JdX91-0002At-7u 	for cygwin-patches@cygwin.com; Sun, 23 Mar 2008 20:50:19 +0000
Message-ID: <47E6C20F.B0477BF0@dessent.net>
Date: Sun, 23 Mar 2008 20:50:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] recognise when an exec()d process terminates due to 	  unhandled exception
References: <47D9D8D3.17BC1E3B@dessent.net> <47D9E70D.ED6C84CB@dessent.net> <20080314141331.GB20808@ednor.casa.cgf.cx> <47DB689F.8FC91752@dessent.net> <20080323035119.GA2554@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00100.txt.bz2

Christopher Faylor wrote:

> After poking at this a little, I think it would be better to issue a
> linux-like error message.
> 
> In my sandbox, I now have this:
> 
> bash-3.2$ ./libtest
> /cygdrive/s/test/libtest.exe: error while loading shared libraries: liba.dll: cannot open shared object file: No such file or directory
> 
> I haven't done the work to report on missing symbols yet but I think
> that's a much less common error condition.

Excellent.  The wording isn't really that important to me.   But I think
what is important is that we don't allow the situation where something
was unable to start and we are totally silent.  That leads to confusion
because people start to try to debug or blame the program being run when
in fact the program never saw the light of day in the first place.  It's
totally baffling when it happens and you're not aware to look for it. 
So even if we can't give the name of the symbol in the case of a missing
import, I think it's still important to say something.

Brian
