Return-Path: <cygwin-patches-return-4710-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23352 invoked by alias); 5 May 2004 19:48:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23332 invoked from network); 5 May 2004 19:48:38 -0000
Date: Wed, 05 May 2004 19:48:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin@cygwin.com
To: Reza <rezmang@yahoo.com>
cc: cygwin-patches@cygwin.com, cygwin@cygwin.com
Subject: Re: cygwin1.dll 1.5.9-1 and pthread_exit: UNSTABLE
In-Reply-To: <20040505181724.87981.qmail@web50610.mail.yahoo.com>
Message-ID: <Pine.CYG.4.58.0405051420480.3220@fordpc.vss.fsi.com>
References: <20040505181724.87981.qmail@web50610.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q2/txt/msg00062.txt.bz2

Although you may have thought this message was on topic for this
list, since it is neither a patch submission, nor a direct reply to or
discussion of one, it is not on topic.  Please read:

http://cygwin.com/lists.html

before posting again.  Redirecting...

On Wed, 5 May 2004, Reza wrote:

> http://www.mail-archive.com/cygwin@cygwin.com/msg38397.html
>
> Why hasnt this issue been fixed yet?

THAT issue has been fixed.  I presume, by the following:

2004-04-12  Christopher Faylor  <cgf@alum.bu.edu>

        * thread.cc (pthread::create): Use thread mutex to control
        synchronization rather than creating a suspended thread.  Wait for
        "cancellation event" to indicate that started thread has been properly
        initialized.
        (pthread::thread_init_wrapper): Use set_tls_self_pointer() to set tid
        and cygtls.  Signal with cancel_event when done.

Although, that issue talks about pthread_kill, not pthread_exit, so I fail
to see how they are directly related.

> I cant find the fix/patch that is mentioned in the link.

Look harder please.

> I just downloaded and installed cygwin yesterday and ran into this
> problem.

Ok, use a snapshot then (http://cygwin.com/snapshots).

> Releasing an unstable version of cygwin for this long isn't a
> good idea (unless these are just isolated cases).

I strongly suggest you read:

http://cygwin.com/problems.html

as you did not describe your particular pthread_exit problem at all.
Also, this part might be especially informative:

* Avoid expressions of incredulity "I can't believe that this is so
broken!" or other editorializing. This should go without saying, really,
but, sadly, many people can't stop themselves from expressing their
outrage.

We would prefer that you didn't tell us what "a good idea" is.

Thanks.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
