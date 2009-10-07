Return-Path: <cygwin-patches-return-6736-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15126 invoked by alias); 7 Oct 2009 00:15:14 -0000
Received: (qmail 15109 invoked by uid 22791); 7 Oct 2009 00:15:13 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 07 Oct 2009 00:15:08 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 05F5088722 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 20:15:07 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute2.internal (MEProxy); Tue, 06 Oct 2009 20:15:07 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 9D6797DA9; 	Tue,  6 Oct 2009 20:15:06 -0400 (EDT)
Message-ID: <4ACBDD83.6080307@cwilson.fastmail.fm>
Date: Wed, 07 Oct 2009 00:15:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Merge pseudo-reloc-v2 support from mingw/pseudo-reloc.c
References: <4ACBD892.5040508@cwilson.fastmail.fm>
In-Reply-To: <4ACBD892.5040508@cwilson.fastmail.fm>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00067.txt.bz2

> On Tue, Oct 06, 2009 at 07:53:54PM -0400, Charles Wilson wrote:
>>Hence, three separate "entries". One question: when it comes time to
>>commit this to CVS, should it be done all in one lump, or 1-2-3 very
>>quick separate commits (even though the tree would be broken between,
>>say, #1 and #2)?
> 
> I don't see why you shouldn't check in everything together since it's
> all one "change set". It's not like you could just back out Kai's changes
> individually and still get a working cygwin, right?

Correct. You really need all three bits for a working solution.
(Although the ChangeLog as I posted it is in traditional reverse-order.
Kai's bits would go first, then my changes to pseudo-reloc.c, and last
my changes to the other files).

I just figured it made sense to split up the ChangeLog, because I didn't
want to take credit for Kai's changes, but I did want to document what I
did, beyond the mingw/ version (which should make it easier when I
submit THOSE changes back to the mingw folks).  Furthermore, I figure
somebody might scan the ChangeLog looking for people without a Red Hat
copyright assignment, and get nervous if they saw:

date  Charles Wilson  <...>  <<--- has assignment
      Kai Teitz  <...>       <<--- no assignment (?)

      A bunch of changes

The way I split the ChangeLog up, it is clear that Kai only touched the
public domain file.

Anyway, once I had split up the ChangeLog, I simply wondered if I should
/also/ split up the commits.  If you're happy with one-big-lump, so am I
-- that's easier.

But I think the ChangeLog should remain 'segregated' like I posted it.

--
Chuck
