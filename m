Return-Path: <cygwin-patches-return-2900-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10255 invoked by alias); 31 Aug 2002 02:48:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10241 invoked from network); 31 Aug 2002 02:48:26 -0000
Date: Fri, 30 Aug 2002 19:48:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Readv/writev patch
Message-ID: <20020831024826.GA17051@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01aa01c24dda$cc5384b0$6132bc3e@BABEL> <20020828123735.B10870@cygbert.vinschen.de> <03b801c25097$1debc670$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03b801c25097$1debc670$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00348.txt.bz2

On Sat, Aug 31, 2002 at 03:35:48AM +0100, Conrad Scott wrote:
>"Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
>> Especially I'm reluctant to introduce your changes
>> to the sendto and recvfrom implementation since I know there is
>> a good reason to use the WinSock1 calls in the non-blocking case
>> even though I don't recall why, right now.  Please skip that
>> beautyifing patches and just add the readv/writev functionality.
>
>I went back to the mailing list archives to see if I could dig up the
>problem here and it seems that the code to fallback to the winsock1
>calls in the non-blocking case was introduced as a result of the
>discussion in the thread starting at
>http://cygwin.com/ml/cygwin/2001-08/msg00617.html.  Interestingly, the
>test program that demonstrated the "problem" was itself bogus.  Like,
>you don't set the non-blocking flag w/ the following code:
>
>  printf("Setting NONBLOCK\n");
>  flags = fcntl (sock, F_GETFL, 0);
>  flags &= O_NONBLOCK;

OUCH!

>  ret = fcntl (sock, F_SETFL, flags);

cgf
