Return-Path: <cygwin-patches-return-2560-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29973 invoked by alias); 1 Jul 2002 12:10:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29959 invoked from network); 1 Jul 2002 12:10:05 -0000
Date: Mon, 01 Jul 2002 05:10:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] interruptable accept
Message-ID: <20020701141003.H20028@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020701133556.G20028@cygbert.vinschen.de> <Pine.WNT.4.44.0207011343160.364-100000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0207011343160.364-100000@algeria.intern.net>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00008.txt.bz2

On Mon, Jul 01, 2002 at 01:59:56PM +0200, Thomas Pfaff wrote:
> To be corect:
> 1. Call WSAEventSelect.
> 2. WSAWaitForMultipleObjects for socket and signal_arrived.
> 3. If signal arrived set EINTR, WSAEnumNetworkEvents otherwise.
> 4. do accept, then switch sockets back to nonblocking
> 
> I will generate a new patch tonight, then you can decide which one to use.
> The select one was easier one to implement because you don't have to
> deal with nonblocking I/O and multiple events.

If that helps, look into net.cc, wsock_event::wait().  It's doing
something similar for send/recv.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
