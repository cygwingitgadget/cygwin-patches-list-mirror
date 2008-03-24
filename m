Return-Path: <cygwin-patches-return-6327-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17229 invoked by alias); 24 Mar 2008 00:09:31 -0000
Received: (qmail 17216 invoked by uid 22791); 24 Mar 2008 00:09:30 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-32.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.32)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 24 Mar 2008 00:09:08 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id A3511CE393; Sun, 23 Mar 2008 20:09:06 -0400 (EDT)
Date: Mon, 24 Mar 2008 00:09:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] recognise when an exec()d process terminates due to 	unhandled exception
Message-ID: <20080324000906.GA4381@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D9D8D3.17BC1E3B@dessent.net> <47D9E70D.ED6C84CB@dessent.net> <20080314141331.GB20808@ednor.casa.cgf.cx> <47DB689F.8FC91752@dessent.net> <20080323035119.GA2554@ednor.casa.cgf.cx> <47E6C20F.B0477BF0@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47E6C20F.B0477BF0@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00101.txt.bz2

On Sun, Mar 23, 2008 at 01:48:15PM -0700, Brian Dessent wrote:
>Christopher Faylor wrote:
>>After poking at this a little, I think it would be better to issue a
>>linux-like error message.
>>
>>In my sandbox, I now have this:
>>
>>bash-3.2$ ./libtest /cygdrive/s/test/libtest.exe: error while loading
>>shared libraries: liba.dll: cannot open shared object file: No such
>>file or directory
>>
>>I haven't done the work to report on missing symbols yet but I think
>>that's a much less common error condition.
>
>Excellent.  The wording isn't really that important to me.  But I think
>what is important is that we don't allow the situation where something
>was unable to start and we are totally silent.  That leads to confusion
>because people start to try to debug or blame the program being run
>when in fact the program never saw the light of day in the first place.
>It's totally baffling when it happens and you're not aware to look for
>it.  So even if we can't give the name of the symbol in the case of a
>missing import, I think it's still important to say something.

Yes.  I really have been meaning to fix this for a long time.  It's my
fault that cygwin has this bug.  I appreciate your point the way to
how this could be solved.

cgf
