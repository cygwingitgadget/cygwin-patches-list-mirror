Return-Path: <cygwin-patches-return-4286-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11270 invoked by alias); 9 Oct 2003 11:40:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11258 invoked from network); 9 Oct 2003 11:40:34 -0000
Date: Thu, 09 Oct 2003 11:40:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: mman.h still has MAP_FAILED as caddr_t
Message-ID: <20031009114033.GC9554@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20031009085447.GC3032@efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009085447.GC3032@efn.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00005.txt.bz2

On Thu, Oct 09, 2003 at 01:54:47AM -0700, Yitzchak Scott-Thoennes wrote:
> The prototypes for mmap, etc. were recently changed from using caddr_t
> to void *, as called for by SUSV3, but MAP_FAILED wasn't changed.
> SUSV3 doesn't specifically say anything about how MAP_FAILED should
> be defined, but other platforms I've seen have a (void *) cast.
> 
> --- include/sys/mman.h.orig	2003-09-20 13:32:09.000000000 -0700
> +++ include/sys/mman.h	2003-10-09 01:30:46.735724800 -0700
> @@ -31,7 +31,7 @@
>  #define MAP_ANONYMOUS 0x20
>  #define MAP_ANON MAP_ANONYMOUS
>  
> -#define MAP_FAILED ((caddr_t)-1)
> +#define MAP_FAILED ((void *)-1)
>  
>  /*
>   * Flags for msync.

Thanks for the patch.

Applied,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
