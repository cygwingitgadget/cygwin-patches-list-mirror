Return-Path: <cygwin-patches-return-2562-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16156 invoked by alias); 1 Jul 2002 12:49:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16137 invoked from network); 1 Jul 2002 12:49:51 -0000
Date: Mon, 01 Jul 2002 05:49:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] interruptable accept
Message-ID: <20020701144946.I20028@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020701141003.H20028@cygbert.vinschen.de> <Pine.WNT.4.44.0207011415490.386-100000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0207011415490.386-100000@algeria.intern.net>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00010.txt.bz2

On Mon, Jul 01, 2002 at 02:22:36PM +0200, Thomas Pfaff wrote:
> On Mon, 1 Jul 2002, Corinna Vinschen wrote:
> > If that helps, look into net.cc, wsock_event::wait().  It's doing
> > something similar for send/recv.
> 
> I have already checked, but this for overlapped I/O and can't be used
> with accept. In a first step i will put all that stuff into the accept
> call, then you can decide whether it make sense to create new methods.

Sorry if I didn't make this clear enough.  The hint to wsock_event::wait()
was just to point to an example using multiple events, not to push you
into the direction of using overlapped IO which obviously don't work
with accept().

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
