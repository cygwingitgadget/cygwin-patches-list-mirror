Return-Path: <cygwin-patches-return-2436-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26279 invoked by alias); 15 Jun 2002 01:05:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26219 invoked from network); 15 Jun 2002 01:05:29 -0000
Date: Fri, 14 Jun 2002 18:05:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Mount interaction with /dev & /proc entries
Message-ID: <20020615010600.GB5699@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <003c01c213f3$2ed077f0$6132bc3e@BABEL> <005801c213f6$ab0e2a30$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005801c213f6$ab0e2a30$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00419.txt.bz2

On Fri, Jun 14, 2002 at 11:56:06PM +0100, Conrad Scott wrote:
>Before anyone else gets there, I'll reply to my own message (what a
>change).
>
>The patch I just sent for path.cc breaks (at least) find(1) on
>/proc/registry -- it doesn't descend into it at all. Sorry.
>
>So I've got something wrong in my understanding of the cygwin/win32
>stuff (which doesn't surprise me). It still seems that something like
>this change should be made. One difference betwen /proc and /dev is
>that the /dev fs doesn't contain any directories. I'll go look some
>more.

Conrad -- I wouldn't bother investigating this for now.

I have been sitting on the beginnings of a rewrite for the mount stuff.
I think that 1.3.12 (or whatever) should have some improvements in this
regard.

Thanks for pointing out the problem with /proc, though.  You're right that
it should still be visible during a chroot.  I'm not too worried about that
for 1.3.11, though.

cgf
