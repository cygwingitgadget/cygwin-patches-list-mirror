Return-Path: <cygwin-patches-return-4753-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4868 invoked by alias); 14 May 2004 15:59:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4830 invoked from network); 14 May 2004 15:59:50 -0000
Date: Fri, 14 May 2004 15:59:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
In-Reply-To: <20040514042403.GA20769@coe.bosbc.com>
Message-ID: <Pine.CYG.4.58.0405141004020.3944@fordpc.vss.fsi.com>
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com>
 <20040507032703.GA950@coe.bosbc.com> <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com>
 <20040513200801.GA8666@coe.bosbc.com> <Pine.CYG.4.58.0405131519060.3944@fordpc.vss.fsi.com>
 <20040513210306.GD11731@coe.bosbc.com> <Pine.CYG.4.58.0405131614030.3944@fordpc.vss.fsi.com>
 <20040514042403.GA20769@coe.bosbc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q2/txt/msg00105.txt.bz2

On Fri, 14 May 2004, Christopher Faylor wrote:

> If you had said: "I was trying to avoid having a persisent muto for what
> is basically a one-time use" that would have made a lot more sense to me.

I thought you knew it was a one time event, and my reasoning was more:
"I was trying to avoid having a persistent muto since we need another
synchronization event anyway."

Obviously, I floundered in my communication.  Sorry, but I am *trying* to
be clear.  Email is not always my best medium.

> What you said was: "I can't use a muto because a muto would have to be
> acquired and released by the same thread".

Together with the above: "I can't use a muto as the *only* synchronization
object because..."

> There is nothing in this message that I can see which supports this claim.

I'm sure I missed the point here.  Obviously, the muto code supports that
claim muto::release:

  if (tid != this_tid || !visits)
    {
      SetLastError (ERROR_NOT_OWNER);   /* Didn't have the lock. */
      return 0; /* failed. */
    }

> When someone makes a claim like this, I immediately think that they do not
> understand the actual problem and, so, do not devote a lot of time into
> looking at any proposed solution.
>
> I'm sure you understand this since you frequently say that you have
> little time to work on cygwin.  Given that nearly everyone who donates
> time to work on free software is similarly constrained, it should not
> be surprising that eventually we develop short cuts for making sure that
> any time we spend is spent effectively.

I haven't found any good short cuts yet.  I hope I do soon.  That would
give me more time to work on Cygwin :-).  My perfectionist nature really
gets in the way here.

> Looking for little clues of "not getting it" is usually a good way of
> figuring out how much time to spend on an issue.

That's fair if you give the person a chance to explain.

> I can see the merits in trying to avoid an additional handle but I don't
> think inventing a mutex-like structure just for use in windows.cc merits
> that much effort.

Unfortunately, I did give it way too much effort, but this "structure"
is used in many other places.

What we really need is a broadcast condition variable.

> It's difficult for me, looking at your code, to verify that you have
> achieved thread safety.  It's a lot easier for me, writing standard
> code, with a standard cygwin control structure, to verify thread safety.

Mostly agreed, but the interlocked increment/decrement part is pseudo
standard Cygwin control structure.

> However, I'll look at your code again with my new understanding of your
> intent.

No need.  Just before falling a sleep last night, I remembered a case I
had not covered correctly.  If the initialization fails the first time,
the event is not reset.  Can this just be a fatal condition?  That would
sure make things simpler.  I don't think any calling code is prepared to
deal with that failure anyway.

I'll cook up a muto based solution in the next few minutes now
that I understand your preference.  But, I'd like an opinion on the
question above.

Thanks for being gentle with me.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
