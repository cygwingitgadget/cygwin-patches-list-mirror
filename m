Return-Path: <cygwin-patches-return-2369-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23227 invoked by alias); 10 Jun 2002 01:03:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23213 invoked from network); 10 Jun 2002 01:03:25 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Thomas Pfaff'" <tpfaff@gmx.net>,
	<cygwin-patches@cygwin.com>
Subject: RE: [PATCH] pthread_join fix
Date: Sun, 09 Jun 2002 18:03:00 -0000
Message-ID: <003e01c2101a$a2a37290$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-reply-to: <F0E13277A26BD311944600500454CCD0513601-101000@antarctica.intern.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00352.txt.bz2

Applied.

Thanks,
Rob

> -----Original Message-----
> From: Thomas Pfaff [mailto:tpfaff@gmx.net] 
> Sent: Wednesday, 24 April 2002 8:18 PM
> To: cygwin-patches@cygwin.com
> Subject: [PATCH] pthread_join fix
> 
> 
> Rob,
> 
> this is an incremental update to my pthread patches. It will 
> fix a problem
> when a thread is joined before the creation completed.
> 
> BTW, i have not added any locks yet (the actual 
> implementation had no),
> but IMHO they are required in the exit,join,cancel code. I 
> will add locks
> if you agree.
> 
> Greetings,
> Thomas
> 
> 2002-04-24  Thomas Pfaff  <tpfaff@gmx.net>
> 
> 	* thread.cc (thread_init_wrapper): Check if thread is alreay
> 	joined
> 	(__pthread_join): Set joiner first.
> 	(__pthread_detach): Ditto.
> 
> 
> 
