Return-Path: <cygwin-patches-return-2559-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28640 invoked by alias); 1 Jul 2002 12:00:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28623 invoked from network); 1 Jul 2002 12:00:11 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 01 Jul 2002 05:00:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] interruptable accept
In-Reply-To: <20020701133556.G20028@cygbert.vinschen.de>
Message-ID: <Pine.WNT.4.44.0207011343160.364-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00007.txt.bz2



On Mon, 1 Jul 2002, Corinna Vinschen wrote:

> On Mon, Jul 01, 2002 at 01:12:24PM +0200, Thomas Pfaff wrote:
> >
> > This patch is not 100% perfect and could be done better (faster response
> > on incoming signal) with async Events but this would require a much larger
> > patch (Call AsyncEventSelect, WaitForMultipleObjects (socket and signal),
> > check for pending connection and set socket back to blocking mode).
>
> Do you mean WSAEventSelect?  Would that be actually that big a patch?
> I'm not quite sure if a busy loop is a better solution.

To be corect:
1. Call WSAEventSelect.
2. WSAWaitForMultipleObjects for socket and signal_arrived.
3. If signal arrived set EINTR, WSAEnumNetworkEvents otherwise.
4. do accept, then switch sockets back to nonblocking

I will generate a new patch tonight, then you can decide which one to use.
The select one was easier one to implement because you don't have to
deal with nonblocking I/O and multiple events.

>
> > 2002-07-01 Thomas Pfaff <tpfaff@gmx.net>
		throw runtime_error( EXCPTN_S( FormatSockErr(
"WSAEventSelect", NULL ) ) );> >
	}> > *net.cc: Include select.h
> > 	(cygwin_accept): If socket is nonblocking check for a pending
> > 	signal every 100ms.
>
> Ahem, did you have a look into the current CVS sources?  Your patch
> isn't against the latest from CVS.  I've moved most of the socket
> funtionality into the fhandler_socket class the week before.
>

Seems that i am a little out of date ...

Thomas
