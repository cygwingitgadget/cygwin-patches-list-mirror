Return-Path: <cygwin-patches-return-4754-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26151 invoked by alias); 14 May 2004 16:20:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26131 invoked from network); 14 May 2004 16:20:18 -0000
Date: Fri, 14 May 2004 16:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
Message-ID: <20040514162017.GA21214@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com> <20040507032703.GA950@coe.bosbc.com> <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com> <20040513200801.GA8666@coe.bosbc.com> <Pine.CYG.4.58.0405131519060.3944@fordpc.vss.fsi.com> <20040513210306.GD11731@coe.bosbc.com> <Pine.CYG.4.58.0405131614030.3944@fordpc.vss.fsi.com> <20040514042403.GA20769@coe.bosbc.com> <Pine.CYG.4.58.0405141004020.3944@fordpc.vss.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0405141004020.3944@fordpc.vss.fsi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00106.txt.bz2

On Fri, May 14, 2004 at 10:59:42AM -0500, Brian Ford wrote:
>> However, I'll look at your code again with my new understanding of your
>> intent.
>
>No need.  Just before falling a sleep last night, I remembered a case I
>had not covered correctly.  If the initialization fails the first time,
>the event is not reset.  Can this just be a fatal condition?

I think it should be, yes.  Otherwise, you just have cascading failures
and the thing that eventually causes cygwin to crash may not be the root
cause of the problem.

>I'll cook up a muto based solution in the next few minutes now
>that I understand your preference.  But, I'd like an opinion on the
>question above.

Thanks very much for the offer, but please don't bother.  I took this
opportunity to do some of the cleanup that I was talking about.  I also
implemented a "close handle on final use" option to mutos so that the
event doesn't stay around after the final thread releases it.

I need to do a little debugging on what I have but it does try to clean
up the windows code slightly.  I even eliminated the thread event
synchronization entirely.

Btw, a muto is supposed to be equivalent to a windows mutex in most
respects except that it is supposed to be somewhat lighter weight.

cgf
