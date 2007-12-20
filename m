Return-Path: <cygwin-patches-return-6201-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9275 invoked by alias); 20 Dec 2007 21:11:45 -0000
Received: (qmail 9260 invoked by uid 22791); 20 Dec 2007 21:11:43 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-37-220.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (96.233.37.220)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 20 Dec 2007 21:11:32 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 6E43A2B352; Thu, 20 Dec 2007 16:11:30 -0500 (EST)
Date: Thu, 20 Dec 2007 21:11:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] un-NT-ify cygcheck (was: cygwin 1.5.25-7: cygcheck 	does not   work?)
Message-ID: <20071220211130.GA28771@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <836045.82708.qm@web33207.mail.mud.yahoo.com> <476A726D.50100@byu.net> <476A78EF.2322FB0A@dessent.net> <476A8729.5C05B169@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <476A8729.5C05B169@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00053.txt.bz2

On Thu, Dec 20, 2007 at 07:15:53AM -0800, Brian Dessent wrote:
>Brian Dessent wrote:
>
>> Fortunately, I have VMware with a Win98 image here.
>> 
>> The problem is that bloda.c calls NtQuerySystemInformation without using
>> any kind of autoload.cc-type indirection, and so cygcheck gets a hard
>> dependency on ntdll.dll which doesn't exist on 9x/ME.  We need to do one
>> of:
>> 
>> - Revert the bloda-check feature on the 1.5 branch
>> - Check windows version at runtime and only do NT calls through
>> LoadLibrary/GetProcAddress
>> - Use the autoload.cc trick in cygcheck
>> 
>> If we're going to make releases from the 1.5 branch then I don't think
>> it's quite acceptible just yet to shaft 9x users, after all that's the
>> whole point of the branch.
>
>The attached patch un-NT-ifies bloda.cc but sadly a similar cleanup is
>still required for cygpath as well if we are to support 9x/ME out of the
>1.5 branch. In that case I suppose you could just revert cygpath.cc to
>an older revision before the native APIs were added.
>
>Brian
>2007-12-20  Brian Dessent  <brian@dessent.net>
>
>	* Makefile.in (cygcheck.exe): Don't link to ntdll.
>	* bloda.cc (pNtQuerySystemInformation): Add.
>	(pRtlAnsiStringToUnicodeString): Add.
>	(get_process_list): Use function pointers for NT functions.
>	(dump_dodgy_apps): Skip dodgy app check on non-NT platforms.
>	Use GetProcAddress for NT-specific functions.

I had something similar in my sandbox but 1) you beat me to it and 2)
yours is better.  So, please check this into the trunk.  I don't have
any problem with cygcheck being Windows 9x aware since it could help us
track down problems with people who are trying to run Cygwin 1.7.x on
older systems.

Unless Corinna says differently, I think she wants to be in control of
what goes into the branch so I don't want to suggest that you should
check it in there too.

cgf
