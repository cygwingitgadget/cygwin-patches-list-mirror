Return-Path: <cygwin-patches-return-1942-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27163 invoked by alias); 4 Mar 2002 16:48:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27111 invoked from network); 4 Mar 2002 16:48:48 -0000
Date: Mon, 04 Mar 2002 10:15:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use ftruncate64 directly to not lose upper 32 bits
Message-ID: <20020304174846.A17581@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <007401c1c33c$3bc49e80$cf823bd5@dmitry>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007401c1c33c$3bc49e80$cf823bd5@dmitry>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00299.txt.bz2

On Mon, Mar 04, 2002 at 01:10:29PM +0800, Dmitry Timoshkov wrote:
> Hello.
> 
> 2002-03-04  Dmitry Timoshkov  <dmitry@baikal.ru>
> 
> * syscalls.cc (truncate64): Use ftruncate64 directly to not lose upper 32 bits.

Thanks, applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
