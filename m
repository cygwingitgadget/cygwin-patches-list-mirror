Return-Path: <cygwin-patches-return-7067-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21067 invoked by alias); 17 Aug 2010 21:38:43 -0000
Received: (qmail 21056 invoked by uid 22791); 17 Aug 2010 21:38:42 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-4.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.4)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 17 Aug 2010 21:38:37 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id F3A0813C061	for <cygwin-patches@cygwin.com>; Tue, 17 Aug 2010 17:38:35 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id E3B0C2B354; Tue, 17 Aug 2010 17:38:35 -0400 (EDT)
Date: Tue, 17 Aug 2010 21:38:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCHes] Misc aliasing fixes for building DLL with gcc-4.5.0
Message-ID: <20100817213835.GA16955@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A7F8FF5.5060701@gmail.com> <1282073012.8848.8.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1282073012.8848.8.camel@YAAKOV04>
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
X-SW-Source: 2010-q3/txt/msg00027.txt.bz2

On Tue, Aug 17, 2010 at 02:23:32PM -0500, Yaakov (Cygwin/X) wrote:
>On Mon, 2009-08-10 at 04:11 +0100, Dave Korn wrote:
>>   I tried compiling winsup with GCC-4.5.0 HEAD, and it finds a bunch of things
>> to complain about (which then break the -Werror build).  They are mostly
>> "dereferencing type-punned pointer will break strict-aliasing rules" errors, but
>> there is also some possibly-undefined behaviour in passwd.cc (looks like a
>> problem with sequence points to me).
>
>Sorry to resurrect such an old thread, but now that Dave released
>gcc-4.5, this is no longer theoretical.  Here are the warnings-as-errors
>that I get with gcc-4.5.1 with Dave's 4.5.0 patch set:

We obviously have been down this road before and will fix the compiler
errors as time permits.

In the meantime, posting the errors to "cygwin-patches" isn't really
interesting since there are no patches here.

Actually, I don't think they are actually very interesting in any
mailing list.

cgf
