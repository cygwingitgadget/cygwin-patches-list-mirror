Return-Path: <SRS0=qaRL=V3=m.gmane-mx.org=gocp-cygwin-patches@sourceware.org>
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	by sourceware.org (Postfix) with ESMTPS id 98CC63858D1E
	for <cygwin-patches@cygwin.com>; Sat,  8 Mar 2025 20:10:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 98CC63858D1E
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=m.gmane-mx.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 98CC63858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=116.202.254.214
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741464604; cv=none;
	b=NgiHd0VQUwnA6WJ/3tXmv95gNNnIfpmoJ+cGHoQ2ZAcT/qtYqCQkurZY1qCuOg6ioSQtZru9I02Dn0SRF/7BFRIhbTxTYnYuZEPtkscsoXwiasiGSzKk8IQ4C1r2a2m8WgKL7sewXGKVhL/Rrx7tLmF0ZpfPhbXb0vxpRVuHA2c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741464604; c=relaxed/simple;
	bh=DeJ4xg7n1dRRFbMgDiXqriBALoSMVnV3CngyW4Ja46o=;
	h=To:From:Subject:Date:Message-ID:Mime-Version; b=SDNaH7COTOlETyxXVbBp7SgbBdiHMMcLq5WJAJvKc3JN1Vu3NEubP30L+kAS+B7vGnpxfz6nnbY+O3ZxsYuYKT4t5IoxqR+80aaJEvtTsFB12bKZMJhGhq57jFWmqTN2wqIoJd9mrxGGkjHWPXBU7fijoR/5KytVpg43Mk2g/18=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 98CC63858D1E
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gocp-cygwin-patches@m.gmane-mx.org>)
	id 1tr0Uk-0009RI-1A
	for cygwin-patches@cygwin.com; Sat, 08 Mar 2025 21:10:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: cygwin-patches@cygwin.com
From: Andrew Schulman <andrex.e.schulman@gmail.com>
Subject: Re: [GOLDSTAR][PLUSHHIPPO] Re: [PATCH v3 2/3] Cygwin: signal: Fix a race issue on modifying _pinfo::process_state
Date: Sat, 08 Mar 2025 15:08:58 -0500
Message-ID: <mu8psj16ga7p81dvnk6kfhmg6fhvqvvddi@4ax.com>
References: <20250228233406.950-1-takashi.yano@nifty.ne.jp> <20250228233406.950-3-takashi.yano@nifty.ne.jp> <Z8V7onhvf9I8Hcuc@calimero.vinschen.de> <20250303212453.511e306b7e0cf9ce04fad69c@nifty.ne.jp> <Z8WoFOXWxwC8AJNx@calimero.vinschen.de> <20250303233919.4f463d642c88623f9c520f74@nifty.ne.jp> <Z8X6uJJwhVA7i7lk@calimero.vinschen.de> <74c86bc5-ba6c-4ea2-b39f-d41ef538c5f9@dronecode.org.uk> <Z8nvhKqPZ6k7DgIs@calimero.vinschen.de> <79e2e9a1-f7e3-43a8-b1fd-1a1bdd477158@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Newsreader: Forte Agent 4.2/32.1118
X-Archive: encrypt
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,KAM_DMARC_STATUS,LOCAL_AUTHENTICATION_FAIL_DMARC,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

> >> I think Takashi-san must be about due another gold star, as he's been doing
> >> some sterling work recently, fixing complex and difficult to reproduce bugs!
> > 
> > Absolutely!  Yesterday I was even mulling over a pink plush hippo, but
> > Takashi already has one over his fireplace and I wasn't sure if a second
> > one isn't taking too much space.
> > 
> > Corinna
> 
> An hippo is well deserved IMHO
> 
> Regards
> Marco

Awarded! https://cygwin.com/goldstars/#TY

