Return-Path: <cygwin-patches-return-3933-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22304 invoked by alias); 9 Jun 2003 15:13:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22264 invoked from network); 9 Jun 2003 15:12:59 -0000
Message-ID: <3EE4A470.907BE477@ieee.org>
Date: Mon, 09 Jun 2003 15:13:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: exec after seteuid
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net> <20030609121132.GJ18350@cygbert.vinschen.de> <3EE48CF9.536E06B5@ieee.org> <20030609145119.GN18350@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00160.txt.bz2

Corinna Vinschen wrote:

> > Are you running with gid 544 by any chance?
> 
> Argh, yes.
> 
> > What I saw in login.exe while stracing my patch was
> > setegid(513)
> > seteuid(new user) <= uses token from login with password
> > seteuid(18)       <= creates a new token, discards token from login
> > seteuid(new user) <= creates new token.
> > If the first setegid was a 544, the seteuid(18) would reuse the process
> > token and the final seteuid() would use the token from the login with
> > passwd.
> 
> Oh boy :-(  So I have to upload another version of login which drops the
> call to setegid() entirely.  Switching back to uid 18 the just reverts
> to self and the last call to setgid/setuid uses the logon token.

Don't drop the setegid()!!!! seteuid(new user) would see the gid of system 
(which can be 544 or 18 in old installs), which may not be in the token
created from login with password. If it's not, a new (passwordless) 
token will be created. If you run with 544 you won't see that bad behavior.

The right way is to save the system gid (as you save the system uid), and then

1) setegid(user_gid), seteuid(user_gid).
Do the chdir

Later to do the utmp piece, 
2) setegid(saved_gid), setegid(saved_uid)   (this goes back to the process token)

Finally,
3)setgid(user_gid), setuid(user_uid).

Any initgroups() should/could go between 2 and 3.
Pierre
