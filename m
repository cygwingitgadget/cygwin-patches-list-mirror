Return-Path: <cygwin-patches-return-2781-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2513 invoked by alias); 7 Aug 2002 07:54:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2447 invoked from network); 7 Aug 2002 07:54:13 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 07 Aug 2002 00:54:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_socket::accept() and FIONBIO
In-Reply-To: <01de01c23da2$f1ead310$6132bc3e@BABEL>
Message-ID: <Pine.WNT.4.44.0208070945370.276-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00229.txt.bz2



On Wed, 7 Aug 2002, Conrad Scott wrote:

> I've attached a tiny patch to fix the win98 / WSAENOBUFS problem
> reported in
> http://cygwin.com/ml/cygwin-developers/2002-07/msg00167.html
> (amongst other places).
>
> It turns out to be a minor ding in setting the socket back to
> non-blocking in the (blocking) accept call.  Quite why this has
> the effect it does on win98, I'll leave to the morning.  This
> patch fixes the problem and is obviously the right thing to do:
> the details I'm happy to leave 'til later.

Unfortunately it has worked on NT. Don't know why.

Thomas
