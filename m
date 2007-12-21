Return-Path: <cygwin-patches-return-6203-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12851 invoked by alias); 21 Dec 2007 03:07:22 -0000
Received: (qmail 12758 invoked by uid 22791); 21 Dec 2007 03:07:21 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-37-220.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (96.233.37.220)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Dec 2007 03:07:17 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 901242B352; Thu, 20 Dec 2007 22:07:15 -0500 (EST)
Date: Fri, 21 Dec 2007 03:07:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] un-NT-ify cygcheck (was: cygwin 1.5.25-7: cygcheck 	does not   work?)
Message-ID: <20071221030715.GB28930@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <836045.82708.qm@web33207.mail.mud.yahoo.com> <476A726D.50100@byu.net> <476A78EF.2322FB0A@dessent.net> <476A8729.5C05B169@dessent.net> <20071220211130.GA28771@ednor.casa.cgf.cx> <047a01c84375$2f2cf810$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <047a01c84375$2f2cf810$2e08a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00055.txt.bz2

On Fri, Dec 21, 2007 at 01:59:54AM -0000, Dave Korn wrote:
>On 20 December 2007 21:12, Christopher Faylor wrote:
>
>> On Thu, Dec 20, 2007 at 07:15:53AM -0800, Brian Dessent wrote:
>>> The attached patch un-NT-ifies bloda.cc but sadly a similar cleanup is
>>> still required for cygpath as well if we are to support 9x/ME out of the
>>> 1.5 branch. In that case I suppose you could just revert cygpath.cc to
>>> an older revision before the native APIs were added.
>
>> I had something similar in my sandbox but 1) you beat me to it and 2)
>> yours is better.  So, please check this into the trunk.  I don't have
>> any problem with cygcheck being Windows 9x aware since it could help us
>> track down problems with people who are trying to run Cygwin 1.7.x on
>> older systems.
>> 
>> Unless Corinna says differently, I think she wants to be in control of
>> what goes into the branch so I don't want to suggest that you should
>> check it in there too.
>
>But it only belongs on the branch at all, doesn't it?  When I wrote
>bloda.cc, I didn't bother with 9x compat, because I was only writing it
>for HEAD, where we have stopped supporting 9x.
>
>Surely there are many other reasons why HEAD won't work on 9x, so the
>only benefit would be in applying this patch to the branch?

I explained my logic above:

"I don't have any problem with cygcheck being Windows 9x aware since it
could help us track down problems with people who are trying to run
Cygwin 1.7.x on older systems."

The problem in this case would be "Hey!  Look at what cygcheck is saying!
You are using Windows 9x!  You can't do that!"

OTOH, you could make a case that cygcheck on the trunk should just
consider Windows 9x and friends to be dodgy apps and should issue a
clear error in that case.

cgf
