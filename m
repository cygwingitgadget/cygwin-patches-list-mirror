Return-Path: <cygwin-patches-return-2821-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14492 invoked by alias); 12 Aug 2002 13:23:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14478 invoked from network); 12 Aug 2002 13:23:13 -0000
Message-ID: <021e01c24203$c5dd8780$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
References: <011c01c2413a$949693c0$6132bc3e@BABEL> <20020812120034.N17250@cygbert.vinschen.de> <01e001c241fa$1232be20$6132bc3e@BABEL> <20020812145143.Q17250@cygbert.vinschen.de>
Subject: Re: recvfrom / sendto patch
Date: Mon, 12 Aug 2002 06:23:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00269.txt.bz2

"Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
>
> On Mon, Aug 12, 2002 at 01:16:21PM +0100, Conrad Scott wrote:
> >
> > I've not tested under winsock1
> > as I'm unclear how to do so (pointers welcomed).
>
> Don't bother for WinSock 1.

Excellent news!

> > I'm using these patches now with my usual test programs +
> > XEMacs/gnuserv + cvs etc.
>
> It's a nice patch and as long as you're sure that ssh, sshd,
telnet and
> rsh are still working it's ok with me ;-)

Damn . . .  I've tested ssh (via cvs) and telnet too, but not sshd
and rsh.  Perhaps just *being* sure is ok :-)

> So, please go ahead and check it in.

Thanks, I'll do that but I'll also see if I can summon the energy
to get sshd installed here so I can test that too.  I'll want to
do a bit more testing when I get the last bits of the readv/writev
stuff in for sockets (but development here is running at a snail's
pace so it might be a while yet) so it would be good to have more
stuff available to test for that.

Cheers for now,

// Conrad


