Return-Path: <cygwin-patches-return-2377-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19005 invoked by alias); 10 Jun 2002 08:40:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18991 invoked from network); 10 Jun 2002 08:40:46 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Thomas Pfaff'" <tpfaff@gmx.net>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] added locks in pthread code
Date: Mon, 10 Jun 2002 01:40:00 -0000
Message-ID: <006301c2105a$86debac0$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-reply-to: <Pine.WNT.4.44.0206100835080.205-100000@algeria.intern.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00360.txt.bz2



> -----Original Message-----
> From: Thomas Pfaff [mailto:tpfaff@gmx.net] 
> Sent: Monday, 10 June 2002 4:48 PM
> To: Robert Collins
> Cc: cygwin-patches@cygwin.com
> Subject: RE: [PATCH] added locks in pthread code
> 
> 
> 
> I wanted to make sure that a thread can not be cancelled 
> asynchronous when
> it is in the cleanup push call, but i think it could be done 
> better with
> InterlockedExchangePointer.

Yes. Look at the destructor code, or the pthread_atfork list code -
there is a thread safe list based around InterlockedExchangePointer.

Rob
