Return-Path: <cygwin-patches-return-4164-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12205 invoked by alias); 4 Sep 2003 14:06:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12186 invoked from network); 4 Sep 2003 14:06:30 -0000
Message-ID: <3F5746ED.B9AE81B4@phumblet.no-ip.org>
Date: Thu, 04 Sep 2003 14:06:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] nanosleep()
References: <3.0.5.32.20030903232651.00814100@incoming.verizon.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00180.txt.bz2

Christopher Faylor wrote:
>On Wed, Sep 03, 2003 at 11:26:51PM -0400, Pierre A. Humblet wrote:
>>This patch to nanosleep, sleep and usleep 
>>a) makes them Posix conformant: the system clock (gettimeofday) must 
>>   advance by at least d during Xsleep(d) 
>>  (e.g. exim relies on this to create unique ids).
>
>And it doesn't, do that now, because...?
  it doesn't round up to the clock resolution (see ChangeLog)

>>b) improves the resolution of the result by using the multimedia 
>>   timer. 
>
>And it does that how...?
  by calling timeGetTime instead of GetTickCount (see ChangeLog)

>>c) calls timeBeginPeriod in forked processes.
>
>This one at least doesn't deserve a discussion.  Or does it?  Is
>timeBeginPeriod necessary in a forked process?
 By a strict reading of MS, yes. I have also experimented. On at 
 least one system I have noticed the clock resolution in the child 
 getting worse after the death of its parent. This seems to indicate
 that (at least some) Windows considers all processes when setting
 the resolution, but it wouldn't be safe to assume that there always
 is some other process with the desired resolution.

>Large patches with lots of reorganization and minimal explanation about
>why are quite time consuming to review.  This is why on most patches
>list the usual rule is one patch per concept.  I meant to mention this
>after your massive signal patch.
>
>For instance, c) above is a concept.  It could probably have been a
>separate patch.
>
>So, I would appreciate it if you could break this down into separate
>concepts and explain the concepts as you go along.  Call me selfish, but
>it reduces my workload to have you explain what you are doing in bite
>size chunks so that I don't have to spend a lot of time trying to
>separate out your patch into separate issues myself.

OK, that will be for tonight. I will split into two patches: 
1) hires.h and times.cc, basically adding two methods to class hires_ms
   and changing minperiod to static NO_COPY.
2) signals.cc, applying the new methods to nanosleep and making minor
   fixes.
Note that if I had sent only the first one I would have had to justify
why the new methods are useful and you would have had to trust that 
they are. Now you can judge directly.
The complexity of this patch is minimal.

Pierre
