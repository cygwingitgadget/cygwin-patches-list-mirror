Return-Path: <cygwin-patches-return-6126-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5267 invoked by alias); 2 Jul 2007 09:47:56 -0000
Received: (qmail 5257 invoked by uid 22791); 2 Jul 2007 09:47:55 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 02 Jul 2007 09:47:53 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 3BD8C6D47FF; Mon,  2 Jul 2007 11:47:51 +0200 (CEST)
Date: Mon, 02 Jul 2007 09:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] w32api: added CSIDLs
Message-ID: <20070702094751.GA5518@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <f062943a0707010111o3cf09fddj846a8d89a568cd1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f062943a0707010111o3cf09fddj846a8d89a568cd1f@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00001.txt.bz2

Hi Przemek,

On Jul  1 10:11, Przemek Czerkas wrote:
> 	* include/shlobj.h: Added CSIDL_MYMUSIC
> 	Added CSIDL_MYVIDEO
> 
> Index: shlobj.h
> ===================================================================
> RCS file: /cvs/src/src/winsup/w32api/include/shlobj.h,v
> retrieving revision 1.46
> diff -u -r1.46 shlobj.h
> --- shlobj.h	25 Jul 2006 00:22:19 -0000	1.46
> +++ shlobj.h	1 Jul 2007 07:40:06 -0000
> @@ -157,6 +157,8 @@
> #define CSIDL_SENDTO	9
> #define CSIDL_BITBUCKET	10
> #define CSIDL_STARTMENU	11
> +#define CSIDL_MYMUSIC	13
> +#define CSIDL_MYVIDEO	14
> #define CSIDL_DESKTOPDIRECTORY	16
> #define CSIDL_DRIVES	17
> #define CSIDL_NETWORK	18

Thanks for the patch.  I've applied it.

Btw., the w32api is officially maintained by the MinGW folks, see the
README.w32api file.  Patches to w32api are better off in the appropriate
mingw mailing list.


Thanks again,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
