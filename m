Return-Path: <cygwin-patches-return-2785-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7337 invoked by alias); 7 Aug 2002 10:10:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7321 invoked from network); 7 Aug 2002 10:10:15 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 07 Aug 2002 03:10:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_socket::accept() and FIONBIO
In-Reply-To: <006801c23df9$3d047ad0$6132bc3e@BABEL>
Message-ID: <Pine.WNT.4.44.0208071159530.299-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00233.txt.bz2



On Wed, 7 Aug 2002, Conrad Scott wrote:

> "Thomas Pfaff" <tpfaff@gmx.net> wrote:
> >
> > On Wed, 7 Aug 2002, Conrad Scott wrote:
> >
> > > I've attached a tiny patch to fix the win98 / WSAENOBUFS
> problem
> > > reported in
> > > http://cygwin.com/ml/cygwin-developers/2002-07/msg00167.html
> > > (amongst other places).
> > >
> > > It turns out to be a minor ding in setting the socket back to
> > > non-blocking in the (blocking) accept call.  Quite why this
> has
> > > the effect it does on win98, I'll leave to the morning.  This
> > > patch fixes the problem and is obviously the right thing to
> do:
> > > the details I'm happy to leave 'til later.
> >
> > Unfortunately it has worked on NT. Don't know why.
>
> Yes, and if I've got the energy today, I might try and understand
> what was going wrong on win98.  AFAICT the socket was being left
> non-blocking but since the fhandler thought it was blocking, this
> wasn't generally visible.  Perhaps *0 on NT systems is != 0 but on
> 9x systems it's == 0.
>
> London's promised rain every day until the end of the weekend at
> the earliest so I might yet have the opportunity to look more at
> this :-(

Do not waste your time. You did the right thing and i was wrong.
According to
http://msdn.microsoft.com/library/default.asp?url=/library/en-us/winsock/ovrspi3_6whe.asp
you must pass an unsigned long pointer to ioctlsocket for the FIONBIO
opcode.

Thomas

