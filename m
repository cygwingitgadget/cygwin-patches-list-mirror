Return-Path: <cygwin-patches-return-3930-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4766 invoked by alias); 9 Jun 2003 13:33:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4755 invoked from network); 9 Jun 2003 13:33:15 -0000
Message-ID: <3EE48CF9.536E06B5@ieee.org>
Date: Mon, 09 Jun 2003 13:33:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: exec after seteuid
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net> <20030609121132.GJ18350@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00157.txt.bz2

Corinna Vinschen wrote:
> 
> > It seems to work fine but it requires login.exe changes. It's
> > not just a question of security. ash does not setuid, while bash
> > setuid(getuid()), i.e. just the opposite of what we need.
> 
> I'm wondering why a shell should use setuid at all.  It's not the
> task of the shell to do this, it's supposed under the environment
> it gets.  So this is entirely the task of the processes which
> eventually start a shell (login, rshd, sshd, etc.)

I agree 100%. If you look in bash code there is some explanation,
involving a "privileged mode" (undocumented?). I don't recall the 
details.

> > While I was looking at the most recent login.c I saw that you have
> > added a seteuid (priv_uid). Ideally, shouldn't it still be effective
> > while calling dolastlog()? It's weird that the Berkeley code didn't do
> 
> I've uploaded a new login which does that.

OK, will try later.
 
> > that. There is also the issue raised by Takashi Yano on the list.
> 
> Which is not related to using the wrong token.  I've written something
> on the cygwin ML.

Are you running with gid 544 by any chance?
What I saw in login.exe while stracing my patch was
setegid(513)
seteuid(new user) <= uses token from login with password
seteuid(18)       <= creates a new token, discards token from login
seteuid(new user) <= creates new token.
If the first setegid was a 544, the seteuid(18) would reuse the process
token and the final seteuid() would use the token from the login with 
passwd.

Something else:
Around 4:00 GMT there were exim related messages about setuid not working.
It was on a Windows 2003 Enterprise. Is that the same as a Windows Server
2003? We have had reports of problems with that one.
Please have a look, for the moment I can't spend any time on these matters.

Pierre
