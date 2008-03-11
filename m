Return-Path: <cygwin-patches-return-6283-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2516 invoked by alias); 11 Mar 2008 12:37:23 -0000
Received: (qmail 2503 invoked by uid 22791); 11 Mar 2008 12:37:23 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 11 Mar 2008 12:36:57 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 0162D6D430A; Tue, 11 Mar 2008 13:36:53 +0100 (CET)
Date: Tue, 11 Mar 2008 12:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080311123653.GD18407@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20080309092806.GW18407@calimero.vinschen.de> <20080309143819.GB8192@ednor.casa.cgf.cx> <20080309151440.GB18407@calimero.vinschen.de> <20080309162800.GB13754@ednor.casa.cgf.cx> <47D4266A.CE301EDE@dessent.net> <20080309195509.GD18407@calimero.vinschen.de> <20080309232000.GC14815@ednor.casa.cgf.cx> <20080310103444.GF18407@calimero.vinschen.de> <20080310190840.GB16745@ednor.casa.cgf.cx> <20080310201053.GA11785@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080310201053.GA11785@calimero.vinschen.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00057.txt.bz2

On Mar 10 21:10, Corinna Vinschen wrote:
> On Mar 10 15:08, Christopher Faylor wrote:
> > However, I don't understand what a mingw app would see when it is started
> > from Cygwin now.  What would a standard windows app think that its cwd would
> > be if it's cd'ed deep into a 32K long path.
> 
> Right now, Cygwin copies its CWD into the user parameter block, as long
> as it is < 260 chars.  When a Cygwin process cd's into a long path, this
> copy just doesn't happen.  So, the cwd of a MingW application started
> from that Cygwin process would be the last Cygwin cwd path < 260
> characters within this process tree.
> 
> This is what I started to discuss in
> http://cygwin.com/ml/cygwin-developers/2007-10/msg00008.html
> 
> As a result of this discussion we had five options what to do when
> spawning a native app from Cygwin, if the Cygwin process is in a long
> cwd:
> 
> 1. Return ENAMETOOLONG and don't start the native child.
> 
> 2. CWD for the native child is set to $SYSTEMROOT.
> 
> 3. CWD is set to the root of the current drive (either X:\ or
>    \\server\share).
> 
> 4. CWD is set to the longest leading path component of CWD which still
>    fits into MAX_PATH.
> 
> 5. Start the native app in the last CWD we were in which was < MAX_PATH.
> 
> Implemented right now is option 5 since that's the most easy to implement
> because it practically didn't need any changes to the existing code.
> 
> The general consensus seemed to lean towards option 1 or 3, so maybe
> this whole problem is going to be a non-issue...?
> 
> Sigh, somehow it would be a pity if our own tools suffer from that
> restriction.

I applied a patch which enables option 1 for all long and virtual
paths.  So, for now, we don't have to take paths > MAX_PATH into
account for any MingW utility.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
