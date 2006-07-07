Return-Path: <cygwin-patches-return-5919-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14290 invoked by alias); 7 Jul 2006 02:42:24 -0000
Received: (qmail 14175 invoked by uid 22791); 7 Jul 2006 02:42:23 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-44.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.44)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Jul 2006 02:42:21 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id B9DD013C020; Thu,  6 Jul 2006 22:42:19 -0400 (EDT)
Date: Fri, 07 Jul 2006 02:42:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: UTF-8 Cygwin
Message-ID: <20060707024219.GA8827@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <037101c6a0f5$749bb130$a501a8c0@CAM.ARTIMI.COM> <44ADADD0.8000803@oki.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ADADD0.8000803@oki.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00014.txt.bz2

On Fri, Jul 07, 2006 at 09:41:52AM +0900, SUZUKI Hisao wrote:
>Dave Korn wrote:
>>On 06 July 2006 07:28, SUZUKI Hisao wrote:
>>
>>
>>>Sorry, but I cannot access to CVS server because of firewall.  So the
>>>patch file was made from the cygwin-1.5.20-1-src.
>>
>>  Here it is, blindly applied to current CVS and then regenerated.  I've
>>checked that it still builds and I've installed and started running with 
>>it.
>>I'll report any quirks I find, but I'm not likely to be using the UTF-8
>>features; I'll just look out for any possible breakage of existing stuff.
>
>Thank you!
>
>>Just a couple of comments that I noticed straight away: there's lots of
>>commented out blocks that should be removed if they aren't going to be
>>used, and there's a worrying number of XXX tags that suggest some work
>>remains to be done....?
>
>The tags had meant so in the early stage of development circa 1 March
>indeed.  During testing and debugging, they have been remained and used
>as the marks where I touched the source specifically.  Generally, I
>have replaced every occurrence of ANSI-WIN32 API that operates on a
>file name with macros in winsup.h

I hate to say this but I really don't like doing things this way.  If we
need to use wide character support then it should just be a wholesale
replacement, not a bunch of wrappers around existing functions.

Corinna and I have talked about using the FooW functions for a long time.
There are some fundamental changes required to incorporate these into
cygwin but I don't think that wrappers around everything are the way to
go.

cgf
