Return-Path: <cygwin-patches-return-2247-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20365 invoked by alias); 29 May 2002 01:58:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20316 invoked from network); 29 May 2002 01:58:53 -0000
Message-ID: <FE045D4D9F7AED4CBFF1B3B813C853376762B1@mail.sandvine.com>
From: Don Bowman <don@sandvine.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: New stat stuff (was [PATCH] improve performance of stat() ope
	rations (e.g. ls -lR )) 
Date: Tue, 28 May 2002 18:58:00 -0000
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2002-q2/txt/msg00230.txt.bz2


So I've performed a mini-benchmark of Chris' changes.

I did a ls -lR >/dev/null of the cygwin source tree on my
notebook.

Baseline (current setup.exe install): 1m14.9s
'statquery' patch I sent earlier: 4.081s
Current CVS tree: 3.718s
Current CVS tree w/ -E switch to mount: 3.711s
Current CVS tree w/ -X switch to mount: 3.716s

Not all that scientific, I ran each twice, took the 2nd timing.
So, looks good, excellent work. I still don't see any 
difference on the -E or the -X tho'.
