Return-Path: <cygwin-patches-return-6114-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15185 invoked by alias); 4 Jun 2007 02:05:30 -0000
Received: (qmail 15172 invoked by uid 22791); 4 Jun 2007 02:05:27 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-245.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.245)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 04 Jun 2007 02:05:25 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id D031E2B354; Sun,  3 Jun 2007 22:05:24 -0400 (EDT)
Date: Mon, 04 Jun 2007 02:05:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] "strace ./app.exe" probably runs application from /bin
Message-ID: <20070604020524.GA22232@ednor.casa1.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <466183F3.5020900@t-online.de> <20070602154156.GA19696@ednor.casa.cgf.cx> <4661FD22.BE882CE7@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4661FD22.BE882CE7@dessent.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00060.txt.bz2

On Sat, Jun 02, 2007 at 04:28:34PM -0700, Brian Dessent wrote:
>Christopher Faylor wrote:
>
>> Let me rephrase the problem:
>> 
>> "cygpath does not properly deal with the current directory"
>> 
>> Thanks for the patch but we won't be applying it in this form.
>
>I've been meaning to take a look at fixing this myself, because I'm
>tired of:
>
>$ cd /usr/bin
>
>$ cygcheck ./ls
>.\.\.\.\ - Cannot open
>
>$ cygcheck ls
> - Cannot open
>Error: could not find ls
>
>$ cygcheck ls.exe
> - Cannot open
>Error: could not find ls.exe
>
>$ cygcheck ./ls.exe
>.\ls.exe
>  .\cygwin1.dll
>    C:\WINXP\system32\ADVAPI32.DLL
>      C:\WINXP\system32\ntdll.dll
>      C:\WINXP\system32\KERNEL32.dll
>      C:\WINXP\system32\RPCRT4.dll
>  .\cygintl-8.dll
>    .\cygiconv-2.dll

I just checked in a change which modified path.cc to try to deal with
relative paths.  That should fix the reported strace.exe problem.  I
also severely hacked at cygcheck.cc to try to fix the above behavior
(it's annoyed me in the past too).

I'm not 100% sure that I got every corner case right, though, so please
check it out and report any problems to the cygwin mailing list.  The
latest snapshot has these changes.

cgf
