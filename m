Return-Path: <cygwin-patches-return-2174-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31789 invoked by alias); 12 May 2002 01:39:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31768 invoked from network); 12 May 2002 01:39:12 -0000
Date: Sat, 11 May 2002 18:39:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_join fix
Message-ID: <20020512013931.GA31225@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <F0E13277A26BD311944600500454CCD0513601-101000@antarctica.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F0E13277A26BD311944600500454CCD0513601-101000@antarctica.intern.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00158.txt.bz2

What's the status of these patches?

I've been holding off on releasing 1.3.11 based on these patches, the
potential for fixing socket problems, and the ever-crucial EISDIR
problem in the cygwin mailing list.

cgf

On Wed, Apr 24, 2002 at 12:18:19PM +0200, Thomas Pfaff wrote:
>Rob,
>
>this is an incremental update to my pthread patches. It will fix a problem
>when a thread is joined before the creation completed.
>
>BTW, i have not added any locks yet (the actual implementation had no),
>but IMHO they are required in the exit,join,cancel code. I will add locks
>if you agree.
>
>Greetings,
>Thomas
>
>2002-04-24  Thomas Pfaff  <tpfaff@gmx.net>
>
>	* thread.cc (thread_init_wrapper): Check if thread is alreay
>	joined
>	(__pthread_join): Set joiner first.
>	(__pthread_detach): Ditto.
>
>

