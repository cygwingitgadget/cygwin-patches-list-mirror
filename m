Return-Path: <cygwin-patches-return-5556-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25762 invoked by alias); 5 Jul 2005 21:38:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25733 invoked by uid 22791); 5 Jul 2005 21:38:21 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 05 Jul 2005 21:38:21 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 0729713C12A; Tue,  5 Jul 2005 17:38:11 -0400 (EDT)
Date: Tue, 05 Jul 2005 21:38:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygcheck exit status
Message-ID: <20050705213810.GA13986@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20050705T224501-8@post.gmane.org> <20050705205334.GA12357@trixie.casa.cgf.cx> <loom.20050705T225652-764@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050705T225652-764@post.gmane.org>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00011.txt.bz2

On Tue, Jul 05, 2005 at 08:57:42PM +0000, Eric Blake wrote:
>Christopher Faylor <cgf-no-personal-reply-please <at> cygwin.com> writes:
>>On Tue, Jul 05, 2005 at 08:49:06PM +0000, Eric Blake wrote:
>>> <at>  <at>  -1677,7 +1681,7  <at>  <at>  main (int argc, char **argv)
>>>       {
>>>        if (i)
>>>          puts ("");
>>>-       cygcheck (argv[i]);
>>>+       ok &= cygcheck (argv[i]);
>> 
>>Why are you anding the result here?  Why not just set ok = cygcheck
>>(...)?
>
>Because it's in a for loop, and when the first file fails but second
>succeeds, you still want the overall command to exit with failure.

Huh.  That's two useful things I've learned about C in the span of a
week.

I'll check this in.

Thanks.

cgf
