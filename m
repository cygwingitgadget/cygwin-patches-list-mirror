Return-Path: <cygwin-patches-return-4752-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23786 invoked by alias); 14 May 2004 04:24:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23772 invoked from network); 14 May 2004 04:24:03 -0000
Date: Fri, 14 May 2004 04:24:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
Message-ID: <20040514042403.GA20769@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com> <20040507032703.GA950@coe.bosbc.com> <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com> <20040513200801.GA8666@coe.bosbc.com> <Pine.CYG.4.58.0405131519060.3944@fordpc.vss.fsi.com> <20040513210306.GD11731@coe.bosbc.com> <Pine.CYG.4.58.0405131614030.3944@fordpc.vss.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0405131614030.3944@fordpc.vss.fsi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00104.txt.bz2

On Thu, May 13, 2004 at 04:21:48PM -0500, Brian Ford wrote:
>On Thu, 13 May 2004, Christopher Faylor wrote:
>
>> Either the hwnd exists or it doesn't.
>
>Ok.
>
>> If it does exist, just return it.  No locking required.
>
>Ok, add:
>
>if (ourhwnd)
>  return ourhwnd;
>
>to the beginning of my patch if your worried about the interlocked
>overhead and don't mind a double test.

If you had said: "I was trying to avoid having a persisent muto for what
is basically a one-time use" that would have made a lot more sense to me.

What you said was: "I can't use a muto because a muto would have to be
acquired and released by the same thread".

There is nothing in this message that I can see which supports this claim.
When someone makes a claim like this, I immediately think that they do not
understand the actual problem and, so, do not devote a lot of time into
looking at any proposed solution.

I'm sure you understand this since you frequently say that you have
little time to work on cygwin.  Given that nearly everyone who donates
time to work on free software is similarly constrained, it should not
be surprising that eventually we develop short cuts for making sure that
any time we spend is spent effectively.

Looking for little clues of "not getting it" is usually a good way of
figuring out how much time to spend on an issue.

I can see the merits in trying to avoid an additional handle but I don't
think inventing a mutex-like structure just for use in windows.cc merits
that much effort.  It's difficult for me, looking at your code, to
verify that you have achieved thread safety.  It's a lot easier for me,
writing standard code, with a standard cygwin control structure, to
verify thread safety.

However, I'll look at your code again with my new understanding of your
intent.

cgf
