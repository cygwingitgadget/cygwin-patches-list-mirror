Return-Path: <cygwin-patches-return-2818-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25429 invoked by alias); 12 Aug 2002 10:00:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25412 invoked from network); 12 Aug 2002 10:00:36 -0000
Date: Mon, 12 Aug 2002 03:00:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: recvfrom / sendto patch
Message-ID: <20020812120034.N17250@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <011c01c2413a$949693c0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011c01c2413a$949693c0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00266.txt.bz2

On Sun, Aug 11, 2002 at 02:25:36PM +0100, Conrad Scott wrote:
> Again, moving slowly towards my readv/writev patch, here's a
> little patch to simplify the fhandler_socket sendto / recvfrom
> code.
> 
> SUSv3 says that recvfrom, recv, and read are all equivalent on
> sockets if no flags or addresses etc. are provided (and ditto for
> sendto, send, and write).  So, this patch makes that true, partly
> by removing some methods and making others just delegate to each
> other as appropriate.  In detail:

Did you test that?  Is that also true for WinSock?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
