Return-Path: <cygwin-patches-return-2262-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30880 invoked by alias); 30 May 2002 00:30:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30853 invoked from network); 30 May 2002 00:30:13 -0000
Message-ID: <FE045D4D9F7AED4CBFF1B3B813C853376762CA@mail.sandvine.com>
From: Don Bowman <don@sandvine.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: New stat stuff (was [PATCH] improve performance of stat() ope
	 rations (e.g. ls -lR ))
Date: Wed, 29 May 2002 17:30:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-SW-Source: 2002-q2/txt/msg00245.txt.bz2


> On Tue, May 28, 2002 at 10:25:37PM -0400, Christopher Faylor wrote:
> >On Tue, May 28, 2002 at 09:58:52PM -0400, Don Bowman wrote:
> >>
> >>So I've performed a mini-benchmark of Chris' changes.
> >>
> >>I did a ls -lR >/dev/null of the cygwin source tree on my
> >>notebook.
> >>
> >>Baseline (current setup.exe install): 1m14.9s
> >>'statquery' patch I sent earlier: 4.081s
> >>Current CVS tree: 3.718s
> >>Current CVS tree w/ -E switch to mount: 3.711s
> >>Current CVS tree w/ -X switch to mount: 3.716s
> >>
> >>Not all that scientific, I ran each twice, took the 2nd timing.
> >>So, looks good, excellent work. I still don't see any 
> >>difference on the -E or the -X tho'.
> >
> >That has got to mean that there's something wrong in the stat
> >logic.  I didn't do anything to speed up the normal case, AFAIK,
> >unless you're doing this on a FAT/FAT32 partition.
> 
> Actually, even in that case, it shouldn't make that big a deal.

Its the anti-virus. Your change no longer opens the file for read,
so the anti-virus doesn't do anything, thus the enormous difference.
As to why the negligible difference between -E/-X/nothing, no
idea.
