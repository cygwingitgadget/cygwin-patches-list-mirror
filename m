Return-Path: <cygwin-patches-return-2561-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31697 invoked by alias); 1 Jul 2002 12:22:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31683 invoked from network); 1 Jul 2002 12:22:41 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 01 Jul 2002 05:22:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] interruptable accept
In-Reply-To: <20020701141003.H20028@cygbert.vinschen.de>
Message-ID: <Pine.WNT.4.44.0207011415490.386-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00009.txt.bz2



On Mon, 1 Jul 2002, Corinna Vinschen wrote:

> On Mon, Jul 01, 2002 at 01:59:56PM +0200, Thomas Pfaff wrote:
> > To be corect:
> > 1. Call WSAEventSelect.
> > 2. WSAWaitForMultipleObjects for socket and signal_arrived.
> > 3. If signal arrived set EINTR, WSAEnumNetworkEvents otherwise.
> > 4. do accept, then switch sockets back to nonblocking
> >
> > I will generate a new patch tonight, then you can decide which one to use.
> > The select one was easier one to implement because you don't have to
> > deal with nonblocking I/O and multiple events.
>
> If that helps, look into net.cc, wsock_event::wait().  It's doing
> something similar for send/recv.

I have already checked, but this for overlapped I/O and can't be used
with accept. In a first step i will put all that stuff into the accept
call, then you can decide whether it make sense to create new methods.

Thomas
