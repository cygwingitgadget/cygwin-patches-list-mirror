Return-Path: <cygwin-patches-return-2564-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2011 invoked by alias); 1 Jul 2002 13:46:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1996 invoked from network); 1 Jul 2002 13:46:53 -0000
Date: Mon, 01 Jul 2002 06:46:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] interruptable accept
Message-ID: <20020701154650.J20028@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020701144946.I20028@cygbert.vinschen.de> <Pine.WNT.4.44.0207011513220.375-100000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0207011513220.375-100000@algeria.intern.net>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00012.txt.bz2

On Mon, Jul 01, 2002 at 03:20:51PM +0200, Thomas Pfaff wrote:
> There is another problem with WSAEventSelect. This is winsock2 stuff and
> will not run on Win95 without a WIN95 winsock2 update and cygwin1 must
> link against ws2_32. I do not think that this is what you want.

That's right but that's not a problem since we don't link against
wsock libs, we load the functions on demand.  See autoload.cc.
CancelIo() as used in wsock_event::wait() isn't available on 95, too.
In that case it just falls back to blocking io.

> Any way, here is an untestet version to see how it could be implemented:

Yeah, like this, just moved to fhandler_socket::accept.

One plea, could you please send patches using the diff -up format?

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
