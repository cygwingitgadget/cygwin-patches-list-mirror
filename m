Return-Path: <cygwin-patches-return-2938-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11405 invoked by alias); 6 Sep 2002 04:23:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11390 invoked from network); 6 Sep 2002 04:23:47 -0000
Date: Thu, 05 Sep 2002 21:23:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [cgf@redhat.com: Re: [Mingw-users] Re: WINVER constant value [WAS: GetConsoleWindow]]
Message-ID: <20020906042335.GA28278@redhat.com>
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00386.txt.bz2

----- Forwarded message from Christopher Faylor <cgf@redhat.com> -----

From: Christopher Faylor <cgf@redhat.com>
To: "Andrew 'Static' Stadt" <acstadt@sympatico.ca>
Cc: Mingw-users <mingw-users@lists.sourceforge.net>
Subject: Re: [Mingw-users] Re: WINVER constant value [WAS: GetConsoleWindow]
Date: Fri, 6 Sep 2002 00:09:34 -0400
In-Reply-To: <EMEJLKIHGFHGPDDBKMEGAEIMCAAA.acstadt@sympatico.ca>

On Thu, Sep 05, 2002 at 10:46:25PM -0400, Andrew 'Static' Stadt wrote:
>I'll admit that the first time I attempted to use a newer api call, the
>error threw me for a little bit of a loop, but all I had to do was read the
>appropriate header file, and the added the appropriate define in my
>makefile. ( a side note here to note my own glaring stupidity at the time: I
>was attempting to use an api call which didn't exist on the target platform,
>but my client had also given my some misleading specs, so I'm not entirely
>to blame).
>
>Do I wish it had been documented somewhere?  A knee-jerk response says yes,
>but in retrospect, how many people actually read all of the documentation
>supplied with all of their software/tools/etc.

However, if there was someplace to point people who stumble across this then
at least we wouldn't have to be reexplaining the issue.

>In this particular case, I don't believe that having someone actually
>look in the header file to see what's going on would be such a
>hardship.  Admittedly, I wouldn't mind a little table somewhere which
>lists the 'common name' (e.g.  w2k), with its appropriate WINVER
>value...  but then again, its something I should probably add to my own
>reference notes vs.  spending so much time on msdn.
>
>So, my $0.02 is that I like it the way it is.

So what would the downside be to you if the WINVER was set to the highest
legal value?  You'd still know enough to look in the header file if
something was amiss.  And, people who were used to MSVC would still
have the environment they were used to.

cgf


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
_______________________________________________
MinGW-users mailing list
MinGW-users@lists.sourceforge.net

You may change your MinGW Account Options or unsubscribe at:
https://lists.sourceforge.net/lists/listinfo/mingw-users

----- End forwarded message -----
