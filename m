Return-Path: <cygwin-patches-return-2819-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10731 invoked by alias); 12 Aug 2002 12:13:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10716 invoked from network); 12 Aug 2002 12:13:45 -0000
Message-ID: <01e001c241fa$1232be20$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
References: <011c01c2413a$949693c0$6132bc3e@BABEL> <20020812120034.N17250@cygbert.vinschen.de>
Subject: Re: recvfrom / sendto patch
Date: Mon, 12 Aug 2002 05:13:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00267.txt.bz2

"Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
>
> On Sun, Aug 11, 2002 at 02:25:36PM +0100, Conrad Scott wrote:
> >
> > Again, moving slowly towards my readv/writev patch, here's a
> > little patch to simplify the fhandler_socket sendto / recvfrom
> > code.
> >
> > SUSv3 says that recvfrom, recv, and read are all equivalent on
> > sockets if no flags or addresses etc. are provided (and ditto
for
> > sendto, send, and write).  So, this patch makes that true,
partly
> > by removing some methods and making others just delegate to
each
> > other as appropriate.  In detail:
>
> Did you test that?  Is that also true for WinSock?

Sorry, I didn't add all my usual disclaimers.  Here goes:

Yes, tested w/ both connection-orientated and connectionless
sockets (the latter both w/ and w/o the client having called
connect) in both blocking and non-blocking states on win2k (my
win98 box is in bits right now).  I've not tested under winsock1
as I'm unclear how to do so (pointers welcomed).

I've also checked the documentation for both winsock 1 & 2: the
manual pages on MSDN are self-contradictory [sic], but factoring
out the documentation idiocies, they claim to work in an
equivalent way to the SUSv3 interfaces.

I'm using these patches now with my usual test programs +
XEMacs/gnuserv + cvs etc.

HTH,

// Conrad


