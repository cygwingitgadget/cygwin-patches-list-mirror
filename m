Return-Path: <cygwin-patches-return-3928-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30257 invoked by alias); 9 Jun 2003 12:11:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30226 invoked from network); 9 Jun 2003 12:11:34 -0000
Date: Mon, 09 Jun 2003 12:11:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: exec after seteuid
Message-ID: <20030609121132.GJ18350@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00155.txt.bz2

On Sun, Jun 08, 2003 at 05:32:56PM -0400, Pierre A. Humblet wrote:
> At 10:04 PM 6/7/2003 +0200, Corinna Vinschen wrote:
> >I just had a look into the current login.c implementation on NetBSD.
> >It is using setuid/setgid.  Actually it's using setusercontext(3)
> >but with all options set which implies setuid/setgid.  Yes, using
> >only seteuid/setegid in login has to be considered an error which
> >just didn't matter so far.
> 
> Corinna, 
> 
> here is the patch.
> 
> It seems to work fine but it requires login.exe changes. It's
> not just a question of security. ash does not setuid, while bash 
> setuid(getuid()), i.e. just the opposite of what we need.

I'm wondering why a shell should use setuid at all.  It's not the
task of the shell to do this, it's supposed under the environment
it gets.  So this is entirely the task of the processes which
eventually start a shell (login, rshd, sshd, etc.)

> While I was looking at the most recent login.c I saw that you have
> added a seteuid (priv_uid). Ideally, shouldn't it still be effective 
> while calling dolastlog()? It's weird that the Berkeley code didn't do

I've uploaded a new login which does that.

> that. There is also the issue raised by Takashi Yano on the list.

Which is not related to using the wrong token.  I've written something
on the cygwin ML.

I'm going to have a look into your patch now.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
