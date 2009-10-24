Return-Path: <cygwin-patches-return-6797-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28818 invoked by alias); 24 Oct 2009 16:09:47 -0000
Received: (qmail 28804 invoked by uid 22791); 24 Oct 2009 16:09:45 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 24 Oct 2009 16:09:41 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id D22AC3B0002 	for <cygwin-patches@cygwin.com>; Sat, 24 Oct 2009 12:09:31 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id CE6092B352; Sat, 24 Oct 2009 12:09:31 -0400 (EDT)
Date: Sat, 24 Oct 2009 16:09:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
Message-ID: <20091024160931.GE18003@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AD78C5B.2080107@cwilson.fastmail.fm>  <4AE0DE77.3090300@cwilson.fastmail.fm>  <4AE0E614.4030305@cwilson.fastmail.fm>  <20091024153135.GA18003@ednor.casa.cgf.cx>  <4AE31FD6.5070705@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AE31FD6.5070705@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00128.txt.bz2

On Sat, Oct 24, 2009 at 11:40:06AM -0400, Charles Wilson wrote:
>Christopher Faylor wrote:
>> I just waded through this thread and I'm confused about why it is being
>> actively discussed here since it's obviously a purely mingw issue.
>
>Because it affects the cygwin build process, and my motivation was to
>support DESTDIR which really only helps *cygwin*.  I'm basically asking
>the mingw guys for a favor -- but wanted to keep the cygwin community in
>the loop, since it's a favor for *us*.

It actually affects the cygwin install process.  Since these directories
don't need to be installed for a standard cygwin release, it seems like
the best solution would be to just avoid installing the directories
entirely.  This could be done in Makefile.in.  Just don't install the
directories if the target is *-cygwin.

Another way to deal with this is to create an install wrapper script for
installing files and make it windows-aware.

Anyway, I have previously suggested that similar changes go straight to
the mingw developers so I think I'm being consistent here.  Since we
can't approve the changes, the discussion devolves to speculation about
what will be accepted which might as well be discussed with the people
who can approve.

>BTW, welcome back.

Thanks.  I tried to resist reading any email until Monday but obviously
I've failed.  So, my happy Italy buzz is rapidly fading...

cgf
