Return-Path: <cygwin-patches-return-3993-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7867 invoked by alias); 6 Jul 2003 19:52:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7856 invoked from network); 6 Jul 2003 19:52:07 -0000
Date: Sun, 06 Jul 2003 19:52:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: chris@atomice.net
Subject: Re: hostid patch
Message-ID: <20030706195417.GA13239@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, chris@atomice.net
References: <20030430013844.GA21521@redhat.com> <ICEBIHGCEJIPLNMBNCMKOEHHCFAA.chris@atomice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ICEBIHGCEJIPLNMBNCMKOEHHCFAA.chris@atomice.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00009.txt.bz2

Argh.  I'm getting ready for a new release, noticed that gethostid now
is reported as an XPASS in the test suite and remembered this thread.

Chris, do you have time to fix this before the release?  Otherwise, I'll
have to remove gethostid.

cgf

On Sun, May 04, 2003 at 10:52:12AM +0100, Chris January wrote:
>> On Wed, Apr 30, 2003 at 11:04:43AM +1000, Robert Collins wrote:
>> >On Wed, 2003-04-30 at 11:00, Christopher Faylor wrote:
>> >
>> >> Three runs, two different results:
>> >
>> >I count three runs, three result there.
>>
>> Hmm.  You're right.  I thought the last two hostids were the same but
>> they obviously weren't.
>>
>> >Interestingly, the PSN was different on every case..
>>
>> Running under strace the PSN stayed the same for a long time.  I thought
>> it was going to be one of those "runs fine under strace" scenarios.
>>
>> >Is this a real box, or VMWare / bochs etc?
>>
>> It's an FreeBSD box running VMWare, running linux.  I'm running
>> cygwin under
>> wine on linux.  I can't see how that could be a problem. :-)
>>
>> >How many cpus are in it?
>>
>> cygcheck attached.  Hmm.  Cygcheck doesn't say how many CPUs, does it?
>>
>> /proc/cpuinfo attached, too.
>>
>> Two CPUs.  Different steppings for each.  The Dell BIOS kindly informs
>> me of that fact on each reboot.
>
>I neglected to set the Thread affinity when I got the CPU serial number, so
>it gets a different number for each CPU. As to why the last two values are
>off by five - I can't explain that without delving into the sources. I can't
>do that until I install Cygwin on my new machine.
>
>Chris
