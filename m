Return-Path: <cygwin-patches-return-2396-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2709 invoked by alias); 12 Jun 2002 11:20:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2687 invoked from network); 12 Jun 2002 11:20:56 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Thomas Pfaff'" <tpfaff@gmx.net>,
	<cygwin-patches@cygwin.com>
Subject: RE: Pthreads patches
Date: Wed, 12 Jun 2002 04:20:00 -0000
Message-ID: <009201c21203$3e564c00$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <F0E13277A26BD311944600500454CCD056364A-101000@antarctica.intern.net>
X-SW-Source: 2002-q2/txt/msg00379.txt.bz2



> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Thomas Pfaff
> Sent: Wednesday, 12 June 2002 9:17 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: Pthreads patches
> 
> 
> 
> Hi Rob,
> 
> i had a minor problem with your latest code:
> You decided to change the mutex pointer into an object. This 
> will break
> the verifyable_object_isvalid call in pthread::create.

Why? I adjusted that as well I thought. Certainly the built dll seemed
fine to me. Or did I manage to naff it up?

Anyway, your patch seems absent w/o leave :}.

Rob
