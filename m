Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 507103886F70; Wed, 18 Jun 2025 14:33:17 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E1439A8041A; Wed, 18 Jun 2025 16:33:12 +0200 (CEST)
Date: Wed, 18 Jun 2025 16:33:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: fix compatibility with GCC 15
Message-ID: <aFLOKNAlrll4k2mb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB09231D8148C836A3AECDB3E19270A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923C311FFF85FC2D2D2428F9272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB0923C311FFF85FC2D2D2428F9272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 18 12:05, Radek Barton via Cygwin-patches wrote:
> Hello
> 
> Sending second version with Signed-off-by header.
> 
> Radek
> 
> ---
> >From 715fe9b84a9e290efda46c0a8c649fe145c981cf Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Thu, 5 Jun 2025 12:42:05 +0200
> Subject: [PATCH v2] Cygwin: fix compatibility with GCC 15
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/create_posix_thread.cc    | 2 +-
>  winsup/cygwin/local_includes/fhandler.h | 6 +++---
>  winsup/cygwin/local_includes/thread.h   | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)

Pushed, including 3.6 branch.

Thanks,
Corinna


