Return-Path: <cygwin-patches-return-2256-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9866 invoked by alias); 29 May 2002 07:41:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9517 invoked from network); 29 May 2002 07:41:43 -0000
Date: Wed, 29 May 2002 00:41:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: ip.h & tcp.h
Message-ID: <20020529094126.H30892@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <001601c1df6a$0d08ea20$0610a8c0@wyw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001601c1df6a$0d08ea20$0610a8c0@wyw>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00239.txt.bz2

On Tue, Apr 09, 2002 at 09:56:37AM +0800, Wu Yongwei wrote:
> ChangeLog: BSD-style header files ip.h, tcp.h, and udp.h are added, which
> include definitions for IP, TCP, and UDP packet header structures.

Applied with correct ChangeLog entry and a tiny change.  Some
symbols in netinet/ip.h and netinet/tcp.h were already defined
in cygwin/socket.h.  I protected them by #ifndef's.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
