Return-Path: <cygwin-patches-return-2780-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31085 invoked by alias); 7 Aug 2002 01:23:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31056 invoked from network); 7 Aug 2002 01:23:35 -0000
Date: Tue, 06 Aug 2002 18:23:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: init_cheap and _csbrk
Message-ID: <20020807012331.GJ1386@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01e501c23d74$400b2c90$6132bc3e@BABEL> <20020806220731.GG1386@redhat.com> <013b01c23d99$a180f930$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013b01c23d99$a180f930$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00228.txt.bz2

On Tue, Aug 06, 2002 at 11:35:56PM +0100, Conrad Scott wrote:
>I wasn't thinking of efficiency while I was looking at this.  I
>was actually trying to understand an apparent memory leak on fork.
>(I found that BTW: it's the "well-known" one in the per_thread
>mechanism.  So I've stopped worrying about it.)
>
>But: the slop will never get used AFAICT (so it's not really
>slop).

You're right.  And even if I got the slop working there would still
be a call to VirtualAlloc.  It shouldn't matter since it will just
be allocating allocated memory but that means it probably isn't
really worth it anyway.  So, I've reorganized things one more time.
And, no more slop.

In the reorganization our aesthetic sense merged so I moved the
cygheap_max setting back into init_cheap.

cgf
