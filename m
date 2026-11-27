Return-Path: <SRS0=cL0F=JQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id A6ED345309E9
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 15:38:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A6ED345309E9
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A6ED345309E9
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795793912; cv=none;
	b=Ir+3MmtGqfR+pDxGs3UTKLElVwSMS8nGs3Xzr+r28m/FkEm8XNv4tiCzgG92DTSiDz0ckAF2/pB5JYE/uNi9JvNEMrxLDDevPC6AvWbE9dNCWtDuK9edJmiGS6jJJFs1wWWpuIRzh1POQARIMzJDhvSqjlJR0Arbbeslmwc6CTw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795793912; c=relaxed/simple;
	bh=QT653gWy0O9uV83TnaCQcxOg1vwWEV8VO6tUem45pB4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=j1F0OZsUuYZeYUK0XsLSJsZyAxstTiWClTwFxQa1IkJJqbQdvbfBINno3rN0T0M616ORe/643UmRibnc+rRXZ1BtuuLEoERuNSs4+0NTb0rkQ0RPOhSWh4bdSgWSWVebXdvNfFt6m8Bl7k5l/77vm3JqBk6Sr5KbGoqF4pQUlVI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=BfyopIUJ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A6ED345309E9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=BfyopIUJ
DKIM2-Signature:  i=1; m=1; t=1795793910;
 mf=PEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPg==;
 rt=PGN5Z3dpbi1wYXRjaGVzQGN5Z3dpbi5jb20+;
 d=gmx.de;
 s=s31663417:rsa-sha256:AHCqPwo8EkEaUS07oSyOb7YPI1Da
   hZKOuldBdSgnTOVq3Y2KPVaF4zWu4NGYbwLVSYup3FDx1GHtRMIZ6u+1/DUzzehFz3twuDNvo7x
   3KOw3ZYKlp+/l002F4IJKIrHYY+sD497KRX9XKv3VHfg3MvaIjgzPnNq4eKWlS862ZGJQ0+d25n
   7LK56OZGNDjTrWGAeMPPi8wGl3UaFifKsUL2zqTg9KfYQJNiFYpP4PMEBBy/yhcoRUoCRM2D16X
   8AJ94TYJ3PToDKflndl377tvdL7beA8hH/x5fXjTEakt0ep4qcPuGSKzEpipTEZwez2PrZ5noUK
   Y7oIRxfOSCLSlw==;
Message-Instance:  m=1;
 h=sha256:
   p1JLV9N8PMkovXqzzVCPWANc42UZW8Wtt1VfVvGdrP0=:
   QT653gWy0O9uV83TnaCQcxOg1vwWEV8VO6tUem45pB4=,
  sha512:
   mcQxSoYzbOfOFjcMLDnZOAErtgywAEzvnZMBzQdU6ceZtu5P+TiSu5WuXfWctc+gpXkfaZPVuQhqBvAbyONvIw==:
   EU9iTW7ePm6HtG/uvORh2mINHuSsHETmWR5BUaezTCwC1XpHGPQz7gBDmqGPgoNngL2Kq2iJB/RYpEXNrwo8JA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795793903; x=1796398703;
	i=johannes.schindelin@gmx.de;
	bh=QT653gWy0O9uV83TnaCQcxOg1vwWEV8VO6tUem45pB4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BfyopIUJiiyom9UGwxBImJdCUmitGu7MegRR0YeBueoDg3YQSoNpxA6O1Cc4CJNH
	 64hLEzxtEpnMUi8pWUlzEKJB2D+zOP9yttcsVLoiqASbaijPlaRKluZngqJ5XROVw
	 tXB6e3ZknI0h82qIIvi8dDQzBjiCyMPBPTM3+i9w8hxvEoKwyFqVIyFzQJf8oQW+E
	 zj38vpI9D121wiyb0mpMQyHTe7FEnp7Qymw2ainaEzy7vEzeFnGp1s6ovRT4KsIzN
	 2uWtJIcUa2Y9qmGY5I16GBKSA3Xq+gZSiWFIcZEMJvrC3v+OrL+maGDZ60M+v0JDt
	 r72SB70Ikhx/62fWCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma24s-1y2v8t3O4q-00L2an; Fri, 27
 Nov 2026 16:38:23 +0100
Date: Fri, 27 Nov 2026 16:38:22 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [Request for review] pty, console related patches
In-Reply-To: <20261124114753.49c6221093b1a5d5252da3c4@nifty.ne.jp>
Message-ID: <d103b70d-4822-8e4c-8dd3-1f24d9a2706b@gmx.de>
References: <20261124114753.49c6221093b1a5d5252da3c4@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:1/xBSeDXXfUI2Svfi1rzbEYAKNX8A1GkHmyh5TzWJNKJ+MZhEET
 s1f+G0aO2jKsnVlBk5XM2mAStrKyJTLkHPQ78ssrgrPkqstcrL84q3zEEV/zuDdj754mB65
 T5G78SkvdmiY0OFcXKWpAC/mrznBqJGbsSvbkPZ77baRAbWHm5mGnHV+LntJs+VhChCx2Ak
 3VZpTbi/OmBhJf+x+U0mg==
UI-OutboundReport: notjunk:1;M01:P0:3JVMTksK+y8=;q0NIw+WrqJQ2Va3GuisV1QG0d/Q
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 24 Nov 2026, Takashi Yano wrote:

> Could anyone review the following patches?
>=20
> [PATCH] Cygwin: pty: Do not use terminfo to determine the terminal capab=
ility
> [PATCH 1/2] Cygwin: console: Set ENABLE_PROCESSED_INPUT only when ISIG i=
s set
> [PATCH v5 2/2] Cygwin: pty: Handle win32 input mode rather than omitting=
 it

I found no blocker in the ISIG paths I checked, but the terminfo-removal
and Win32-input changes may need fixes before landing. For the record: I
ran out of time looking over v5. It is a rather large patch, and its goal
is tricky to achieve. And I am unfortunately stretched paper-thin at work,
so hopefully it's okay that I gave you only an incomplete review?

Ciao,
Johannes
