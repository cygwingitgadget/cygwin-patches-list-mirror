Return-Path: <cygwin-patches-return-3072-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20485 invoked by alias); 21 Oct 2002 16:18:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20469 invoked from network); 21 Oct 2002 16:18:56 -0000
Date: Mon, 21 Oct 2002 09:18:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_tty deadlock patch
Message-ID: <20021021162038.GB15828@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021018011921.A20255@hagbard.io.com> <Pine.GSO.4.44.0210202249210.18735-101000@slinky.cs.nyu.edu> <20021021010303.A2647@eris.io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021021010303.A2647@eris.io.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00023.txt.bz2

On Mon, Oct 21, 2002 at 01:03:03AM -0500, Steve O wrote:
>On Sun, Oct 20, 2002 at 11:15:47PM -0400, Igor Pechtchanski wrote:
>> However, there are a couple of problems with this patch.  For example,
>> this makes bash run from a command prompt (or a shortcut) treat every
>> character as a ^D.
>
>So every character closes bash?  I'm not able to reproduce this on
>WinXP, have an strace?
>
>> /bin/sh ignores Enter (or ^J, or ^M).  
>
>Good find.  I've attached a diff that should fix this.  Unsure
>how to proceed since the original patch hasn't been applied.
>Do I resubmit the original patch or treat this one as it's own
>thing?

Keep resubmitting on large patch until it is accepted.

My time is limited right now so I may not be able to completely review
this for a couple of weeks.  I'm going to be on a business trip starting
on Wednesday.

So, I would appreciate it if people would try this out and report their
experiences.

cgf
