Return-Path: <cygwin-patches-return-3459-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28032 invoked by alias); 24 Jan 2003 15:26:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28022 invoked from network); 24 Jan 2003 15:26:38 -0000
Date: Fri, 24 Jan 2003 15:26:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Subject: Re: setregid() and setreuid() patch
Message-ID: <20030124152636.GH29236@cygbert.vinschen.de>
Mail-Followup-To: Cygwin-Patches <cygwin-patches@cygwin.com>
References: <20030124145520.GA612@tishler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030124145520.GA612@tishler.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00108.txt.bz2

On Fri, Jan 24, 2003 at 09:55:20AM -0500, Jason Tishler wrote:
> The attached patch implements setregid() and setreuid() as recommended
> by Pierre in:
> 
>     http://cygwin.com/ml/cygwin-developers/2003-01/msg00115.html

Applied with minor changes:

> +setreuid (__uid32_t ruid, __uid32_t euid)
             ^^^^^^^^^
	     __uid16_t

I've also applied the missing declarations in newlib's sys/unistd.h.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
