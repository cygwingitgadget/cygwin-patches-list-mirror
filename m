Return-Path: <cygwin-patches-return-4755-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24802 invoked by alias); 14 May 2004 17:40:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24790 invoked from network); 14 May 2004 17:40:44 -0000
Date: Fri, 14 May 2004 17:40:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
In-Reply-To: <20040514162017.GA21214@coe.bosbc.com>
Message-ID: <Pine.CYG.4.58.0405141205590.3944@fordpc.vss.fsi.com>
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com>
 <20040507032703.GA950@coe.bosbc.com> <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com>
 <20040513200801.GA8666@coe.bosbc.com> <Pine.CYG.4.58.0405131519060.3944@fordpc.vss.fsi.com>
 <20040513210306.GD11731@coe.bosbc.com> <Pine.CYG.4.58.0405131614030.3944@fordpc.vss.fsi.com>
 <20040514042403.GA20769@coe.bosbc.com> <Pine.CYG.4.58.0405141004020.3944@fordpc.vss.fsi.com>
 <20040514162017.GA21214@coe.bosbc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q2/txt/msg00107.txt.bz2

On Fri, 14 May 2004, Christopher Faylor wrote:

> On Fri, May 14, 2004 at 10:59:42AM -0500, Brian Ford wrote:
> >I'll cook up a muto based solution in the next few minutes now
> >that I understand your preference.  But, I'd like an opinion on the
> >question above.
>
> Thanks very much for the offer, but please don't bother.

Ok, good.  I got sucked into an unscheduled meeting anyway.

> I took this opportunity to do some of the cleanup that I was talking
> about.  I also implemented a "close handle on final use" option to mutos
> so that the event doesn't stay around after the final thread releases
> it.

That sounds like a nice, but difficult to get right enhancement.

> I need to do a little debugging on what I have but it does try to clean
> up the windows code slightly.  I even eliminated the thread event
> synchronization entirely.

I tried to do that but got stuck when I discovered you can't pass the
return from CreateWindow in one thread to the GetMessage call in another.

I look forward to seeing what you did and learning from it.  Thanks.

> Btw, a muto is supposed to be equivalent to a windows mutex in most
> respects except that it is supposed to be somewhat lighter weight.

Yes.  What I don't get is why it is significantly different from a
CriticalSection.  AFAICT, they are the same except mutos don't spin?
I'm still a win32 API newbee.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
