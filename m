Return-Path: <cygwin-patches-return-4465-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29704 invoked by alias); 1 Dec 2003 18:34:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29695 invoked from network); 1 Dec 2003 18:34:32 -0000
Date: Mon, 01 Dec 2003 18:34:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] localtime.cc: Point TZDIR to the /usr/share/zoneinfo
Message-ID: <20031201183430.GA32563@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <87ad6cgb3m.fsf@vzell-de.de.oracle.com> <20031201102807.GB27760@cygbert.vinschen.de> <Pine.GSO.4.56.0312010820520.26435@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0312010820520.26435@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00184.txt.bz2

On Mon, Dec 01, 2003 at 11:50:39AM -0500, Igor Pechtchanski wrote:
> On Mon, 1 Dec 2003, Corinna Vinschen wrote:
> > Should we do some extra stuff to maintain backward compatibility with
> > the old /usr/local/etc path?  I don't think so but...
> >
> > Corinna
> 
> That's pretty much what I suggested in
> <http://cygwin.com/ml/cygwin-apps/2003-11/msg00443.html>.  Right now, the
> code is not $TZDIR-aware, AFAICS.  IMO, having it first check the TZDIR
> environment variable, and if that's not set, default to the #defined value
> of TZDIR would be the right solution.  Something like (very raw)

Interested to change this to a real patch with ChangeLog and all that?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
