Return-Path: <SRS0=axO/=ZQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 8C1C03852106
	for <cygwin-patches@cygwin.com>; Thu,  3 Jul 2025 09:15:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8C1C03852106
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8C1C03852106
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751534153; cv=none;
	b=NjW2ZgXGnD0lCGCb7yRhmFFMUVzAX5vx9SWdGL8TQTpai2qgg0QDaG4vrZK83AXkxCPYRiRxpKmKLgSWQk8NFUEeQ2wTPuZ8mh+pjgLTkgQHQZXwGNUUkedk7c7j7r9aSLjKi2mZM6assjpxCC+4oaT1wBF36jLY+EAP1u3ijjA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751534153; c=relaxed/simple;
	bh=5meoI09WrrTwB+t8CqKlCTFuf4epo70Z3inTKTrBa0A=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=qWr5IRAUhw2NDWb/l8AX+lha/smTqPeNVQSsfCFWuLfyUUbsjvShvEFleiF4zgHK6ouLNE797bDetPxxxejsmL+uL0/1jTxCy092WpWk/vVj+YbiFBSvtJ1l7IVPGKCmdr8BjEQQYkXYa6Evm9peYLA8hb45rXlIFQ4Idn1kXnU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C1C03852106
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ii3eiJO5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751534146; x=1752138946;
	i=johannes.schindelin@gmx.de;
	bh=5meoI09WrrTwB+t8CqKlCTFuf4epo70Z3inTKTrBa0A=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ii3eiJO5guyfGW5LdYFFbPt01kP9OwvdsFjOqPfmqjaqi3yb54mE/pYbzNDsto4n
	 UKepw0j+sOiOPxrB0kdaUqFfpoYYs+tA/AIaJUWgjcC/iUm2+M3v4BYgsErtkOYpB
	 e+aXQ3CSuNF0/CIhj4s7u3iyg4xRobosc4sow4YmZQA3UyL8WyqUE1duJ8OkKryr3
	 RNZ0kEsm0nBcOoJLyajG/kwoV5apBwmQqYoAMs5VXAKHCzbNFsoULZd2oDCE+o2st
	 66YKCWhxBrHpmvm3a/t0kirihg+qV8SLfmNlzU0q+KcfWbxu+Xp/LitjWXj5oSb7q
	 QRGdZaH+1/icEEo8bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.20]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7i8Y-1uk1eC1UAM-00wwCb; Thu, 03
 Jul 2025 11:15:46 +0200
Date: Thu, 3 Jul 2025 11:15:44 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
In-Reply-To: <20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp>
Message-ID: <259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp> <9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de> <20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qnT+rsXvGtyWr+k3BkmIuq9kcAhJDzJs4Frkw6DCX8iBvHeN+8Y
 W79M6k1g7LT5w9HwiO25JSNN8xo0j4zpYnfQFlAKZoUm0h+UFlZLWkvgGZnB8kD/SEyiZnP
 SqA0M7OVgbJTcVvJPc5CWcRlMdIqlKGCLXtExEmy6iQGghX1B7Py2jUdcrryxPC2u11Yu2K
 0KpB8x1yEy6M9g+83Bchw==
UI-OutboundReport: notjunk:1;M01:P0:5qm6NAKcDkI=;2SJ0fMZZdcA1Wx4XsdPV2NgIK2I
 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
 HwNKpUMcwqczdG6lYYQw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 3 Jul 2025, Takashi Yano wrote:

> On Tue, 1 Jul 2025 14:01:45 +0200 (CEST)
> Johannes Schindelin wrote:
> >=20
> > thank you so much for this patch! I released a new Git for Windows
> > version including it:
> > https://github.com/git-for-windows/git/releases/tag/v2.50.0.windows.2
>=20
> I noticed this patch needs additional fix.
> Please apply also
> https://cygwin.com/pipermail/cygwin-patches/2025q3/014053.html

Thank you for the update!

I am curious, though: Under what circumstances does this patch make a
difference? I tried to deduce this from the diff and the commit message
but was unable to figure it out.

Ciao,
Johannes
