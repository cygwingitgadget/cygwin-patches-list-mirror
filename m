Return-Path: <cygwin-patches-return-5193-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13334 invoked by alias); 11 Dec 2004 08:51:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13311 invoked from network); 11 Dec 2004 08:51:11 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.108.209)
  by sourceware.org with SMTP; 11 Dec 2004 08:51:11 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id D232157E53; Sat, 11 Dec 2004 09:53:19 +0100 (CET)
Date: Sat, 11 Dec 2004 08:51:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] fhandler.cc (pust_readahead): end-condition off.
Message-ID: <20041211085319.GA13243@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cp0gle.3vsh6i5.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cp0gle.3vsh6i5.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00194.txt.bz2

On Dec  6 02:45, Bas van Gompel wrote:
> 2004-12-06 Bas van Gompel  <cygwin-patch@bavag.tmfweb.nl>
> 
> 	* fhandler.cc (fhandler_base::puts_readahead): Fix end-condition.
> 
> 
> --- src/winsup/cygwin-mmod/fhandler.cc	5 Dec 2004 07:28:27 -0000	1.209
> +++ src/winsup/cygwin-mmod/fhandler.cc	6 Dec 2004 01:14:14 -0000
> @@ -54,7 +54,7 @@ int
>  fhandler_base::puts_readahead (const char *s, size_t len)
>  {
>    int success = 1;
> -  while ((*s || (len != (size_t) -1 && len--))
> +  while ((len == (size_t) -1 ? *s : len--)
>  	 && (success = put_readahead (*s++) > 0))
>      continue;
>    return success;

Yes, that looks better.  I'd say the patch is correct.  Please apply.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
