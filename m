Return-Path: <cygwin-patches-return-3941-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5028 invoked by alias); 9 Jun 2003 16:50:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4952 invoked from network); 9 Jun 2003 16:50:25 -0000
Date: Mon, 09 Jun 2003 16:50:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: exec after seteuid
Message-ID: <20030609165024.GS18350@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net> <20030609121132.GJ18350@cygbert.vinschen.de> <3EE48CF9.536E06B5@ieee.org> <20030609145119.GN18350@cygbert.vinschen.de> <3EE4A470.907BE477@ieee.org> <20030609162404.GP18350@cygbert.vinschen.de> <3EE4B921.44DAAC3D@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE4B921.44DAAC3D@ieee.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00168.txt.bz2

On Mon, Jun 09, 2003 at 12:43:13PM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > it changes the impersonated access token if priv_gid is in the group
> > list of the new users token. 
> 
> Nope. The token is only changed by set(e)uid(), never by set(e)gid().
> Set(e)gid only changes the default group in the token, not the token 
> itself (that's your design, or perhaps even older, and it's just fine).

There's SetTokenInformation(TokenPrimaryGroup) called in setegid32.

> But the intermediate switch back to 18 will then create a new token and
> discard the token given by cygwin_set_impersonation_token.

Why should it?  If the group hasn't changed before, the seteuid(priv_uid)
reverts to the original uid/gid combination.  That's exactly the case
which should result in calling RevertToSelf() and nothing else.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
