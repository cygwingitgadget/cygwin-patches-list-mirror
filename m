Return-Path: <cygwin-patches-return-4070-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15935 invoked by alias); 12 Aug 2003 10:24:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15926 invoked from network); 12 Aug 2003 10:24:51 -0000
Date: Tue, 12 Aug 2003 10:24:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Add some interoperability macros to sys/param.h
Message-ID: <20030812102450.GA3101@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3F32A747.4070106@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F32A747.4070106@netscape.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00086.txt.bz2

On Thu, Aug 07, 2003 at 03:23:51PM -0400, Nicholas Wourms wrote:
> 2003-08-07  Nicholas Wourms  <nwourms@netscape.net>
> 
>     * include/sys/param.h (setbit): Add new bitmap related macro.
>     (clrbit): Likewise.
>     (isset): Likewise.
>     (isclr): Likewise.
>     (howmany): Add new counting/rounding macro.
>     (rounddown): Likewise.
>     (roundup): Likewise.
>     (roundup2): Likewise.
>     (powerof2): Likewise
>     (MIN): Add macro for calculating min.
>     (MAX): Add macro for calculating max.

Applied.  I've just added a NBBY definition.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
