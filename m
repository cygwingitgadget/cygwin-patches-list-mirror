Return-Path: <cygwin-patches-return-2346-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11460 invoked by alias); 6 Jun 2002 14:25:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11445 invoked from network); 6 Jun 2002 14:25:52 -0000
Date: Thu, 06 Jun 2002 07:25:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Name aliasing in security.cc
Message-ID: <20020606162548.E22789@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020603223130.007f6e10@mail.attbi.com> <3.0.5.32.20020530215740.007fc380@mail.attbi.com> <3.0.5.32.20020530215740.007fc380@mail.attbi.com> <3.0.5.32.20020603223130.007f6e10@mail.attbi.com> <3.0.5.32.20020605202359.007fc8a0@mail.attbi.com> <20020606131834.H30892@cygbert.vinschen.de> <3CFF6CB2.66B80261@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CFF6CB2.66B80261@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00329.txt.bz2

On Thu, Jun 06, 2002 at 10:07:46AM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > 
> > On Wed, Jun 05, 2002 at 08:23:59PM -0400, Pierre A. Humblet wrote:
> > > I saw the changes in grp.cc and passwd.cc where you make default
> > > entries from the token. That's a good idea, very close to what I had
> > > in mind for the "except" clause" in suggestion c) above.
> 
> Corinna,
> 
> Something came to my mind last night: the sid that your new code in
> passwd.cc gets from the token should already be in user.sid (and 
> user.orig_sid). Why not get it from there instead?

You're right but it doesn't matter since I have to open the token
anyway since I need the primary group which isn't available at that
point.

> I also have a question: why does internal Cygwin code use 
> strcasematch() instead of !strcasecmp()? I (ignorantly) used
> strcasecmp() recently, it seems to work.

It's faster than strcasecmp.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
