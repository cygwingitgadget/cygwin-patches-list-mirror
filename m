Return-Path: <cygwin-patches-return-4247-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10459 invoked by alias); 26 Sep 2003 13:13:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10448 invoked from network); 26 Sep 2003 13:12:59 -0000
Date: Fri, 26 Sep 2003 13:13:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Recent security improvements breaks proftpd
Message-ID: <20030926131258.GM22787@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030925204653.008234f0@incoming.verizon.net> <20030926125328.GB29894@cygbert.vinschen.de> <Pine.GSO.4.56.0309260906240.3193@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0309260906240.3193@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00263.txt.bz2

On Fri, Sep 26, 2003 at 09:08:08AM -0400, Igor Pechtchanski wrote:
> On Fri, 26 Sep 2003, Corinna Vinschen wrote:
> 
> > [snip]
> > > +  char buf [1024];
> >
> > In sec_acl.cc and security.cc, this buffer is named `acl_buf' and it's
> > size is 3072.  Let's do it the same here.  I've seen amazingly big ACLs
> > on NT4 once.
> 
> Corinna,
> 
> Just a quick note: doesn't the above call for a #define'd constant?

wtf PTC

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
