Return-Path: <cygwin-patches-return-2138-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6221 invoked by alias); 2 May 2002 13:37:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6115 invoked from network); 2 May 2002 13:36:56 -0000
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: dtors run twice on dll detach (update)
References: <FC169E059D1A0442A04C40F86D9BA7600C5F90@itdomain003.itdomain.net.au>
From: Benjamin Riefenstahl <Benjamin.Riefenstahl@epost.de>
Date: Thu, 02 May 2002 06:37:00 -0000
In-Reply-To: <FC169E059D1A0442A04C40F86D9BA7600C5F90@itdomain003.itdomain.net.au>
Message-ID: <m33cxan017.fsf@benny-ppc.benny.crocodial.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q2/txt/msg00122.txt.bz2

Hi Robert,


"Robert Collins" <robert.collins@itdomain.com.au> writes:
> > If we just avoid setting up the destructor calls using atexit 
> > then the destructors will only run once.  So, in the normal 
> > case, the destructor will run after much cleanup has occurred 
> > in the cygwin DLL (specifically in the do_exit function).  
> > This means that the destructor may not be able to use all of 
> > the facilities of cygwin when it is finally executed.
> 
> Yup. That is why I don't think that the atexit call is obsolete.
>  
> > This won't be an issue for the problem below, but I wonder if 
> > it is a problem for other destructors.  I'm not sure what 
> > kind of environment a global destructor is guaranteed to have 
> > but I suspect that it should be a completely normal environment.
> > 
> > Anyone know for sure?  Is there an online reference for this 
> > kind of thing?
> 
> It'll be in the C++ standard, which is proprietary :[. Anyone here have
> the standard and care to check for us?

C++ 98 in one spot (3.6.3 Termination, para 3) says that atexit()
functions are called before destructors for objects created before
registration of the atexit() functions and after destruction of
objects created after registration.  IOW the order is as if destructor
calls are implemented as atexit() functions.

Later in the description of exit() (18.3 Start and Termination, para
8) this is repeated.  Actions of exit() are defined to be in this
order:

- atexit() functions and destructor calls.

- Flushing C streams. 

- Return to OS with exit code. 

Except for the addition of destructor calls, this is the same
definition as in the C standard, judging from my copy of the last C9x
draft.


so long, benny
