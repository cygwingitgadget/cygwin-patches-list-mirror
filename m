Return-Path: <cygwin-patches-return-3727-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24352 invoked by alias); 20 Mar 2003 07:29:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24338 invoked from network); 20 Mar 2003 07:29:04 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Thu, 20 Mar 2003 07:29:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_equal
In-Reply-To: <1048111508.5305.166.camel@localhost>
Message-ID: <Pine.WNT.4.44.0303200826001.232-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00376.txt.bz2



On Wed, 19 Mar 2003, Robert Collins wrote:

> On Thu, 2003-03-20 at 00:54, Thomas Pfaff wrote:
> > 2003-03-19  Thomas Pfaff  <tpfaff@gmx.net>
> >
> > 	* pthread.cc (pthread_equal): Replacement for pthread_equal in
> > 	thread.cc.
> > 	* thread.cc: Rename pthread_equal to pthread::equal throughout.
> > 	(pthread_equal): Remove.
> > 	* thread.h (pthread::equal): New static method.
>
> This seems mostly pointless to me.
>
> A few notes:
>
> Why use a static method? you'll always have one pthread to compare to ,
> so using operator == is appropriate. In fact, operator == already does
> the right thing as it is the entire contents of pthread_equal.
>
> So: where pthread_equal is used internally, you could switch to (for
> instance)
> ==
>  if (&thread == joiner)
> ==

The only reason for this patch is to give the compiler the opportunity to
do some inline optimizations. Without it it will always issue a function
call only to test for equality of two pointers.

Thomas
