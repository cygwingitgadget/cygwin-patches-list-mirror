Return-Path: <cygwin-patches-return-2370-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23616 invoked by alias); 10 Jun 2002 01:05:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23602 invoked from network); 10 Jun 2002 01:05:15 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Thomas Pfaff'" <tpfaff@gmx.net>,
	<cygwin-patches@cygwin.com>
Subject: RE: [PATCH] pthread cleanup_push,_pop fixes
Date: Sun, 09 Jun 2002 18:05:00 -0000
Message-ID: <003f01c2101a$e3ec8d40$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-reply-to: <Pine.WNT.4.44.0204241220040.289-101000@algeria.intern.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00353.txt.bz2

This code should have been members of the pthread class. I'm checking in
such a variant.

Thanks again,
Rob

> -----Original Message-----
> From: Thomas Pfaff [mailto:tpfaff@gmx.net] 
> Sent: Wednesday, 24 April 2002 8:53 PM
> To: cygwin-patches@cygwin.com
> Subject: [PATCH] pthread cleanup_push,_pop fixes
> 
> 
> This patch will fix the cleanup_push/pop implementation. It 
> is required
> that the pushed handlers will run when a thread exits or is 
> cancelled, but
> this did not happen.
> This patch is incremental to my previous patches.
> 
> Greetings,
> Thomas
> 
> 2002-04-24  Thomas Pfaff  <tpfaff@gmx.net>
> 	* include/pthread.h (__pthread_cleanup_handler): New structure
> 	(pthread_cleanup_push): Rewritten.
> 	(pthread_cleanup_pop): Ditto.
> 	(_pthread_cleanup_push): New prototype
> 	(_pthread_cleanup_pop) Ditto.
> 	* pthread.cc: (_pthread_cleanup_push) New function.
> 	(_pthread_cleanup_pop): Ditto.
> 
> 	* thread.h (__pthread_cleanup_push): New prototype
> 	(__pthread_cleanup_pop): Ditto.
> 	(__pthread_cleanup_pop_all): Ditto.
> 	(pthread::cleanup_handlers): New member.
> 	* thread.cc (__pthread_cleanup_push): New function.
> 	(__pthread_cleanup_pop): Ditto.
> 	(__pthread_cleanup_pop_all): Ditto.
> 	(__pthread_exit): Run cleanup handlers on exit.
> 
> 	* cygwin.din: Add _pthread_cleanup_push and 
> _pthread_cleanup_pop.
> 
> 
