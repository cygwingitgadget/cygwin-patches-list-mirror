Return-Path: <cygwin-patches-return-2899-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4807 invoked by alias); 31 Aug 2002 02:32:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4793 invoked from network); 31 Aug 2002 02:32:58 -0000
Message-ID: <03b801c25097$1debc670$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <01aa01c24dda$cc5384b0$6132bc3e@BABEL> <20020828123735.B10870@cygbert.vinschen.de>
Subject: Re: Readv/writev patch
Date: Fri, 30 Aug 2002 19:32:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00347.txt.bz2

"Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
> Especially I'm reluctant to introduce your changes
> to the sendto and recvfrom implementation since I know there is
> a good reason to use the WinSock1 calls in the non-blocking case
> even though I don't recall why, right now.  Please skip that
> beautyifing patches and just add the readv/writev functionality.

I went back to the mailing list archives to see if I could dig up the
problem here and it seems that the code to fallback to the winsock1
calls in the non-blocking case was introduced as a result of the
discussion in the thread starting at
http://cygwin.com/ml/cygwin/2001-08/msg00617.html.  Interestingly, the
test program that demonstrated the "problem" was itself bogus.  Like,
you don't set the non-blocking flag w/ the following code:

  printf("Setting NONBLOCK\n");
  flags = fcntl (sock, F_GETFL, 0);
  flags &= O_NONBLOCK;
  ret = fcntl (sock, F_SETFL, flags);

Once that minor blot on the landscape is corrected, the sample programs
work fine; i.e. they do perfectly good non-blocking receives on UDP
sockets.

So, I'd guess that the issue about using WSARecvFrom and WSASendTo on
non-blocking sockets is a red herring and unless some other issue can be
found, would it be alright for me to re-submit my readv/writev socket
changes as initially submitted? i.e., with its beauty intact :-)

Cheers,

// Conrad


