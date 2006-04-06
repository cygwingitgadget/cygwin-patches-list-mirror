Return-Path: <cygwin-patches-return-5815-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29824 invoked by alias); 6 Apr 2006 00:40:18 -0000
Received: (qmail 29813 invoked by uid 22791); 6 Apr 2006 00:40:18 -0000
X-Spam-Check-By: sourceware.org
Received: from fios.cgf.cx (HELO cgf.cx) (71.248.179.247)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Apr 2006 00:40:17 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 45BD013C08F; Wed,  5 Apr 2006 20:40:16 -0400 (EDT)
Date: Thu, 06 Apr 2006 00:40:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to dcrt0.cc for dmalloc
Message-ID: <20060406004016.GB7174@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20060405201622.009b7100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20060405201622.009b7100@incoming.verizon.net>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00003.txt.bz2

On Wed, Apr 05, 2006 at 08:16:22PM -0400, Pierre A. Humblet wrote:
>2006-04-06  Pierre Humblet  <Pierre.Humblet@ieee.org>
>
>	* drct0.cc (dll_crt0_1): Move malloc_init after
>user_data->resourcelocks->Init.

As I mentioned in cygwin-developers "those two lines" (i.e., the ->Init
lines that are required for proper operation of user_data->resourcelocks
that you were mentioning) could and have been moved back into dll_crt0_0
so there is no reason for this patch that I can see.

cgf

>diff -u -p -r1.303 dcrt0.cc
>--- dcrt0.cc    3 Apr 2006 17:33:07 -0000       1.303
>+++ dcrt0.cc    5 Apr 2006 16:07:53 -0000
>@@ -784,7 +784,6 @@ static void
> dll_crt0_1 (char *)
> {
>   check_sanity_and_sync (user_data);
>-  malloc_init ();
> #ifdef CGF
>   int i = 0;
>   const int n = 2 * 1024 * 1024;
>@@ -794,6 +793,7 @@ dll_crt0_1 (char *)
> 
>   user_data->resourcelocks->Init ();
>   user_data->threadinterface->Init ();
>+  malloc_init ();
>   ProtectHandle (hMainProc);
>   ProtectHandle (hMainThread);
>
