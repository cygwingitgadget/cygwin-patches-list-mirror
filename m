Return-Path: <SRS0=IWIc=WM=clisp.org=bruno@sourceware.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	by sourceware.org (Postfix) with ESMTPS id E91003858D33
	for <cygwin-patches@cygwin.com>; Tue, 25 Mar 2025 12:02:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E91003858D33
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=clisp.org
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=clisp.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E91003858D33
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=81.169.146.220
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1742904152; cv=pass;
	b=S9qUPhCt8F3TSrL961xpNbyu3cX/xp8BsoYF20VRNXqCLxBo1rGdgH2UnSG67U2xD9LE439m8c3l1X3H7l2Yz006kzxEXVx89tv4ph5y/IoK8OywpGagzkjmG/FTgsH3Al+L9S6Ec3X8oFJX/buHwxnhMsdx4AmqcpCdi931ank=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742904152; c=relaxed/simple;
	bh=yRwp1fTG1SCLCEHpUse0y/7pT1P5gomBPqwwkzEOEyo=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=uvVe4jt7dPuM3VQC4acwDEPL92GPZYLUyneXgrecVG7ZztYtHA4L0wdZDrNfwwv3U6Ta80ywP5by6Ya9XagZ05zjSNPhgn34In4pxc9Os1fdhmy0u8+JumNd633+TZSQBLHuflZNGWM9RjVSuxdmAJTgJCHZH5T6dIGNDiE3xJw=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E91003858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=clisp.org header.i=@clisp.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=SXylBje+;
	dkim=pass header.d=clisp.org header.i=@clisp.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Eu9tOY31
ARC-Seal: i=1; a=rsa-sha256; t=1742904150; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kYcIuyghwWbYLpXQ21TNVnEITXz1lMx7sZlNNvo5IFZ2Nbav/zYNZVB3f+hacR2Szl
    bxFRkQusL/6YqINOGXRw7HCg/tCfmxqQCFol3X1vMG4pNaQLGuRLUTIoXGA6tndS62cX
    zA6xXY1f51FnE7r5ot0rhKD4+wbZNGjfDcHmYLUOdG55XRa42iIF0+ZdxdDV055yNryC
    bSv0F0Z+ZYitDB/OA/rnEV1lJUraLHBKcd8MrLOuzEQ2dOfRpi/t+tLTPtOkrTuFP9of
    uOlQEUZxXxmSyo/+w1Fhkwx3LH2vaUKFpCOlml7o16qY3sh1mK/mzgHqW7wIxR2WV2pb
    jBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742904150;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=yRwp1fTG1SCLCEHpUse0y/7pT1P5gomBPqwwkzEOEyo=;
    b=ZRTeaafaSFTWd3/JiXuwK6eiM/3ev7c/3nOJ4rxehowBhpCWLLy0TYwg1ULMG9KJaj
    wQ0KRM82T1PsruqHVQMJAv6UwDfo06VjMA3/6LCtr2EVqI1m5hjnWT0mQ7gyB9vuTH+B
    lV5w91BnShSjBTHvMXzEFIpNJUhZVJIOBhlgUxA5UPv6HkB2zRprUKEJzB2qI8RdzBq6
    A/g3Z7l9WRCpnyrrI6pIi+WI+L/fEKuHfoL2WN8pD0S1UqLw5v9wYvvw7pcHMGsKia17
    2i/FmdrXChnASmDbgyY2dfTVKHHCbYWsYXio7SgzIv9zSVuJG1mivE/eWEjGTQmJmPLr
    k3KA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742904150;
    s=strato-dkim-0002; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=yRwp1fTG1SCLCEHpUse0y/7pT1P5gomBPqwwkzEOEyo=;
    b=SXylBje+Iq6pDO8tiJc0R7gVy/YHcr/gVk0vYWq8Fy0m0GhBBmgB/KeHq2T/zYxoIJ
    MOY92TSYdy/FmzZMyZqFXRzJnhKPRgzwcWsryyhFRRLSyqVjcEsA51dZcSwcu23DJKdT
    dHX8Trl+l9BWxIHfmctMWvGo4vsu675G9gSg8finjDRrMgWEHFvcx0iGHsSlAQDIOsSq
    IzScQgh5nEUKfuiFxW5WsZusDIkVhNdsyhstB6crL6JD0wsYqAICri4aPEYxVVkqCkiA
    k3p4Blyq8o0M2uk9BpGqcRwtTmVlO6EHFmenXLR6Cme/xgZaZBUwYP+kfYyCbSkfEFEw
    u2Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742904150;
    s=strato-dkim-0003; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=yRwp1fTG1SCLCEHpUse0y/7pT1P5gomBPqwwkzEOEyo=;
    b=Eu9tOY31NinihOnO8wZtO4folmZBQXiTNKP6Pocj+xPqmvOuUwFWR5/QeP4wvDBNCG
    2CF5D0Nf8+5pwZJXi/Dg==
X-RZG-AUTH: ":Ln4Re0+Ic/6oZXR1YgKryK8brlshOcZlLnY4jECd2hdUURIbZgL8PX2QiTuZ3cdB8X/nqj2dR2P/LC1keEOIyi0hNRYRgQ=="
Received: from nimes.localnet
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id N7dcf812PC2TTsN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Mar 2025 13:02:29 +0100 (CET)
From: Bruno Haible <bruno@clisp.org>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject:
 Re: [PATCH] Cygwin: signal: Do not copy context to stack area in
 call_signal_handler()
Date: Tue, 25 Mar 2025 13:02:29 +0100
Message-ID: <2498376.n97fhnxGW3@nimes>
Organization: GNU
In-Reply-To: <20250325101611.1872-1-takashi.yano@nifty.ne.jp>
References: <20250325101611.1872-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano wrote:
> Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257714.html
> Reported-by: Bruno Haible <bruno@clisp.org>

Thanks. What output do you now get by running

$ ./test-c-stack; echo $?

10 times and

$ ./test-sigsegv-catch-stackoverflow1; echo $?

10 times as well?

Bruno



