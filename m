Return-Path: <SRS0=e2Sx=HT=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.92])
	by sourceware.org (Postfix) with ESMTP id D77E24BA23FE
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 15:27:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D77E24BA23FE
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D77E24BA23FE
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.92
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790522861; cv=none;
	b=cI+YoioOrL1sGzJoFxv1p/eg0pS4ize3NEM8azsxjebQ5X/fMO7hZPLZUIOQAkBx/UWrgcf9M+HAi5h0t8ow0g2OefELyZDw773OIB/An5htg4IlR+MJEFGZAj1hTlAGceW1OBOuifSPCcQvfckd3ebzovTTLHPDFLk71KkOgc8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790522861; c=relaxed/simple;
	bh=krPd1piqVrx3QKOWZDvs+sShNXCbr+rhN6GLFmlLpCg=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=F6SR8sG44QKqdNemwY2TY3B5iWAnFRljZXblUf2zCJgLTNVznLxoEq3S7KmIuUxZsRvxpJB+tdxSqJHTZdETHZuRon8IzjIK5Ge3lF+MTHh+q7LfkSGoZ5oGji5JVODyFko8pwRB1QDfbXFsKJJvQUCb30nY05gVc0jb7dEKq6I=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D77E24BA23FE
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7161380A757AD2
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTEeLqVBdtUfsGZDcdWpniD3EtsJvZUcCkIjHgzn7V/AmwAni1LBcOVZ9sXrMMrP7BQo4uh6zGZVCVy86YgDbigaPdcCWdrYnbrAn5mg9Z0MASNy/mhCWtTgV50eI2/NIdRuMY+WWBQLW+DjfYstCIJh+rR1Io3ehpBkc0GdHeNWu+kY1/+p1lEo1ZiCroGQvrdAi1LPEwwo7FUQ/r2tGCA8k3FepkVTmopU0y1gJMK93DDPzwnFZAzTuIrjYWFxbWIp4cCRIKftd+ZdXm/KDTjKhnLtZCmVDfhJEmBvnYHmhvHPcO9QRo4t5qd/0L7K0GcdAXrh+d7yvBjpYtp/nNVyk1/PxfFWD1HHMcsz9sUp9EsTplEwQ6uKXvWikqeoGP+yjS4pt9BmnJMmHcZ3KsJ01YTLwNCGTvMu/cUFLQ4gn5QJJWw5yRWYl5L2gHFglTaMym0jXoBhFAf81JLiYAhKLVgjRfB9HoX/eFEwEy6+Bn5jG+6BIgrRa8WWAhG1je0AQs8lQ5z4H4oSiuB4tN889kYRz8a8jOFrr36hEWCkddcLImRP0ZEQCgqDn7UK/Dp3kW8dpwfG3VO69TvzbxaR0ZSmiEDUiTb9dZrVvvkDO4HbriMTMd3kabTPJxRIwiWF8X1HqLkXsVY6V2Jwn1xA2YhtzmHBKI6NcxarVDNqrg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.83.178) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7161380A757AD2; Sun, 27 Sep 2026 16:27:35 +0100
Message-ID: <03deccb5-1263-496f-8cce-9d469cbb65de@dronecode.org.uk>
Date: Sun, 27 Sep 2026 16:27:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: gendef: fix AArch64 stabilize_sig_stack lock
 retry
References: <PN3P287MB132079CFBDFDD28B446F33CAF7832@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com,
 Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
In-Reply-To: <PN3P287MB132079CFBDFDD28B446F33CAF7832@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/09/2026 21:27, Aswin Kalies Ramkumar Mangayarkarasi wrote:
> Hi Everyone,
> The AArch64 stabilize_sig_stack retry label sits below the code that
> computes the stacklock address and loads the "locked" constant, so
> neither is recomputed on a retry.  The signal-handler path branches
> back to that label after reusing x9 and x12 for the incyg counter, so
> a retry can operate on incyg instead of stacklock.  Move the label
> above the setup, and clear the exclusive monitor before yielding, as
> the ldaxr otherwise leaves one open across the yield.
> 
Applied, thanks!

