Return-Path: <cygwin-patches-return-4196-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26029 invoked by alias); 10 Sep 2003 15:43:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26019 invoked from network); 10 Sep 2003 15:43:40 -0000
Date: Wed, 10 Sep 2003 15:43:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Part 2 of Fixing a security hole in mount table.
Message-ID: <20030910154339.GG9981@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030909235426.008236c0@incoming.verizon.net> <20030910075433.GB5268@cygbert.vinschen.de> <3F5F28C5.F99C5B92@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5F28C5.F99C5B92@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00212.txt.bz2

On Wed, Sep 10, 2003 at 09:36:05AM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > 
> > Looks good to me, except for:
> > 
> > > -  char name[UNLEN + 1] = "";
> > > +  char name[UNLEN > 127 ? UNLEN + 1 : 128] = "";
> > 
> > Huh?  Why that?  UNLEN is defined as 256 in lmcons.h so I don't understand
> > the reasoning behind that complexity.
> > 
> Just being paranoid. "name" can either contain a user name
> (length UNLEN + 1) or a sid (length 128). 
> This construction costs nothing (the compiler does the work),
> saves me from having to look up the .h file, and protects us
> against possible header file changes.

Please don't do this.  It's just obfuscating the code.  Except for this
one, the code should be ok to check in.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
