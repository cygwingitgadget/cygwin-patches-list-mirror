Return-Path: <cygwin-patches-return-2820-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1037 invoked by alias); 12 Aug 2002 12:51:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1023 invoked from network); 12 Aug 2002 12:51:45 -0000
Date: Mon, 12 Aug 2002 05:51:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: recvfrom / sendto patch
Message-ID: <20020812145143.Q17250@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <011c01c2413a$949693c0$6132bc3e@BABEL> <20020812120034.N17250@cygbert.vinschen.de> <01e001c241fa$1232be20$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e001c241fa$1232be20$6132bc3e@BABEL>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00268.txt.bz2

On Mon, Aug 12, 2002 at 01:16:21PM +0100, Conrad Scott wrote:
> "Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
>   I've not tested under winsock1
> as I'm unclear how to do so (pointers welcomed).

Don't bother for WinSock 1.

> I've also checked the documentation for both winsock 1 & 2: the
> manual pages on MSDN are self-contradictory [sic], but factoring
> out the documentation idiocies, they claim to work in an
> equivalent way to the SUSv3 interfaces.
> 
> I'm using these patches now with my usual test programs +
> XEMacs/gnuserv + cvs etc.

It's a nice patch and as long as you're sure that ssh, sshd, telnet and
rsh are still working it's ok with me ;-)

So, please go ahead and check it in.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
