Return-Path: <cygwin-patches-return-2398-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5498 invoked by alias); 12 Jun 2002 11:29:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5423 invoked from network); 12 Jun 2002 11:29:42 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 12 Jun 2002 04:29:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <robert.collins@syncretize.net>
cc: cygwin-patches@cygwin.com
Subject: RE: Pthreads patches
In-Reply-To: <009301c21203$6c9aee90$0200a8c0@lifelesswks>
Message-ID: <Pine.WNT.4.44.0206121324510.350-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q2/txt/msg00381.txt.bz2



On Wed, 12 Jun 2002, Robert Collins wrote:

>
>
> > -----Original Message-----
> > From: cygwin-patches-owner@cygwin.com
> > [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Thomas Pfaff
> > Sent: Wednesday, 12 June 2002 9:17 PM
> > To: cygwin-patches@cygwin.com
> > Subject: Re: Pthreads patches
> >
> >
> >
> > Hi Rob,
> >
> > i had a minor problem with your latest code:
> > You decided to change the mutex pointer into an object. This
> > will break
> > the verifyable_object_isvalid call in pthread::create.
>
> I thought I might explain why. The usual benefit of an object pointer in
> C++ is for optional objects, or for polymorphic objects. Neither applied
> in this case, so a composed object is a lower overhead option.
>
> Rob
>

I can understand your reasons very well.
Please have a look at the patch und you will see what went wrong.

Thomas
