Return-Path: <cygwin-patches-return-4747-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20276 invoked by alias); 13 May 2004 20:28:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20263 invoked from network); 13 May 2004 20:28:19 -0000
Date: Thu, 13 May 2004 20:28:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
In-Reply-To: <20040513200801.GA8666@coe.bosbc.com>
Message-ID: <Pine.CYG.4.58.0405131519060.3944@fordpc.vss.fsi.com>
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com>
 <20040507032703.GA950@coe.bosbc.com> <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com>
 <20040513200801.GA8666@coe.bosbc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q2/txt/msg00099.txt.bz2

On Thu, 13 May 2004, Christopher Faylor wrote:

> >I can't seem to make a muto fit this situation cleanly since it would
> >have to be acquired and released by the same thread.
>
> Why would it be acquired and released from the same thread?

What I was trying to say is that a muto must be acquired and released from
the same thread.  But here, we want to block all threads calling gethwnd
until the window thread has initialized.

> Isn't the problem that multiple people are calling gethwnd?

Concurrently, before ourhwnd has been initialized, yes.

> You even mention this in the ChangeLog below.  Given that, the place to
> put a mutex would seem to be in gethwnd.

It seems to me that you would still need the window_started event then,
no?  Since a muto contains an event, why use two?  I thought this was
lighter weight.

> So, I'm not sure this patch is the right way to go.  Sorry!
>
> I have a patch ready.  I was waiting to see if you had something ready
> by the end of the day but, unfortunately, I don't think your patch is
> moving in the right direction.

I'm not sure why since you didn't voice a very compelling objection, but I
don't really care that much.  I was just trying to help out.

I'd like a chance to comment on your version, though.

> Do you have a simple test case which tickles the problem, by any chance?

I'm just using the original one presented here:

http://www.cygwin.com/ml/cygwin/2004-05/msg00232.html

> I'd like to see if what I've done actually solves anything.

Me too ;-).

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
