Return-Path: <cygwin-patches-return-4980-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7884 invoked by alias); 22 Sep 2004 16:07:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7806 invoked from network); 22 Sep 2004 16:07:17 -0000
Date: Wed, 22 Sep 2004 16:07:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Still path.cc
In-Reply-To: <20040922143054.GF26453@trixie.casa.cgf.cx>
Message-ID: <Pine.CYG.4.58.0409221047150.2736@fordpc.vss.fsi.com>
References: <3.0.5.32.20040921215840.0081d100@incoming.verizon.net>
 <Pine.CYG.4.58.0409220918030.2736@fordpc.vss.fsi.com>
 <20040922143054.GF26453@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q3/txt/msg00132.txt.bz2

On Wed, 22 Sep 2004, Christopher Faylor wrote:

> On Wed, Sep 22, 2004 at 09:20:50AM -0500, Brian Ford wrote:
> >On Tue, 21 Sep 2004, Pierre A. Humblet wrote:
> >>Avoid infinite loop with names starting in double dots.
> >
> >This may not be appropriate for this list, but...
> >
> >Thank you, thank you, thank you! I often mistype ../somewhere as
> >..somewhere and lock up my shell.
>
> Are you saying that you noticed this problem and didn't report it?
> Or, did you report it and we missed it?
>
> If it's the former then shame on you.  If it is the latter then shame on
> us and minor shame on you for not being persistent in bringing this
> serious bug to our attention.

Ok, shame on me, but it was more like:

Hm..., I just locked up my shell.  Wonder why...?  Oh well, no time to
investigate now.  I'm in the middle of a deadline.

[days pass...]

Hm..., I just locked up my shell again.  It looks like it was because I
mistyped that path as ..somewhere instead of ../somewhere.  Oh well, no
time to investigate now.  I'm in the middle of another deadline.

[days pass...]

Oh, great!  Pierre just fixed that shell lock up problem I was having.  I
should say thank you.

Ya know, it does take time to develop a good bug report, and I like to
understand the problem well before reporting it.  If I have time to do
that much, I usually have time to either fix it, or pinpoint the part
of the code with the problem.

I wouldn't have called it serious.  It seemed like a corner case to me,
so that's why I didn't think it was urgent.

You can't win here.  If you're a developer like person, the answer to bug
reports is usually "fix it yourslef if it's important to you".  If you
don't report it, but say thank you when someone fixes it, you get "shame
on you for not reporting this serious bug".

I'm not really as frustrated as I sound, though ;-).

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
