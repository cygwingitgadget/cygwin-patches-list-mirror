Return-Path: <cygwin-patches-return-2178-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29619 invoked by alias); 12 May 2002 19:23:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29560 invoked from network); 12 May 2002 19:23:15 -0000
Date: Sun, 12 May 2002 12:23:00 -0000
From: Christopher Faylor <cgf-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Subject: Re: [PATCH] Get recursive grep to work on Win9x
Message-ID: <20020512192304.GA2518@redhat.com>
Reply-To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, cygwin@cygwin.com
References: <3CDE8B30.95496DFA@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CDE8B30.95496DFA@cistron.nl>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00162.txt.bz2

On Sun, May 12, 2002 at 05:33:04PM +0200, Ton van Overbeek wrote:
>The patch is simple. It makes use of the wincap.can_open_directories()
>capability, which seems to be foreseen for exactly this type of problems.
>However I could not find an other place where this capability is used
>in the cygwin.dll.
>
>Patch attached: fhandler.diff

Thanks for the patch.

I've checked in a slightly different version which should have the same
effect.

I appreciate the time you spent tracking this down and researching the
correct method for fixing this.  I used roughly the same technique as
you but moved it to only affect the opening of disk files.  Hopefully,
it will fix your problem.

Btw, for future reference, your patch was reversed.  It should have been
diff -u foo.orig foo, i.e. the original file goes first.

Thanks again for tracking this down.

cgf
