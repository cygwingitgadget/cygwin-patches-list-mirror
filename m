Return-Path: <cygwin-patches-return-7827-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9141 invoked by alias); 21 Feb 2013 19:42:44 -0000
Received: (qmail 9127 invoked by uid 22791); 21 Feb 2013 19:42:43 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,TW_SF
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 21 Feb 2013 19:42:38 +0000
Received: from pool-173-76-49-193.bstnma.fios.verizon.net ([173.76.49.193] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1U8c2P-0005R1-FT	for cygwin-patches@cygwin.com; Thu, 21 Feb 2013 19:42:37 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id B285D8804BF	for <cygwin-patches@cygwin.com>; Thu, 21 Feb 2013 14:42:36 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19HIvf5MtBQlDi4QaTa/+kv
Date: Thu, 21 Feb 2013 19:42:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Export <io.h> symbols with underscore
Message-ID: <20130221194236.GA1163@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130220151600.5983c15a@YAAKOV04> <20130221011432.GA2786@ednor.casa.cgf.cx> <20130221111545.GA24054@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130221111545.GA24054@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00038.txt.bz2

On Thu, Feb 21, 2013 at 12:15:45PM +0100, Corinna Vinschen wrote:
>On Feb 20 20:14, Christopher Faylor wrote:
>> On Wed, Feb 20, 2013 at 03:16:00PM -0600, Yaakov wrote:
>> >I have already encountered issues with the lack of leading-underscored
>> >exports for symbols declared in <io.h>, as usage thereof often occurs
>> >in shared Cygwin/Win32 conditional code, and on Win32 these are
>> >underscored.  Patch attached for the two symbols I have seen so far,
>> >but I wonder if I should just get it over with and add _access as well.
>> >
>> >
>> >Yaakov
>> 
>> >2013-02-20  Yaakov Selkowitz  <yselkowitz@...>
>> >
>> >	* cygwin64.din: Restore _get_osfhandle and _setmode.
>> 
>> Ugh.  I've been slowly getting rid of some of those inexplicably underscored
>> functions now we have to keep the converse around.  I wonder if the non-underscored
>> versions can actually be deleted since they are supposed to exist in the userspace
>> with an explicit underscore.
>
>We have to make a tradeoff between backward compatibility and getting
>rid of the underscored variants of ANSI function added in the early days
>to provide a falsely understood compatibility with MSVCRT.
>
>I have no problem to keep the underscored _get_osfhandle and _setmode
>since these are non-standard entry points anyway, and we also have to
>keep some underscored exports for newlib.  But we should not add the
>MSVCRT ANSI calls back (like _access).  That was plainly wrong to begin
>with.

I wasn't fulling grokking the fact that Cygwin explicitly defined the
get_osfhandle without an underscore in io.h.  Sigh.  That's probably my
fault too.

But we definitely shouldn't be going back to adding "_" decorations.  I
have deleted a few of these and no one has complained.  I know that
isn't a scientific sampling but it's hard to believe that someone has
written code which actually goes out of its way to prepend an underscore
in front of a standard UNIX function name, especially since we do not,
AFAIK, define these functions in any header file.

So, I guess I don't understand why we need to add an underscore now
when we have gotten by with the incorrect declaration for get_osfhandle
all of these years.

cgf
