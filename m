Return-Path: <cygwin-patches-return-2491-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11742 invoked by alias); 23 Jun 2002 07:16:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11716 invoked from network); 23 Jun 2002 07:16:06 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Thomas Pfaff'" <tpfaff@gmx.net>,
	<cygwin-patches@cygwin.com>
Subject: RE: Pthreads patches
Date: Sun, 23 Jun 2002 00:58:00 -0000
Message-ID: <000501c21a85$d6d522a0$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <3D0F0777.EA957049@gmx.net>
X-SW-Source: 2002-q2/txt/msg00474.txt.bz2

Thanks Thomas, this is good. I'm checking it in now.

Rob

> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Thomas Pfaff
> Sent: Tuesday, 18 June 2002 8:12 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: Pthreads patches
> 
> 
> I am sorry, but i recognized that my patch was incomplete. The diff
> included only threads.cc.
> I have attached a new one.
> 
> Thomas
> 
> 2002-06-12  Thomas Pfaff  <tpfaff@gmx.net>
> 
> 	* thread.h (pthread::cleanup_stack): Renamed cleanup_handlers to
> 	cleanup_stack.
> 	* thread.cc (pthread::pthread): Ditto.
> 	(pthread::create): Fixed mutex verification.
> 	(pthread::push_cleanup_handler): Renamed cleanup_handlers to
> 	cleanup_stack.
> 	Mutex calls removed, used InterlockedExchangePointer instead.
> 	(pthread::pop_cleanup_handler): Renamed cleanup_handlers to
> 	cleanup_stack.
> 	(pthread::pop_all_cleanup_handlers): Ditto.
> 	(__pthread_once): Check state first and return if already done.
> 	(__pthread_join): DEADLOCK test reverted to __pthread_equal
> 	call.
> 	(__pthread_detach): Unlock mutex before deletion.
> 
> Robert Collins wrote:
> > 
> > I'll review this latest patch in ~20 hours. (i.e. tomorrow night).
> > 
> > Rob
> 
