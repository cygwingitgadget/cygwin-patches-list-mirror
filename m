Return-Path: <cygwin-patches-return-3942-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27248 invoked by alias); 9 Jun 2003 16:58:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26974 invoked from network); 9 Jun 2003 16:58:44 -0000
Message-ID: <3EE4BD3A.8DAA49F1@ieee.org>
Date: Mon, 09 Jun 2003 16:58:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: exec after seteuid
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net> <20030609121132.GJ18350@cygbert.vinschen.de> <3EE48CF9.536E06B5@ieee.org> <20030609145119.GN18350@cygbert.vinschen.de> <3EE4A470.907BE477@ieee.org> <20030609163626.GQ18350@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00169.txt.bz2

Corinna Vinschen wrote:
> 
> On Mon, Jun 09, 2003 at 11:14:56AM -0400, Pierre A. Humblet wrote:
> > Don't drop the setegid()!!!! seteuid(new user) would see the gid of system
> > (which can be 544 or 18 in old installs), which may not be in the token
> > created from login with password. If it's not, a new (passwordless)
> > token will be created. If you run with 544 you won't see that bad behavior.
> 
> Btw., if that's true, it's a bug, IMHO.  It undermines the job,
> cygwin_set_impersonation_token() is designed for.  If a passwordy
> token is given, it should be used if the uid given to seteuid32()
> corresponds to the SID in the token.  If the gid is taken into
> account too strictly, there's no clean way to switch back and forth
> between the privileged and the unprivileged account multiple times
> w/o changing the source code of the application each time, the
> set(e)?[gu]id is called.  Basically the code would have to be changed
> to

Let's look at the way a pop server works.

First the user logs in with a password. That's Cygwin specific login
code, platform dependent, calling cygwin_set_impersonation_token()
on NT.

Later, in the bowels of the program, you find logic like

if (mail is kept under home dir)
  {
     setgid(user_gid);
     setuid(user_uid);   <= must use token from cygwin_set_impersonation_token()
                            e.g. to access shared drive
  }
else /* mail is kept in system spool dir */
  {
     setgid(mail_gid);   <= gives full access to spool dir
     setuid(user_uid);   <= must discard token from cygwin_set_impersonation_token()
                            and create a new token
  }


It looks like all applications handle setgid/setuid in pairs,
and that's why the current design works.

If we want to handle the gid and uid individually then we would
have to create a token when we change gid (expensive and unnecessary
in all cases I have seen), and we will have to keep more than one
token around (specially those created by cygwin_set_impersonation_token()).
I have considered doing that (it's easy), but it hasn't been necessary so 
far.


Pierre
