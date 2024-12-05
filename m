Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 47FAA3858D20; Thu,  5 Dec 2024 14:28:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 47FAA3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733408901;
	bh=fHBo1nmJL3VxABXfOdtDDu9eHxMZtYAu3EJ7IKSH1B8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=nAslutm6GIiSrNx0UH5RjFNGYTfqtPuCqg7aHc/ffj57kSy55jrnWQIAjtmdSINxX
	 K/hbwboDEaf9PZOtFjy64wGT31ATKZFkIn6fJ3T5OoHLuyTPw9+CdgP/45UV8+T6pt
	 MQnzwhw0iTx3nhP6M7GGd9SZsMvAk8OJxmfUpuM0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1592FA8061B; Thu,  5 Dec 2024 15:28:12 +0100 (CET)
Date: Thu, 5 Dec 2024 15:28:12 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Signal patches still necessary
Message-ID: <Z1G4fGj7kM0arCJx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241205122604.939-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205122604.939-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec  5 21:25, Takashi Yano wrote:
> Takashi Yano (3):
>   Cygwin: signal: Remove queue entry from the queue chain when cleared
>   Cygwin: signal: Introduce a lock for the signal queue
>   Cygwin: Document several fixes for signal handling in release note
> 
>  winsup/cygwin/exceptions.cc            | 12 ++---
>  winsup/cygwin/local_includes/sigproc.h |  5 +-
>  winsup/cygwin/release/3.5.5            |  4 ++
>  winsup/cygwin/signal.cc                |  4 +-
>  winsup/cygwin/sigproc.cc               | 72 +++++++++++++++++++-------
>  5 files changed, 68 insertions(+), 29 deletions(-)
> 
> -- 
> 2.45.1

LGTM.

Thanks,
Corinna
