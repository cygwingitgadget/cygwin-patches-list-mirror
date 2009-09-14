Return-Path: <cygwin-patches-return-6623-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23835 invoked by alias); 14 Sep 2009 23:05:13 -0000
Received: (qmail 23825 invoked by uid 22791); 14 Sep 2009 23:05:13 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-252-118-15.bstnma.fios.verizon.net (HELO cgf.cx) (96.252.118.15)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 14 Sep 2009 23:05:09 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id D148913C0C4 	for <cygwin-patches@cygwin.com>; Mon, 14 Sep 2009 19:04:59 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id CF2E72B352; Mon, 14 Sep 2009 19:04:59 -0400 (EDT)
Date: Mon, 14 Sep 2009 23:05:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Define _TIMEVAL_DEFINED consistently whenever defining  timeval.
Message-ID: <20090914230459.GB6194@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AADAF9C.2000601@gmail.com>  <4AAECB58.2030401@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AAECB58.2030401@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q3/txt/msg00077.txt.bz2

On Mon, Sep 14, 2009 at 07:01:44PM -0400, Charles Wilson wrote:
>Dave Korn wrote:
>> Granted that the whole _TIMEVAL_DEFINED/__USE_W32_SOCKETS thing is basically
>> an ugly and undesirable hack, but until we have a plan to fix the whole
>> tcl/tk/expect/dejagnu/gdb/insight combo (as well as gnat), I figure we have to
>> live with it, and so it should at least be correct consistent and complete.
>
From this thread:
>  http://www.cygwin.com/ml/cygwin/2008-08/msg00089.html
>I thought most people either were in favor of, or at least not opposed
>to, "fixing" the */tk/*/insight issue by switching to an X-based tk. It
>was just waiting on enough cgf-tuits (and, perhaps, the long-delayed gdb
>7.0 release and/or Insight 7.0).

I did get tcl and (I think) tk building but then found that insight
needed other libraries too.

I'm really thinking that insight should be retired.  I know the maintainer
pretty well and he's not extremely keen on keeping it its current
state.

But this really isn't a discussion for cygwin-patches.

cgf
