Return-Path: <cygwin-patches-return-2250-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26482 invoked by alias); 29 May 2002 02:27:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26460 invoked from network); 29 May 2002 02:27:39 -0000
Date: Tue, 28 May 2002 19:27:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: New stat stuff (was [PATCH] improve performance of stat() ope rations (e.g. ls -lR ))
Message-ID: <20020529022723.GB20997@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FE045D4D9F7AED4CBFF1B3B813C853376762B1@mail.sandvine.com> <20020529022537.GA20997@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020529022537.GA20997@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00233.txt.bz2

On Tue, May 28, 2002 at 10:25:37PM -0400, Christopher Faylor wrote:
>On Tue, May 28, 2002 at 09:58:52PM -0400, Don Bowman wrote:
>>
>>So I've performed a mini-benchmark of Chris' changes.
>>
>>I did a ls -lR >/dev/null of the cygwin source tree on my
>>notebook.
>>
>>Baseline (current setup.exe install): 1m14.9s
>>'statquery' patch I sent earlier: 4.081s
>>Current CVS tree: 3.718s
>>Current CVS tree w/ -E switch to mount: 3.711s
>>Current CVS tree w/ -X switch to mount: 3.716s
>>
>>Not all that scientific, I ran each twice, took the 2nd timing.
>>So, looks good, excellent work. I still don't see any 
>>difference on the -E or the -X tho'.
>
>That has got to mean that there's something wrong in the stat
>logic.  I didn't do anything to speed up the normal case, AFAIK,
>unless you're doing this on a FAT/FAT32 partition.

Actually, even in that case, it shouldn't make that big a deal.

cgf
