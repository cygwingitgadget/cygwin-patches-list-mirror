Return-Path: <cygwin-patches-return-1660-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17700 invoked by alias); 7 Jan 2002 16:41:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17675 invoked from network); 7 Jan 2002 16:41:33 -0000
Date: Mon, 07 Jan 2002 08:41:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: getsem cleanup
Message-ID: <20020107164140.GA4029@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <013601c19784$1f95c1f0$0200a8c0@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013601c19784$1f95c1f0$0200a8c0@lifelesswks>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00017.txt.bz2

On Tue, Jan 08, 2002 at 01:03:45AM +1100, Robert Collins wrote:
>My first foray into signals...
>
>ChangeLog:
>
>2002-01-08  Robert Collins  rbtcollins@hotmail.com
>
>    * sigproc.cc (getsem): Rearrange code to be more readable, and to
>    always output an error if accessing or creating the semaphore fails.

A couple of problems with this:

If I'm reading the patch correctly, it changes the behavior of cygwin so
that cygwin will output an error in the case of a failing OpenSemaphore.
That's not right.  The current behavior is correct.  The only time you
should see an error is when the process is creating a semaphore for
itself.  It should always be able to do that.

I'll clean up the code in getsem a little to make this more obvious.

cgf
