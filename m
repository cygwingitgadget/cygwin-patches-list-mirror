Return-Path: <cygwin-patches-return-4078-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23081 invoked by alias); 13 Aug 2003 14:26:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23054 invoked from network); 13 Aug 2003 14:26:09 -0000
Date: Wed, 13 Aug 2003 14:26:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Consider extensions for special names in managed mode
Message-ID: <20030813142608.GD3101@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030813083512.GG13155@linux_rln.harvest> <Pine.GSO.4.44.0308131014360.8046-200000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0308131014360.8046-200000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00094.txt.bz2

On Wed, Aug 13, 2003 at 10:19:08AM -0400, Igor Pechtchanski wrote:
> Yeah.  I promised a patch, didn't I?  *Sigh*.
> 	Igor
> ==============================================================================
> 2003-08-13  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
> 
> 	* path.cc (special_name): Add checks for some specials
> 	followed by a "." and a FIXME comment.

I leave this to Chris for obvious reasons.

> +  // FIXME: add com0 and {com,lpt}N.*
>    if (strcasematch (s, "nul")
> +      || strncasematch (s, "nul.", 4)
>        || strcasematch (s, "aux")
> +      || strncasematch (s, "aux.", 4)
>        || strcasematch (s, "prn")
> +      || strncasematch (s, "prn.", 4)
>        || strcasematch (s, "con")
> +      || strncasematch (s, "con.", 4)
>        || strcasematch (s, "conin$")
>        || strcasematch (s, "conout$"))
>      return -1;

Clueless question:  What about sth. like foo.aux?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
