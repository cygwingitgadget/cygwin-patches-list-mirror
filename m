Return-Path: <cygwin-patches-return-2263-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1983 invoked by alias); 30 May 2002 00:36:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1932 invoked from network); 30 May 2002 00:36:51 -0000
Date: Wed, 29 May 2002 17:36:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: New stat stuff (was [PATCH] improve performance of stat() ope rations (e.g. ls -lR ))
Message-ID: <20020530003645.GC3497@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FE045D4D9F7AED4CBFF1B3B813C853376762CA@mail.sandvine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FE045D4D9F7AED4CBFF1B3B813C853376762CA@mail.sandvine.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00246.txt.bz2

On Wed, May 29, 2002 at 08:30:09PM -0400, Don Bowman wrote:
>
>> On Tue, May 28, 2002 at 10:25:37PM -0400, Christopher Faylor wrote:
>> >On Tue, May 28, 2002 at 09:58:52PM -0400, Don Bowman wrote:
>> >>
>> >>So I've performed a mini-benchmark of Chris' changes.
>> >>
>> >>I did a ls -lR >/dev/null of the cygwin source tree on my
>> >>notebook.
>> >>
>> >>Baseline (current setup.exe install): 1m14.9s
>> >>'statquery' patch I sent earlier: 4.081s
>> >>Current CVS tree: 3.718s
>> >>Current CVS tree w/ -E switch to mount: 3.711s
>> >>Current CVS tree w/ -X switch to mount: 3.716s
>> >>
>> >>Not all that scientific, I ran each twice, took the 2nd timing.
>> >>So, looks good, excellent work. I still don't see any 
>> >>difference on the -E or the -X tho'.
>> >
>> >That has got to mean that there's something wrong in the stat
>> >logic.  I didn't do anything to speed up the normal case, AFAIK,
>> >unless you're doing this on a FAT/FAT32 partition.
>> 
>> Actually, even in that case, it shouldn't make that big a deal.
>
>Its the anti-virus. Your change no longer opens the file for read,
>so the anti-virus doesn't do anything, thus the enormous difference.
>As to why the negligible difference between -E/-X/nothing, no
>idea.

No, my change should not have stopped the file from being opened
in the normal case.  It was only in the -E, -X cases that it should
have an effect.

I did have a logic error which is corrected in the latest snapshot.

cgf
