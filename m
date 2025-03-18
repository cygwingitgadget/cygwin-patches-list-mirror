Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id ACC173858CD1; Tue, 18 Mar 2025 16:31:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ACC173858CD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742315463;
	bh=pS2Yh07+gaxL0LDB/pWajolua1zfjlC1bEUSom/ErO0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rV0HskSljE98aFKYQnMaagkwFq+rpawoLeAK9hyJek/+owXbfwBl8ZRbCS6bz1lDf
	 GQWTaHK7g0QKZdaICdLwWUox0JeaqLhKR5PaReOONizS8n1rpC43hbRkYehYhkUzRL
	 BurroOeU0RmeBpAvxRBXCpXrcDzj3MRk4v67W4dY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 97229A8098D; Tue, 18 Mar 2025 17:31:00 +0100 (CET)
Date: Tue, 18 Mar 2025 17:31:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: doc: rename sched_setpolicy(2) to
 sched_setscheduler(2)
Message-ID: <Z9mfxG2FuwlRtGw4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <2e4668e3-17ac-8a5a-60b8-dbf2e8514798@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e4668e3-17ac-8a5a-60b8-dbf2e8514798@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Mar 18 12:20, Christian Franke wrote:
> 

> From 4f4b5135e229cabacd445e4738dbdc7f8cee45a4 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Tue, 18 Mar 2025 12:15:12 +0100
> Subject: [PATCH] Cygwin: doc: rename sched_setpolicy(2) to
>  sched_setscheduler(2)
> 
> The function sched_setpolicy(2) does not exist.
> 
> Fixes: 757424f74400 ("Cygwin: doc: document sched_setpolicy(2) and priority mapping")
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/doc/posix.xml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Pushed.


Thanks,
Corinna

