Return-Path: <cygwin-patches-return-3936-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4730 invoked by alias); 9 Jun 2003 16:24:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4667 invoked from network); 9 Jun 2003 16:24:06 -0000
Date: Mon, 09 Jun 2003 16:24:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: exec after seteuid
Message-ID: <20030609162404.GP18350@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net> <20030609121132.GJ18350@cygbert.vinschen.de> <3EE48CF9.536E06B5@ieee.org> <20030609145119.GN18350@cygbert.vinschen.de> <3EE4A470.907BE477@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE4A470.907BE477@ieee.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00163.txt.bz2

On Mon, Jun 09, 2003 at 11:14:56AM -0400, Pierre A. Humblet wrote:
> The right way is to save the system gid (as you save the system uid), and then
> 
> 1) setegid(user_gid), seteuid(user_gid).
> Do the chdir
> 
> Later to do the utmp piece, 
> 2) setegid(saved_gid), setegid(saved_uid)   (this goes back to the process token)
> 
> Finally,
> 3)setgid(user_gid), setuid(user_uid).

It doesn't work that way.  When calling

  setegid(priv_gid);

it changes the impersonated access token if priv_gid is in the group
list of the new users token.  That way, the final setuid again creates
a new passwordless token.

But keeping the gid completly untouched should work.  Changing the euid
to the new user uses the token given by cygwin_set_impersonation_token.
Switching back to priv_uid again left the gid untouched so it just
reverts to self.

> Any initgroups() should/could go between 2 and 3.

initgroups() is totally useless in login() since it's whole purpose is
to use a token created by the system.  initgroups will have no effect
on that token.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
