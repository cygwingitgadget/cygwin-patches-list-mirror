Return-Path: <cygwin-patches-return-3946-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27420 invoked by alias); 9 Jun 2003 18:18:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27384 invoked from network); 9 Jun 2003 18:18:30 -0000
Date: Mon, 09 Jun 2003 18:18:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: exec after seteuid
Message-ID: <20030609181828.GT18350@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net> <20030609121132.GJ18350@cygbert.vinschen.de> <3EE48CF9.536E06B5@ieee.org> <20030609145119.GN18350@cygbert.vinschen.de> <3EE4A470.907BE477@ieee.org> <20030609162404.GP18350@cygbert.vinschen.de> <3EE4B921.44DAAC3D@ieee.org> <20030609165024.GS18350@cygbert.vinschen.de> <3EE4C0B4.67711871@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE4C0B4.67711871@ieee.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00173.txt.bz2

On Mon, Jun 09, 2003 at 01:15:32PM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > 
> > On Mon, Jun 09, 2003 at 12:43:13PM -0400, Pierre A. Humblet wrote:
> > > Corinna Vinschen wrote:
> > > > it changes the impersonated access token if priv_gid is in the group
> > > > list of the new users token.
> > >
> > > Nope. The token is only changed by set(e)uid(), never by set(e)gid().
> > > Set(e)gid only changes the default group in the token, not the token
> > > itself (that's your design, or perhaps even older, and it's just fine).
> > 
> > There's SetTokenInformation(TokenPrimaryGroup) called in setegid32.
> 
> Yes, but it's a misleading name. It only affects the (default) group of
> files created by Windows programs launched by Cygwin.
> Also, starting with Win2000, such a call will fail in the case when the
> group given as argument is not in the token groups.

I must admit that I can't reproduce the situation.  A few hours ago I
had the case that the final setuid created a new passwordless token,
using your login code!  Now that I'm testing again, it doesn't occur.
I hate when something like this happens :-(

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
