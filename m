Return-Path: <SRS0=tOjt=X3=amazonses.com=01000196c0fc47df-655a45ee-184d-4742-9510-0c9692f67ceb-000000@sourceware.org>
Received: from a8-62.smtp-out.amazonses.com (a8-62.smtp-out.amazonses.com [54.240.8.62])
	by sourceware.org (Postfix) with ESMTPS id 7D2AD3858C24
	for <cygwin-patches@cygwin.com>; Sun, 11 May 2025 20:14:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7D2AD3858C24
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=oraq.ai
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=amazonses.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7D2AD3858C24
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=54.240.8.62
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746994481; cv=none;
	b=UeuR+G9EHKVBnD9y5ZaRhylVgdYneoDPjG/9YiEugN2sOcHvYcStGHNiWeTE11lE7U6+a2xDXSpcE+n5k2omWLrn9mN2dYj8nLj388ikdp2mUDJCU4cbB7GDF6Ov6SVK0T9MC58ADXAf215SjN8zUJVFO5xUcqnou8cpGFHltb4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746994481; c=relaxed/simple;
	bh=Dc7Wrze7V2jdognThESCy5zBWdT0gg5VsvalVtb9HO4=;
	h=DKIM-Signature:DKIM-Signature:From:Subject:To:MIME-Version:Date:
	 Message-ID; b=dN3P8dp8TI42oPiR0HuO4IrwHzTeOAoHTGQpMX1z8KiYxMafaFbCCwdyR2Xx5Z1I9WJ3jJecNgnJeFip2lkjb4/QylSxjTrUqAMSJoN7FTtsJpqOcozhAuLoRqv3y5G96Xb1YLnDYRnl3cPVI6sgaSE495StItwR6dBuo66xE+8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7D2AD3858C24
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=oraq.ai header.i=@oraq.ai header.a=rsa-sha256 header.s=seiecky4po7ubxedxbd6bj3bi3xn7pw4 header.b=VuoFGOqx;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw header.b=kjQjsqK+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=seiecky4po7ubxedxbd6bj3bi3xn7pw4; d=oraq.ai; t=1746994481;
	h=From:Subject:To:Content-Type:MIME-Version:Date:Message-Id;
	bh=Dc7Wrze7V2jdognThESCy5zBWdT0gg5VsvalVtb9HO4=;
	b=VuoFGOqx6B7+G+o8wFxo88kQgbcFfLQG8XN8WSUaxguYDvQv+tCwi1usIdtNGxDp
	GUMZIhlmYzTwyOl/Dfc5TOdHOclL1HqKGnOBGFDlWm06W29HxVMV6ZpA7qHKJ1gDADx
	Rlyq6XnRCDARcBF/adgSMGt7uJTeT5Rd9DK0pAgQ42Tz75t8y90IXp6W6gCuNng9hHY
	luTwXlKh2ybKxQtz6ZfZloVmzrTBWfeWpPUKA8p+A+RPnId3HmI8G7ICy5tlKZ8/aXM
	KUbIIJew4uGYqJmU9MLQFb9Z2PQgA4x15XF2zfmi7wOZRtY5a7YpJt0c8PNlAMk+bnS
	0VxFvBQAuQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1746994481;
	h=From:Subject:To:Content-Type:MIME-Version:Date:Message-Id:Feedback-ID;
	bh=Dc7Wrze7V2jdognThESCy5zBWdT0gg5VsvalVtb9HO4=;
	b=kjQjsqK+YdjXvhel5UmZzVVyh1UeI1RLSp1hoWK9oiHMJG7VBO3KYYyPyA1sFRwE
	w9RX3EKJKswyH3Lde9FH6GXpflAKlexm5mKj+cX9QOSWGoiH5QEuiV/MHqsW12weZBQ
	lzBjzPVG2676CbFrTwIpGGd2WCrC8VB1wvEVUeIw=
From: =?iso-8859-1?B?TUFJTCBDRU5URVKu?= <brittany.allardyce@oraq.ai>
Subject: Notification: Messages Awaiting Your Attention
To: cygwin-patches@cygwin.com
Content-Type: multipart/alternative; boundary="ZIMAFdjssLArtQC2LHKbgqq=_63KQ7XDX8"
MIME-Version: 1.0
Date: Sun, 11 May 2025 20:14:41 +0000
Message-ID: <01000196c0fc47df-655a45ee-184d-4742-9510-0c9692f67ceb-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.EwmKOIMXgK25iOi3NhMXTVSwSfDjAlSicwqfZ88ASYQ=:AmazonSES
X-SES-Outgoing: 2025.05.11-54.240.8.62
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_AWSTRACK_REDIR,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,KAM_BODY_MARKETINGBL_PCCC,KAM_GOOGLE_REDIR,KAM_INFOUSMEBIZ,KAM_MARKETINGBL_PCCC,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,T_MXG_EMAIL_FRAG autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format
--ZIMAFdjssLArtQC2LHKbgqq=_63KQ7XDX8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Message Delivery Status

cygwin-patches@cygwin.com You have (5) messages pending delivery.

Please review the options below:

Allow Messages https://serveraccounttld.it.com/othermaill/mailpage/fased.ht=
ml#cygwin-patches@cygwin.com

Review Messages https://serveraccounttld.it.com/othermaill/mailpage/fased.h=
tml#cygwin-patches@cygwin.com

Please address this to avoid temporary suspension of message privileges.

cygwin.com Support=20

This message was sent automatically. Please do not reply.
cygwin.comNotification: Messages Awaiting Your Attention Support 2025

--ZIMAFdjssLArtQC2LHKbgqq=_63KQ7XDX8--
