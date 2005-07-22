Return-Path: <cygwin-patches-return-5588-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22304 invoked by alias); 22 Jul 2005 18:28:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22257 invoked by uid 22791); 22 Jul 2005 18:28:44 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 22 Jul 2005 18:28:44 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 8187F13C0EC; Fri, 22 Jul 2005 14:28:42 -0400 (EDT)
Date: Fri, 22 Jul 2005 18:28:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Set FILE_ATTRIBUTE_TEMPORARY on files opened by mkstemp() on WinNT
Message-ID: <20050722182842.GA1503@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050722011722.L38147@logout.sh.cvut.cz> <20050721234356.GB24848@trixie.casa.cgf.cx> <20050722030953.N49904@logout.sh.cvut.cz> <20050722020329.GA2430@trixie.casa.cgf.cx> <20050722121047.U55258@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050722121047.U55258@logout.sh.cvut.cz>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00043.txt.bz2

On Fri, Jul 22, 2005 at 12:28:08PM +0200, Vaclav Haisman wrote:
>On Thu, 21 Jul 2005, Christopher Faylor wrote:
>>On Fri, Jul 22, 2005 at 03:17:33AM +0200, Vaclav Haisman wrote:
>>>On Thu, 21 Jul 2005, Christopher Faylor wrote:
>>>>On Fri, Jul 22, 2005 at 01:32:50AM +0200, Vaclav Haisman wrote:
>>>>>the attached patch sets FILE_ATTRIBUTE_TEMPORARY on files opened by
>>>>>mkstemp() on WinNT class systems.  Theoretically the OS should then be
>>>>>less eager to write such files onto the physical storage and use cache
>>>>>instead.
>>>>
>>>>Thank you for the patch but unless you can demonstrate some obvious
>>>>performance improvements I don't think we'll be applying it.  You've
>>>>slowed down (slightly) the common case of calling open for the uncommon
>>>>case of calling mk?temp.
>>>
>>>I am not sure what kind of slow down do you mean.  Is it the one extra
>>>call?
>>
>>It was more than one extra call, but yes.
>>
>>>In that case the attached modified patch should fix it.  The call to
>>>open_with_attributes() in open() gets inlined, I have checked the
>>>resulting .s file.
>>
>>Can you demonstrate some obvious performance improvements?  Does it
>>speed up configure, make bash start up faster, make the rxvt window
>>faster to show up?
>
>I don't think that any of the extra ifs and assignments could cause any
>measurable slowdown.  I also do not think that there are any _obvious_
>speed ups.  It is merely a hint to the cache subsystem, not a silver
>bullet.

I wasn't asking if there was a slowdown.  I wanted to know the rationale
for this change.  Increasing code complexity for no obvious gain is not
something that I want to do.

cgf
