Return-Path: <cygwin-patches-return-7095-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31448 invoked by alias); 11 Sep 2010 05:10:30 -0000
Received: (qmail 31417 invoked by uid 22791); 11 Sep 2010 05:10:17 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-46-163.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.46.163)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sat, 11 Sep 2010 05:10:11 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id A86D813C061	for <cygwin-patches@cygwin.com>; Sat, 11 Sep 2010 01:10:09 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 9F8742B352; Sat, 11 Sep 2010 01:10:09 -0400 (EDT)
Date: Sat, 11 Sep 2010 05:10:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add fenv.h and support.
Message-ID: <20100911051009.GA25209@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C8A9AC8.7070904@gmail.com> <20100910214347.GA23700@ednor.casa.cgf.cx> <4C8AD089.9000605@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C8AD089.9000605@gmail.com>
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
X-SW-Source: 2010-q3/txt/msg00055.txt.bz2

On Sat, Sep 11, 2010 at 01:42:49AM +0100, Dave Korn wrote:
>On 10/09/2010 22:43, Christopher Faylor wrote:
>
>> Looks nice to me with one HUGE caveat:  Please maintain the pseudo-sorted
>> order in cygwin.din.  Sorry to have to impose this burden on you.
>
>  No, that's fine; I've never been sure whether we need to care about the
>ordinal numbers or not in that file.  (AFAIK, we don't have any realistic
>scenarios where anyone would be linking against the Cygwin DLL by ordinal
>imports, but I hate making assumptions based only on my own limited experience...)

It never even occurred to me about ordinal numbers but since I've been
reorganizing that file for years I guess it hasn't been a problem.

cgf
