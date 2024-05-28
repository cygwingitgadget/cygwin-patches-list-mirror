Return-Path: <SRS0=Un4c=M7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id D8A033858C32
	for <cygwin-patches@cygwin.com>; Tue, 28 May 2024 07:31:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D8A033858C32
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D8A033858C32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1716881508; cv=none;
	b=gMdzdZdGaByf9Vs0sI870vzA7P2fEDYl7J4AN9N6ihqFzX7SMM1Ngbo6ai1mfNDM5pZtEM6cmoSpClGfdFuy468rGaoci38VcNcQ0ziRyGAVTiLPEDQP2Kq5M49AhZuvTXqiC6Qwsi8hIxByW+y+RPH+UAjGwnOOITuLQb3+3rk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1716881508; c=relaxed/simple;
	bh=dKxL8ncbR57CKLU5R3+p+JdASw+7MPYjm6uht7MhxY8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=I0FQX4QOIAonEV6cL+DSYI7tBL6y4J3i4Ns9KVFWhWUyw6ruaNrovILgaWq8zZAqwr5BW3kVLPWYFO6dZ23IyjLACxwsK94ADyyxAgrWKQbRekwZ1t2RYRwSuwNuJMzcXjC1lm0ihLn1J1WXglR4jnTMjqdZ5ztcreCflZ0eRK0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20240528073142619.KZWN.41146.HP-Z230@nifty.com>;
          Tue, 28 May 2024 16:31:42 +0900
Date: Tue, 28 May 2024 16:31:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: <cygwin-patches@cygwin.com>
Cc: Jeremy Drake <cygwin@jdrake.com>
Subject: Re: [PATCH] Cygwin: disable high-entropy VA for ldh
Message-Id: <20240528163142.218a0089041defc754c6472d@nifty.ne.jp>
In-Reply-To: <719ef5af-7945-6ffd-d217-6a9cec1540fb@jdrake.com>
References: <719ef5af-7945-6ffd-d217-6a9cec1540fb@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1716881502;
 bh=W4ubw1WRRSM9xt5nS1wkRbDzYguduw2dhRwxSiqZw40=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=tCRQ1Wv1ySLBKMirD87O63nnOAonX6JwEuYQbEzfcMpwR9oxOPuIFB8sIETE8H3NHkrzm3Uj
 1RTDm6/1OfDa5ytZZnWhPPgRBLzIlsZsYcOoZVZs5dlNDZSyq1KN2ruRMol/nQpKbomjLEJjiU
 7us/KaCSnXCIpH5QeXs6bKm7yOmVvjCQsfQ4vCbO1ojDSPjxXv4nRMWAkIAZkbJI6TWUROPE2g
 ytyziE9ucjvnOMOyxaS5wIqeqDIRxdV4RiLVLKlDtWTlushrvH/hfkhDnYWcbUZu2ntwyotNWS
 cvAGYhrv18E3sHItSfh9pSiKZovq98dVoiAwgyvWoBSkCA6g==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

Thanks for the patch. The patch itself LGTM.

On Mon, 27 May 2024 22:36:07 -0700 (PDT)
Jeremy Drake wrote:
> If ldd is run against a DLL or EXE which links to the Cygwin DLL, ldh
> will end up loading the Cygwin DLL dynamically, much like cygcheck or
> strace.

IIUC, ldh is not used for EXE.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
