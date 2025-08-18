Return-Path: <SRS0=ndDD=26=Denis-Excoffier.org=cygwin@sourceware.org>
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
	by sourceware.org (Postfix) with ESMTPS id 319B4385842D
	for <cygwin-patches@cygwin.com>; Mon, 18 Aug 2025 18:15:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 319B4385842D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=Denis-Excoffier.org
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=Denis-Excoffier.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 319B4385842D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a01:e0c:1:1599::14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755540923; cv=none;
	b=JFOpmj9+rlPW7rowYq6cpz7psBkUxUrCPr5WK3lbte1vRMn9R4NmCRRrcCk8rgtQAXMJjbw3dZAbwwMLyZXe9okPm6wXkMNB6VEbq61Xg7Yco3zyyHiLfN8zwYjx6zhkX7LKrtd+n7XyE+Sge+vQhwrZmZjXOYYIMW9TT8CJ5JA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755540923; c=relaxed/simple;
	bh=MwIDjHf7CfnwrOM3hysOkw2MINTYp60VTqIJLF0A+4E=;
	h=Mime-Version:Subject:From:Date:Message-Id:To; b=S14r0BhphqcrmF0d8vbTay6amq+yDsVlJevn6GbMmm8K5ZtQ70doBkflnX6aMykl2LhPbD4Gt6kZ7c8X+ItZTgjs52jRc9pxzdI06Iu31ICF4LESyATasQzOlOGOxxw/sdNc4sXl+KvQCetdP1hrF8k+4uuORDBn+kTJJcYxoG0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 319B4385842D
Received: from smtpclient.apple (unknown [IPv6:2a01:e0a:eaf:1d30:5cfb:d932:e68f:6c62])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 96F1860129;
	Mon, 18 Aug 2025 20:15:17 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3] Cygwin: spawn: Make ch_spwan_local be initialized
 properly
From: Denis Excoffier <cygwin@Denis-Excoffier.org>
In-Reply-To: <20250818053130.1184-1-takashi.yano@nifty.ne.jp>
Date: Mon, 18 Aug 2025 20:15:06 +0200
Cc: Denis Excoffier <cygwin@Denis-Excoffier.org>,
 cygwin-patches@cygwin.com,
 Jeremy Drake <cygwin@jdrake.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE82195B-2F5C-4350-AA60-3532B10D9139@Denis-Excoffier.org>
References: <20250818053130.1184-1-takashi.yano@nifty.ne.jp>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
X-Mailer: Apple Mail (2.3826.700.81)
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,LOCAL_AUTHENTICATION_FAIL_SPF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NEUTRAL,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>


> On 2025-08-18, 07:31, Takashi Yano wrote:
>=20
> The class child_info_spawn has two constructors: one without arguments
> and one with two arguments. The former does not initialize any =
members.
> Commit 1f836c5f7394 used the latter to ensure that the local ch_spawn
> (i.e., ch_spawn_local) would be properly initialized. However, this =
was
> insufficient - it initialized only the base child_info members, not =
the
> fields specific to child_info_spawn. This led to the issue reported in
> https://cygwin.com/pipermail/cygwin/2025-August/258660.html.
>=20
> This patch introduces a new constructor to properly initialize member
> variable 'ev', etc., which were referred without initialization, and
> switches ch_spawn_local to use it. 'subproc_ready', which may not be
> initialized, is also initialized in the constructor of the base class
> child_info.
>=20
> Addresses: https://cygwin.com/pipermail/cygwin/2025-August/258660.html
> Fixes: 1f836c5f7394 ("Cygwin: spawn: Make system() thread-safe")
> Reported-by: Denis Excoffier <cygwin@Denis-Excoffier.org>
> Reviewed-by: Jeremy Drake <cygwin@jdrake.com>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> =E2=80=94
(=E2=80=A6)

PATCH v3 works for me. Thank you.
Regards,
Denis Excoffier.

