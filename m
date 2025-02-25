Return-Path: <>
Received: from server9.maghost.ro (server9.maghost.ro [91.213.11.12])
	by sourceware.org (Postfix) with ESMTPS id 941A03858D26
	for <cygwin-patches@cygwin.com>; Tue, 25 Feb 2025 01:00:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 941A03858D26
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=server9.maghost.ro
Authentication-Results: sourceware.org; spf=none smtp.helo=server9.maghost.ro
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 941A03858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=91.213.11.12
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740445258; cv=none;
	b=dizgW8dM8caWDcjNygxngqtA1ePrz9rdE4RmdEFfJpkUf7kmN+pDJyALifdSM+x88RIlBN3wapTio3Qwhzx6WXNG1gIXrI7am75I4QkdeuVdjkCy2yRpGWQfnbheAE5daBoHWDLlFxxBwS6byx59VASg9IVrQoLHsKf08ySgwOo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740445258; c=relaxed/simple;
	bh=egZqt2eTdcr47pBppLXroTr7lDLfxkUOotylxJy2stk=;
	h=From:To:MIME-Version:Subject:Message-Id:Date; b=Vq6P36THsOfSr3j5xaoJQ8/NdjCZWBRWrCSRUbtnzWD4Seu/JU/2kD4SmfWKp2bgjTDvmLQmW5teN6/6dpv0MsSo2OP2d/TOvQx+bvR+uN6dsxzYyOdXckTt4vISQ7C+MD+6WKz/yZdrPZfx70MYQ6a9kKYrG5jQpDds99MfbE4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 941A03858D26
Received: from mailnull by server9.maghost.ro with local (Exim 4.98.1)
	id 1tmjJg-00000000X0U-02JL
	for cygwin-patches@cygwin.com;
	Tue, 25 Feb 2025 03:00:56 +0200
X-Failed-Recipients: cygwin-patches@cygwin.com
Auto-Submitted: auto-replied
From: Mail Delivery System <Mailer-Daemon@server9.maghost.ro>
To: cygwin-patches@cygwin.com
References: <20250225020054.459A92F400213C94@cygwin.com>
Content-Type: multipart/report; report-type=delivery-status; boundary=1740445256-eximdsn-1372809679
MIME-Version: 1.0
Subject: Mail delivery failed: returning message to sender
Message-Id: <E1tmjJg-00000000X0U-02JL@server9.maghost.ro>
Date: Tue, 25 Feb 2025 03:00:56 +0200
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server9.maghost.ro
X-AntiAbuse: Original Domain - cygwin.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - 
X-Get-Message-Sender-Via: server9.maghost.ro: sender_ident via received_protocol == local: mailnull/primary_hostname/system user
X-Authenticated-Sender: server9.maghost.ro: mailnull
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_05,KAM_DMARC_STATUS,RCVD_IN_SBL_CSS,SPF_HELO_NONE,URIBL_CSS_A autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--1740445256-eximdsn-1372809679
Content-type: text/plain; charset=us-ascii

This message was created automatically by mail delivery software.

A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  cygwin-patches@cygwin.com
    Domain profilaxis.ro has exceeded the max emails per hour (125/100 (125%)) allowed.  Message discarded.

--1740445256-eximdsn-1372809679
Content-type: message/delivery-status

Reporting-MTA: dns; server9.maghost.ro

Action: failed
Final-Recipient: rfc822;cygwin-patches@cygwin.com
Status: 5.0.0

--1740445256-eximdsn-1372809679
Content-type: text/rfc822-headers

Return-path: <cygwin-patches@cygwin.com>
Received: from [134.209.241.153] (port=58265)
	by server9.maghost.ro with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <cygwin-patches@cygwin.com>)
	id 1tmjJf-00000000Wug-3JYb
	for cygwin-patches@cygwin.com;
	Tue, 25 Feb 2025 03:00:55 +0200
Reply-To: "Maersk Line" <krakengroups@proton.me>
From: "Maersk Line" <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Bill of Lading Arrival & Inv
Date: 25 Feb 2025 02:00:54 +0100
Message-ID: <20250225020054.459A92F400213C94@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0012_DD84E46D.4AD60761"
X-Exim-DSN-Information: Due to administrative limits only headers are returned


--1740445256-eximdsn-1372809679--
