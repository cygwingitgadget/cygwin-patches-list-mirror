Return-Path: <cygwin-patches-return-2142-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31254 invoked by alias); 2 May 2002 16:50:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31220 invoked from network); 2 May 2002 16:50:00 -0000
Date: Thu, 02 May 2002 09:50:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: SSH -R problem
Message-ID: <20020502184958.P1214@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020430073223.007e3e00@mail.attbi.com> <20020430142039.D1214@cygbert.vinschen.de> <3CCEA638.E357EFE2@ieee.org> <20020502173110.A15039@cygbert.vinschen.de> <3CD15FBA.8FD5A6B0@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CD15FBA.8FD5A6B0@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00126.txt.bz2

On Thu, May 02, 2002 at 11:48:10AM -0400, Pierre A. Humblet wrote:
> Although what you propose is better than nothing, I would not do
> anything until we really understand what's going on.

Ok with me.

> Win98/ME
> 1) CLOSE_WAIT / WSAENOBUFS
>    Application level fix:  fcntl("close on fork")
>    Cygwin level fix:       Corinna's socket/pid bookkeeping
> 
> 2) ssh -R / persisting listen sockets 
>    Application level fix: make socket blocking before close
>    Cygwin level fix:      make socket blocking before close
> 
> 3) Unexpected ssh exit
>    Application level fix:  fcntl("close on fork")
>    Cygwin level fix: (???) do not duplicate "listen" sockets after 
>                            an accept() has succeeded
> 
> 4) Jonathan Kamens, with extra read() hanging while waiting for EOF
>    Application level fix:  shutdown()
>    Cygwin level fix:       Corinna's socket/pid bookkeeping
> 
> NT
> 1) Jonathan Kamens / linger on close hack
>    Application level fix:  shutdown()
>    Cygwin level fix:       Corinna's socket/pid bookkeeping

Thanks for that summary.  It's very helpful.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
