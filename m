Return-Path: <cygwin-patches-return-3938-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7473 invoked by alias); 9 Jun 2003 16:36:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7402 invoked from network); 9 Jun 2003 16:36:28 -0000
Date: Mon, 09 Jun 2003 16:36:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: exec after seteuid
Message-ID: <20030609163626.GQ18350@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net> <20030609121132.GJ18350@cygbert.vinschen.de> <3EE48CF9.536E06B5@ieee.org> <20030609145119.GN18350@cygbert.vinschen.de> <3EE4A470.907BE477@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE4A470.907BE477@ieee.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00165.txt.bz2

On Mon, Jun 09, 2003 at 11:14:56AM -0400, Pierre A. Humblet wrote:
> Don't drop the setegid()!!!! seteuid(new user) would see the gid of system 
> (which can be 544 or 18 in old installs), which may not be in the token
> created from login with password. If it's not, a new (passwordless) 
> token will be created. If you run with 544 you won't see that bad behavior.

Btw., if that's true, it's a bug, IMHO.  It undermines the job,
cygwin_set_impersonation_token() is designed for.  If a passwordy
token is given, it should be used if the uid given to seteuid32()
corresponds to the SID in the token.  If the gid is taken into
account too strictly, there's no clean way to switch back and forth
between the privileged and the unprivileged account multiple times
w/o changing the source code of the application each time, the
set(e)?[gu]id is called.  Basically the code would have to be changed
to

	cygwin_set_impersonation_token()
	seteuid(unpriv_uid);
	...
	seteuid(priv_uid);
	...
	cygwin_set_impersonation_token()
	setuid(unpriv_uid);

in all applications doing this.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
