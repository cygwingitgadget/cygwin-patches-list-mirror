Return-Path: <cygwin-patches-return-4730-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7304 invoked by alias); 7 May 2004 15:14:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7253 invoked from network); 7 May 2004 15:14:47 -0000
Date: Fri, 07 May 2004 15:14:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
Message-ID: <20040507151447.GE3107@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com> <20040507032703.GA950@coe.bosbc.com> <409BA27E.379C0E06@hot.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409BA27E.379C0E06@hot.pl>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00082.txt.bz2

On Fri, May 07, 2004 at 04:51:42PM +0200, Jacek Trzmiel wrote:
>> On Thu, May 06, 2004 at 07:18:39PM -0500, Brian Ford wrote:
>>>Although not the complete rewrite you may have been hoping for, the
>>>attached patch does appear to fix the: Winmain: Cannot register window
>>>class, Win32 error 1410 portion of this bug:
>>>http://www.cygwin.com/ml/cygwin/2004-05/msg00232.html
>
>Christopher Faylor wrote:
>>Thanks, but, I see that you're using busy loops.  I use those in places
>>where I have no choice but to do so or when the potential for a race is
>>unlikely.
>>
>>I don't think that this is really a situation that qualifies for
>>either.  It seems like a muto is a cleaner choice here.
>
>I can change it to use critical section.  I just have one question -
>where would be good place to put InitializeCriticalSection call?

Please read what I said: "It seems like a muto is a cleaner choice
here."  muto != critical section.

I'm sure Brian can make the appropriate changes.  Let's give him the
opportunity to do so.

cgf
