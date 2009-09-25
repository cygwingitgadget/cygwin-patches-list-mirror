Return-Path: <cygwin-patches-return-6639-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26805 invoked by alias); 25 Sep 2009 08:11:26 -0000
Received: (qmail 26793 invoked by uid 22791); 25 Sep 2009 08:11:25 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 08:11:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id D25556D5598; Fri, 25 Sep 2009 10:11:09 +0200 (CEST)
Date: Fri, 25 Sep 2009 08:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] bugs in faccessat
Message-ID: <20090925081109.GA26348@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20090903T175736-252@post.gmane.org> <4ABC3A64.1030609@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ABC3A64.1030609@byu.net>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00093.txt.bz2

Hi Eric,

thanks for the patch.  Basically it looks ok, I have just two cosmetic
comments inline.

On Sep 24 21:35, Eric Blake wrote:
> diff --git a/winsup/cygwin/security.cc b/winsup/cygwin/security.cc
> index 00a8c32..8c67fc9 100644
> --- a/winsup/cygwin/security.cc
> +++ b/winsup/cygwin/security.cc
> @@ -1,7 +1,7 @@
>  /* security.cc: NT file access control functions
> 
>     Copyright 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
> -   2006, 2007 Red Hat, Inc.
> +   2006, 2007, 2009 Red Hat, Inc.

While you're at it, can you please add the year 2008?  It's missing
accidentally.  Thanks.

> diff --git a/winsup/cygwin/security.h b/winsup/cygwin/security.h
> index 7b09bc0..be0ebd4 100644
> --- a/winsup/cygwin/security.h
> +++ b/winsup/cygwin/security.h
> @@ -350,8 +350,8 @@ LONG __stdcall set_file_sd (HANDLE fh, path_conv &, security_descriptor &sd,
>  			    bool is_chown);
>  bool __stdcall add_access_allowed_ace (PACL acl, int offset, DWORD attributes, PSID sid, size_t &len_add, DWORD inherit);
>  bool __stdcall add_access_denied_ace (PACL acl, int offset, DWORD attributes, PSID sid, size_t &len_add, DWORD inherit);
> -int __stdcall check_file_access (path_conv &, int);
> -int __stdcall check_registry_access (HANDLE, int);
> +int __stdcall check_file_access (path_conv &, int, bool effective = true);
> +int __stdcall check_registry_access (HANDLE, int, bool effective = true);

Can you please drop the default values for the effective flag here
and add the value explicitely where necessary?  AFAICS, that only
affects two calls in spawn.cc which should rather get an explicit
"true".

With these two changes it's ok to check in.


Thanks again,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
