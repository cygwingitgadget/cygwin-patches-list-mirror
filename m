Return-Path: <cygwin-patches-return-3931-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28159 invoked by alias); 9 Jun 2003 14:51:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28130 invoked from network); 9 Jun 2003 14:51:21 -0000
Date: Mon, 09 Jun 2003 14:51:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: exec after seteuid
Message-ID: <20030609145119.GN18350@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net> <20030609121132.GJ18350@cygbert.vinschen.de> <3EE48CF9.536E06B5@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE48CF9.536E06B5@ieee.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00158.txt.bz2

On Mon, Jun 09, 2003 at 09:34:49AM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > I'm wondering why a shell should use setuid at all.  It's not the
> > task of the shell to do this, it's supposed under the environment
> > it gets.  So this is entirely the task of the processes which
> > eventually start a shell (login, rshd, sshd, etc.)
> 
> I agree 100%. If you look in bash code there is some explanation,
> involving a "privileged mode" (undocumented?). I don't recall the 
> details.

I had a look into tcsh and it turns out that it refuses to run in
interactive mode if euid != ruid.  It doesn't call any setuid(), it
just prints a message to stderr and exits.  No comment in the code
though.

> > Which is not related to using the wrong token.  I've written something
> > on the cygwin ML.
> 
> Are you running with gid 544 by any chance?

Argh, yes.

> What I saw in login.exe while stracing my patch was
> setegid(513)
> seteuid(new user) <= uses token from login with password
> seteuid(18)       <= creates a new token, discards token from login
> seteuid(new user) <= creates new token.
> If the first setegid was a 544, the seteuid(18) would reuse the process
> token and the final seteuid() would use the token from the login with 
> passwd.

Oh boy :-(  So I have to upload another version of login which drops the
call to setegid() entirely.  Switching back to uid 18 the just reverts
to self and the last call to setgid/setuid uses the logon token.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
