Return-Path: <cygwin-patches-return-2378-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22078 invoked by alias); 10 Jun 2002 08:46:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22062 invoked from network); 10 Jun 2002 08:46:25 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Robert Collins'" <robert.collins@syncretize.net>,
	"'Thomas Pfaff'" <tpfaff@gmx.net>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] added locks in pthread code
Date: Mon, 10 Jun 2002 01:46:00 -0000
Message-ID: <006a01c2105b$510ab600$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-reply-to: <006301c2105a$86debac0$0200a8c0@lifelesswks>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00361.txt.bz2



> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Robert Collins
> Sent: Monday, 10 June 2002 6:41 PM
> To: 'Thomas Pfaff'
> Cc: cygwin-patches@cygwin.com
> Subject: RE: [PATCH] added locks in pthread code
> 
> 
> 
> 
> > -----Original Message-----
> > From: Thomas Pfaff [mailto:tpfaff@gmx.net] 
> > Sent: Monday, 10 June 2002 4:48 PM
> > To: Robert Collins
> > Cc: cygwin-patches@cygwin.com
> > Subject: RE: [PATCH] added locks in pthread code
> > 
> > 
> > 
> > I wanted to make sure that a thread can not be cancelled 
> > asynchronous when
> > it is in the cleanup push call, but i think it could be done 
> > better with
> > InterlockedExchangePointer.
> 
> Yes. Look at the destructor code, or the pthread_atfork list code -
> there is a thread safe list based around InterlockedExchangePointer.

Or, call setcancelstate twice during your pthread_cleanup_push macro.
Once to set PTHREAD_CANCEL_ENABLE, and once to restore the old value.
That avoids the issue completely, and is in spec with P1003.1.

Rob
