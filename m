Return-Path: <cygwin-patches-return-1802-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25099 invoked by alias); 28 Jan 2002 17:43:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25083 invoked from network); 28 Jan 2002 17:43:05 -0000
Date: Mon, 28 Jan 2002 09:43:00 -0000
From: Matt <matt@use.net>
X-Sender:  <matt@cesium.clock.org>
To: <cygwin-patches@cygwin.com>
Subject: Re: include/sys/strace.h
In-Reply-To: <20020128170312.GB3669@redhat.com>
Message-ID: <Pine.NEB.4.30.0201280938420.5761-100000@cesium.clock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q1/txt/msg00159.txt.bz2

On Mon, 28 Jan 2002, Christopher Faylor wrote:

> On Sun, Jan 27, 2002 at 11:03:12PM +1100, Robert Collins wrote:
> >Chris, I'd actually kinda like to see this included, I can see it being
> >handy from time to time.
>
> I don't agree.  It seems to me that this is easy enough to do with gdb.
> I don't see any reason for it.

The use case I see is when gdb hangs/crashes or the entire cygwin DLL
hangs/crashes. In those instances, having a non-cygwin program that can
monitor debug output would be highly useful.

dbgview has come in handy several times for me in scenarios like this with
other development environments on win32. For the times in cygwin when
using gdb caused the cygwin DLL to hang on win9x, it would've been very
useful.

Just my 2 drachmas.


--
http://www.clock.org/~matt
