Return-Path: <cygwin-patches-return-2830-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23508 invoked by alias); 15 Aug 2002 20:29:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23494 invoked from network); 15 Aug 2002 20:29:24 -0000
Date: Thu, 15 Aug 2002 13:29:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Interlocked functions
Message-ID: <20020815202936.GB21949@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0208152120090.-376009@thomas.kefrig-pfaff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0208152120090.-376009@thomas.kefrig-pfaff.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00278.txt.bz2

On Thu, Aug 15, 2002 at 09:38:52PM +0200, Thomas Pfaff wrote:
>
>With my mutex implementation i ran into the problem that the
>InterlockedCompareExchange call ist not available on Win95.
>
>IMHO there exist 3 possibilities:
>
>Do not apply my mutexes :-(
>Drop support for WIN95.
>Create assembler versions of the interlocked functions. Now the code will
>not on run on old i386 machines. This is my favourite solution.
>
>Chris has alreay created inline functions for Interlocked... in winbase.h,
>i have added an ilockcmpexch and converted them into real functions in a
>new file called winbase.c because i had some trouble with O2 optimization
>and the inline functions.

Argh.  So, you lose all of the inline optimization.  It sounds like you
have to play with your implementation some more.

The linux kernel manages to work fine with -O2 optimization.  There is no
reason why we can't do the same.

cgf
