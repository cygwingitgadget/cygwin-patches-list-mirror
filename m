Return-Path: <cygwin-patches-return-2254-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18844 invoked by alias); 29 May 2002 05:19:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18828 invoked from network); 29 May 2002 05:19:39 -0000
Date: Tue, 28 May 2002 22:19:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: New stat stuff (was [PATCH] improve performance of stat() operations (e.g. ls -lR ))
Message-ID: <20020529051934.GA10833@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <024701c2051d$e13cbdc0$6132bc3e@BABEL> <20020527022339.GA15585@redhat.com> <20020527142437.A26046@cygbert.vinschen.de> <20020527174354.GB21314@redhat.com> <20020527203832.A27852@cygbert.vinschen.de> <20020527184452.GA21106@redhat.com> <20020528021816.GA2066@redhat.com> <003f01c20693$14cbb990$6132bc3e@BABEL> <20020528224031.GA17266@redhat.com> <00bb01c20699$af643c60$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00bb01c20699$af643c60$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00237.txt.bz2

On Tue, May 28, 2002 at 11:47:45PM +0100, Conrad Scott wrote:
>"Christopher Faylor" <cgf@redhat.com> wrote:
>> On Tue, May 28, 2002 at 11:00:28PM +0100, Conrad Scott wrote:
>> >I've just picked up the latest changes from CVS and I'm having a problem
>> >with run.exe from a .BAT file (i.e., from my current cygwin.bat
>mechanism).
>>
>> What's run.exe?
>>
>> cgf
>
>Sorry: it's /usr/X11R6/bin/run.exe, which was recommended by some as the
>best way to launch rxvt from the cygwin.bat file. AFAIK it's meant to avoid
>having the (irritating) command window pop-up before the rxvt window
>appears. However, it fails to achieve that and I'd never (until just now)
>taken it out of my cygwin.bat file.

I think you're running run.exe from Chuck Wilson's site.  I managed to
duplicate this behavior.  Apparently it happens because valid looking handles
exist for stdin/stdout/stderr even when a program is linked with -mwindows.
My new code attempted to do something with the handles and NT did something
nonsensical.  I've worked around the behavior.  It's checked in and in the
next snapshot.

cgf
