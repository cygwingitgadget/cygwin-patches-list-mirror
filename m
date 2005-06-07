Return-Path: <cygwin-patches-return-5534-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3794 invoked by alias); 7 Jun 2005 16:22:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3752 invoked by uid 22791); 7 Jun 2005 16:22:40 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 07 Jun 2005 16:22:39 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id B912513C28E; Tue,  7 Jun 2005 12:22:39 -0400 (EDT)
Date: Tue, 07 Jun 2005 16:22:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take 3
Message-ID: <20050607162239.GS16960@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050606235137.GE16960@trixie.casa.cgf.cx> <SERRANOW6Ex3AkwtsQz00000312@SERRANO.CAM.ARTIMI.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SERRANOW6Ex3AkwtsQz00000312@SERRANO.CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00130.txt.bz2

On Tue, Jun 07, 2005 at 05:10:16PM +0100, Dave Korn wrote:
>----Original Message----
>>From: Christopher Faylor
>>Sent: 07 June 2005 00:52
>>On Mon, Jun 06, 2005 at 04:11:32PM -0700, Max Kaehn wrote:
>>>On Mon, 2005-06-06 at 16:07, Igor Pechtchanski wrote:
>>>>I take it you meant
>>>>
>>>>-       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) ;\
>>>>+       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) &&\
>>>
>>>Oh, right, this is the world of shell scripts, not C.  Thanks for
>>>catching that.
>>
>>Actually neither is right.  The tests are supposed to run to
>>completion, not stop on a failure.
>
>I'm of the opinion that cygload should be a subdirectory of
>winsup/testsuite/winsup.api, since it's a functionality of the winsup
>api that's being tested here, not an entire new tool.

I think you're right.  I checked this in just to get something that we
could play with.  I thought that we'd move this around a little
eventually.

What might make sense is to either have a "mingw" directory where
targets are built with '-mno-cygwin' or to adopt a convention that files
with the name '-mingw' are built with '-mno-cygwin'.

Brian could possibly use something like that for his SYSTEMROOT test.

cgf
