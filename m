Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4A02D3858D28; Wed, 27 Nov 2024 15:36:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4A02D3858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732721793;
	bh=iFuj00e19KDoPzNT4TKDbke5aVBKV91HwAwoFYaaG6Y=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ZkuPT9GWpVjI2Bhf8dRcS98d7ZI6Jwqb8PR23iI1+qusg4fjosvP6bx+ArmGigY3c
	 qIcbmONjmhfh7H9cCC50YKSSEhmPGmjikQ189UXVf/LXE30rkBekfqHxXtx8qnfWnw
	 JWmIeRen8Kpd6wnF8WmYCAhjqG/J1GE7+IFVGe60=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 464A6A80E4D; Wed, 27 Nov 2024 16:36:30 +0100 (CET)
Date: Wed, 27 Nov 2024 16:36:30 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_getscheduler: fix error handling
Message-ID: <Z0c8ft-7quz-HJfJ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <36a9bf51-b331-bb30-1bd3-2e112d9ec3fa@t-online.de>
 <99a63e87-5ab1-53ee-278c-dff0339696ec@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99a63e87-5ab1-53ee-278c-dff0339696ec@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 25 15:06, Christian Franke wrote:
> Christian Franke wrote:
> > Long standing (2001) minor issue.
> > 
> 
> v2 with "Fixes:" in log message.
> 

Pushed.


Thanks,
Corinna
