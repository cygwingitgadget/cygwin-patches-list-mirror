Return-Path: <cygwin-patches-return-6737-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31367 invoked by alias); 7 Oct 2009 03:04:01 -0000
Received: (qmail 30559 invoked by uid 22791); 7 Oct 2009 03:03:59 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 07 Oct 2009 03:03:52 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 5929F3B0002 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 23:03:42 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 5569E2B352; Tue,  6 Oct 2009 23:03:42 -0400 (EDT)
Date: Wed, 07 Oct 2009 03:04:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Merge pseudo-reloc-v2 support from mingw/pseudo-reloc.c
Message-ID: <20091007030342.GA13923@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACBD892.5040508@cwilson.fastmail.fm>  <4ACBDD83.6080307@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACBDD83.6080307@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00068.txt.bz2

On Tue, Oct 06, 2009 at 08:14:59PM -0400, Charles Wilson wrote:
>> On Tue, Oct 06, 2009 at 07:53:54PM -0400, Charles Wilson wrote:
>>>Hence, three separate "entries". One question: when it comes time to
>>>commit this to CVS, should it be done all in one lump, or 1-2-3 very
>>>quick separate commits (even though the tree would be broken between,
>>>say, #1 and #2)?
>> 
>> I don't see why you shouldn't check in everything together since it's
>> all one "change set". It's not like you could just back out Kai's changes
>> individually and still get a working cygwin, right?
>
>Correct. You really need all three bits for a working solution.
>(Although the ChangeLog as I posted it is in traditional reverse-order.
>Kai's bits would go first, then my changes to pseudo-reloc.c, and last
>my changes to the other files).
>
>I just figured it made sense to split up the ChangeLog, because I didn't
>want to take credit for Kai's changes, but I did want to document what I
>did, beyond the mingw/ version (which should make it easier when I
>submit THOSE changes back to the mingw folks).  Furthermore, I figure
>somebody might scan the ChangeLog looking for people without a Red Hat
>copyright assignment, and get nervous if they saw:
>
>date  Charles Wilson  <...>  <<--- has assignment
>      Kai Teitz  <...>       <<--- no assignment (?)
>
>      A bunch of changes
>
>The way I split the ChangeLog up, it is clear that Kai only touched the
>public domain file.
>
>Anyway, once I had split up the ChangeLog, I simply wondered if I should
>/also/ split up the commits.  If you're happy with one-big-lump, so am I
>-- that's easier.

I think this one is Corinna's call.

cgf
