Return-Path: <cygwin-patches-return-4457-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14108 invoked by alias); 1 Dec 2003 10:23:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14099 invoked from network); 1 Dec 2003 10:23:35 -0000
Date: Mon, 01 Dec 2003 10:23:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]:  Add flock syscall emulation
Message-ID: <20031201102334.GA27760@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0311271409240.1064139@reddragon.clemson.edu> <20031129230104.GA6964@cygbert.vinschen.de> <3FCA2F9C.4070207@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCA2F9C.4070207@netscape.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00176.txt.bz2

On Sun, Nov 30, 2003 at 12:57:48PM -0500, Nicholas Wourms wrote:
> Corinna wrote:
> >I've run indent on flock.c since its formatting was non-GNU.
> 
> I can understand why you did it in this case (the tabs were out of 
> control), but can we make an exception for bsd/isc-derived code?  I 
> think that enforcing this rule strictly on written-from-scratch source 
> is ok, but doing it on derived source reduces the overall transparency 
> of changes against the upstream version.

I see.  Is that necessary for flock?  It's not BSD derived and will
not likely need another external update.

However, we have a problem here, which I just saw when looking into
the flock code another time.  The newlib defintion of `struct flock'
isn't 64 bit aware and it doesn't adhere to the SUSv3 definition.  :-(
It uses 'long' as datatypes for l_start and l_len but these should
be off_t.

So we need to define flock32 and flock64 structs and change the fcntl
interface to accept both.  Sic.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
