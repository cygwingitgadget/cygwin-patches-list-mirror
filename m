Return-Path: <cygwin-patches-return-2910-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6364 invoked by alias); 2 Sep 2002 10:48:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6349 invoked from network); 2 Sep 2002 10:48:46 -0000
Date: Mon, 02 Sep 2002 03:48:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Readv/writev patch
Message-ID: <20020902124814.I12899@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01aa01c24dda$cc5384b0$6132bc3e@BABEL> <20020828123735.B10870@cygbert.vinschen.de> <03b801c25097$1debc670$6132bc3e@BABEL> <20020831024826.GA17051@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020831024826.GA17051@redhat.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00358.txt.bz2

On Fri, Aug 30, 2002 at 10:48:26PM -0400, Chris Faylor wrote:
> On Sat, Aug 31, 2002 at 03:35:48AM +0100, Conrad Scott wrote:
> >"Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
> >> Especially I'm reluctant to introduce your changes
> >> to the sendto and recvfrom implementation since I know there is
> >> a good reason to use the WinSock1 calls in the non-blocking case
> >> even though I don't recall why, right now.  Please skip that
> >> beautyifing patches and just add the readv/writev functionality.
> >
> >I went back to the mailing list archives to see if I could dig up the
> >problem here and it seems that the code to fallback to the winsock1
> >calls in the non-blocking case was introduced as a result of the
> >discussion in the thread starting at
> >http://cygwin.com/ml/cygwin/2001-08/msg00617.html.  Interestingly, the
> >test program that demonstrated the "problem" was itself bogus.  Like,
> >you don't set the non-blocking flag w/ the following code:
> >
> >  printf("Setting NONBLOCK\n");
> >  flags = fcntl (sock, F_GETFL, 0);
> >  flags &= O_NONBLOCK;
> 
> OUCH!

It wasn't quite that but actually the whole thread seem to be based
on a handful of misinterpretations.

Ok Conrad, send your patch right away.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
