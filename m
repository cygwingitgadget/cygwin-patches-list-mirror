Return-Path: <cygwin-patches-return-9989-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70855 invoked by alias); 23 Jan 2020 14:16:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63863 invoked by uid 89); 23 Jan 2020 14:16:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 14:16:18 +0000
Received: from Express5800-S70 (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id 00NEG8Ht016397	for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2020 23:16:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 00NEG8Ht016397
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579788968;	bh=Z14IfapwDl8LMJqN+8pGhAlfiF5nklFuUUUMoF6Oo2U=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=lRu25evMhsjusYctULySNSwz2DkpsTOKSRDaEan5/erqC7Camv+k+RDtsCVjUcqOR	 CIsODmL4XyYr3V7BiVqc4BtQcjZ8S2pF41x3zxW9yGoIuSuKzPQrDuqNC5y+mlLIBI	 iUFC/g7i0/BlNLy9/GgqASW410QdvPi6h6m1o7gQZz/jUYahEPOsQKIvyK/CU1NTxi	 UTRd3G9eRa3k92xQ5iIsdd5IiNDA01tIRRhidhrFk8lIMTVyUGc4Sq/bkmqfX8r+dM	 /RWad1tPw3Q0Y+2hOyYnNlmqicO4f8S6R3lrokjDBF6iY+yncjTQPSPyQMxLJSx0Dy	 9delI3jnLcMkg==
Date: Thu, 23 Jan 2020 14:16:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding again.
Message-Id: <20200123231623.ed57b0af319d1de545f2ab7c@nifty.ne.jp>
In-Reply-To: <20200123125154.GD263143@calimero.vinschen.de>
References: <20200122160755.867-1-takashi.yano@nifty.ne.jp>	<20200123043007.1364-1-takashi.yano@nifty.ne.jp>	<20200123125154.GD263143@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00095.txt

On Thu, 23 Jan 2020 13:51:54 +0100
Corinna Vinschen wrote:
> On Jan 23 13:30, Takashi Yano wrote:
> > - After commit 6cc299f0e20e4b76f7dbab5ea8c296ffa4859b62, outputs of
> >   cygwin programs which call both printf() and WriteConsole() are
> >   frequently distorted. This patch reverts waiting function to dumb
> >   Sleep().
> 
> I understand the need for this change, but isn't there any other
> way to detect if the pseudo console being ready?  E. g., something
> in the HPCON_INTERNAL struct or so?

As for HPCON_INTERNAL,

typedef struct _HPCON_INTERNAL
{
  HANDLE hWritePipe;
  HANDLE hConDrvReference;
  HANDLE hConHostProcess;
} HPCON_INTERNAL;

hWritePipe:
This is for sending window size change message to pseudo console
(conhost.exe process).

hConDrvRererence:
I am not sure what this is for.

hConHostProcess:
Process handle of conhost.exe process.

None of them seems able to be used for that purpose.
I do not come up with other implementation so far.

Let me consider a while.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
