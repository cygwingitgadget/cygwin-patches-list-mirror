Return-Path: <cygwin-patches-return-2565-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4259 invoked by alias); 1 Jul 2002 13:51:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4239 invoked from network); 1 Jul 2002 13:51:42 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 01 Jul 2002 06:51:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] interruptable accept
In-Reply-To: <20020701154650.J20028@cygbert.vinschen.de>
Message-ID: <Pine.WNT.4.44.0207011548150.284-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00013.txt.bz2



On Mon, 1 Jul 2002, Corinna Vinschen wrote:

> On Mon, Jul 01, 2002 at 03:20:51PM +0200, Thomas Pfaff wrote:
> > There is another problem with WSAEventSelect. This is winsock2 stuff and
> > will not run on Win95 without a WIN95 winsock2 update and cygwin1 must
> > link against ws2_32. I do not think that this is what you want.
>
> That's right but that's not a problem since we don't link against
> wsock libs, we load the functions on demand.  See autoload.cc.
> CancelIo() as used in wsock_event::wait() isn't available on 95, too.
> In that case it just falls back to blocking io.
>
> > Any way, here is an untestet version to see how it could be implemented:
>
> Yeah, like this, just moved to fhandler_socket::accept.
>
> One plea, could you please send patches using the diff -up format?
>

This wasn't a patch, just a preview. I have not tested it yet. And i can
not update my CVS source before evening. Sorry.

Thomas
