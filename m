Return-Path: <cygwin-patches-return-4746-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7576 invoked by alias); 13 May 2004 20:08:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7567 invoked from network); 13 May 2004 20:08:01 -0000
Date: Thu, 13 May 2004 20:08:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
Message-ID: <20040513200801.GA8666@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com> <20040507032703.GA950@coe.bosbc.com> <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00098.txt.bz2

On Thu, May 13, 2004 at 02:58:00PM -0500, Brian Ford wrote:
>On Thu, 6 May 2004, Christopher Faylor wrote:
>>Thanks, but, I see that you're using busy loops.  I use those in places
>>where I have no choice but to do so or when the potential for a race is
>>unlikely.
>>
>>I don't think that this is really a situation that qualifies for
>>either.  It seems like a muto is a cleaner choice here.
>
>Sorry for the delay; my free time has been in short supply lately.
>
>I can't seem to make a muto fit this situation cleanly since it would
>have to be acquired and released by the same thread.

Why would it be acquired and released from the same thread?  Isn't the
problem that multiple people are calling gethwnd?  You even mention this
in the ChangeLog below.  Given that, the place to put a mutex would seem
to be in gethwnd.

So, I'm not sure this patch is the right way to go.  Sorry!

I have a patch ready.  I was waiting to see if you had something ready
by the end of the day but, unfortunately, I don't think your patch is
moving in the right direction.

Do you have a simple test case which tickles the problem, by any chance?
I'd like to see if what I've done actually solves anything.

cgf

>2004-05-13  Brian Ford  <ford@vss.fsi.com>
>
>	* window.cc (window_started): Make NO_COPY.
>	(gethwnd): Fix initialization race.
>	(window_init): New function to initialize window_started.
>	* winsup.h (window_init): Prototype it.
>	* dcrt0.cc (dll_crt0_1): Call it.
