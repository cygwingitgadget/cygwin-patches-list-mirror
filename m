Return-Path: <cygwin-patches-return-2159-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3037 invoked by alias); 7 May 2002 13:20:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3002 invoked from network); 7 May 2002 13:20:35 -0000
Date: Tue, 07 May 2002 06:20:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: automatic TZ in non-english windows
Message-ID: <20020507152034.A26255@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020506120908.I9238@cygbert.vinschen.de> <000201c1f52f$18bb9860$010115ac@NEXUS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201c1f52f$18bb9860$010115ac@NEXUS>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00143.txt.bz2

On Mon, May 06, 2002 at 02:51:55PM -0400, Norbert Schulze wrote:
> > What I'd like to see is just a bit more of an
> > explanation why the patch is needed.  Especially two points,
> > where in the common standards did you find that a timezone
> > string must be three chars to be valid and could you give
> > an example what else is stored at that point in non-english
> > OSes?
> 
> excerpt from http://www.opengroup.org/onlinepubs/007908799/xbd/envvar.html
> [...]
> In a non-english windows these members may have values like: (e.g. german)
> 
> Eastern Normalzeit
> Eastern Sommerzeit
> Pazifik Normalzeit
> Pazifik Sommerzeit
> Westeuropaische Normalzeit
> Westeuropaische Sommerzeit
> 
> and the computed values are:
> 
> EN
> ES
> PN
> PS
> WN
> WS
> 
> As you can see all values are invalid and incorrect timezone names.

Thanks for the description.  I've commited your patch.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
