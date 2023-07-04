Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1C8E63857723; Tue,  4 Jul 2023 14:33:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1C8E63857723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688481201;
	bh=6z9qD+EQwppLwEBzwrGNHOsdV2NJbmeJ31CQzW+U4YM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=o53Uoal6D1Fz6zqQizIqdB9Hnkx/RUfP/D99KudvCX5MtBRGG9MOdaEkO5rhqwynf
	 yxXXUYqm2t4qr/N7Ie8oG7M591Z3UDT722C6KOFzUvvnlxP6GSzixi+2wg7rWTxKck
	 x5KINfvojrFh3owW6oZF7mgtoYAjqOxJvfsTZ614=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7500CA80F7A; Tue,  4 Jul 2023 16:33:19 +0200 (CEST)
Date: Tue, 4 Jul 2023 16:33:19 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Make <sys/cpuset.h> safe for c89 compilations
Message-ID: <ZKQtr5+C7B+gLQtT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230704005141.5334-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230704005141.5334-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  3 17:51, Mark Geisert wrote:
> Four modifications to include/sys/cpuset.h:
> * Change C++-style comments to C-style also supported by C++
> * Change "inline" to "__inline" on code lines
> * Add "#include <sys/cdefs.h>" to make sure __inline is defined
> * Don't declare loop variables on for-loop init clauses
> 
> Tested by first reproducing the reported issue with home-grown test
> programs by compiling with gcc option "-std=c89", then compiling again
> using the modified <sys/cpuset.h>. Other "-std=" options tested too.
> 
> Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html
> Fixes: 315e5fbd99ec ("Cygwin: Fix type mismatch on sys/cpuset.h")
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> 
> ---
>  winsup/cygwin/include/sys/cpuset.h | 49 ++++++++++++++++--------------
>  winsup/cygwin/release/3.4.7        |  3 ++
>  2 files changed, 30 insertions(+), 22 deletions(-)

Pushed.

Thanks,
Corinna
