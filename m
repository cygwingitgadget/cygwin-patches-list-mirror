Return-Path: <cygwin-patches-return-2618-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5418 invoked by alias); 8 Jul 2002 12:08:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5397 invoked from network); 8 Jul 2002 12:08:09 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 08 Jul 2002 05:08:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Modified pthread types; From: cygwin-patches@cygwin.com
In-Reply-To: <000601c225b0$a68ceac0$0100a8c0@lony>
Message-ID: <Pine.WNT.4.44.0207081351190.317-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00066.txt.bz2



On Sun, 7 Jul 2002, Christoph wrote:

> > From: Thomas Pfaff
> > To: cygwin-patches.cygwin.com
>
> http://cygwin.com/ml/cygwin-patches/2002-q3/msg00052.html
>
> >
> > I have attached a patch with modified (dummy) pthread typedefs.
> >
> > This should give the compiler a chance to do some type validations,
> > for example:
> >
> > pthread_t t;
> > pthread_create(t,...) //wrong
> > pthread_create(&t,...) // right
> >
> > pthread_cancel(t) //right
> > pthread_cancel(&t)//wrong
>
>
> Using your patch I needed to tweak /usr/include/pthreads.h
> when compiling libstdc++.  Also I don't think that I saw a
> memory leak when running your test program from the
> cygwin-patch mailing list.
>

Just to clarify this a bit more:
gcc-2.95.3-5 is build with enable-threads which defaults to win32. This is
a mingw32 feature that does not work with cygwin and defaults to single
for an app which is build for cygwin. There have been a lot of messages
regarding exception handling in the cygwin ml that it lead to segfaults.

If you run this:

#include <stdio.h>

#include <pthread.h>
static void * TestThread( void * );

extern "C" void *
__get_eh_context ();

int main( void )
{
   for(;;)
   {
      pthread_t t;
      void * result;

      pthread_create(&t, NULL, TestThread, NULL);
      pthread_join(t,  &result);

      printf( "main  : %p\n", __get_eh_context () );
   }

   return 0;
}

static void * TestThread( void * )
{

   try {

      printf( "thread: %p\n", __get_eh_context () );
      pthread_exit(NULL);
   }

   catch( ... )
   {
      printf( "Got exception\n" );
   }

   return NULL;
}

compiled with 2.95.3 and you see the same pointer for the main thread and
the created, than you have a single threaded gcc and exception handling
does not work at all for threaded apps and sure you have no memory leaks.
But this will end in segmentation violations if your main thread will use
exceptions too.

Thomas
