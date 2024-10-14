Return-Path: <>
Received: from ws268.win.arvixe.com (ws268.win.arvixe.com [143.95.254.78])
	by sourceware.org (Postfix) with ESMTPS id 8733D3858C5F
	for <cygwin-patches@cygwin.com>; Mon, 14 Oct 2024 09:11:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8733D3858C5F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=systemelements.com
Authentication-Results: sourceware.org; spf=none smtp.helo=ws268.win.arvixe.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8733D3858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=143.95.254.78
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1728897089; cv=none;
	b=R/SwYW9b3Sm+BOAb2vdRGVTo/ldyTR+aasim1V6URDYbGJAvlxb6t36pC0GBwPzcF3eRSslbqlkfakTzHhmPvXO+MLLuVX0CtFhIPuiV2JCpyqrIHPOB/AI75fL16+nea7Qg4NUj7FV8OTOoFgqj1F0pvAaXxbAfLWbzDrwZvPw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1728897089; c=relaxed/simple;
	bh=UoKVA7kQkdM6YkhRRYIzX6jTLZjfDt/jVMFGQ7YSI4k=;
	h=From:Date:Subject:Message-Id:To:Message-Id:MIME-Version; b=fSFZVTMgSb+j25LrIQIAcNYKQn9M5SNx82HuF5Om7LCFc7tM1apRTbxCaiNpo+bd8SYN8Ey/5pFrpfKppYfjoBntrkoWZ8ikwLmJZeDZejGoLyJIX0Xv7A7nZiuwmPOUcBlXRncgWAI0aRphA3X8gg/LxWfO8IGBY7bm/MsdonQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
From: System Administrator <noreply@systemelements.com>
Date: Mon, 14 Oct 2024 04:09:12 -0500
Subject: Failed: FREE Weekly Health e-Letter Signup: from * * *
 =?utf-8?b?8J+Ppw==?= Get Free Bitcoin Now! Click Here:
 https://ftbtrans.com/files/fk2s15.php?hym96uy =?utf-8?b?8J+Ppw==?= * * *
 gbacc2 at 10/14/2024 4:08:25 AM
Message-Id: <05L9HB7OCOU4.1CU8F1AVCHSM1@ws268>
X-SmarterMail-SMTP-ID: 31720578
X-SmarterMail-Delivery-ID: 19679941
X-SmarterMail-MessageType: Bounce
To: pmorrison@systemelements.com
Message-Id: <f64d7f442f234c19b898b031a15fe369@outlook.com>
X-Origin-Domain: outlook.com
In-Reply-To: <7d88e919c1ab443d9bb2feebe7ef9f73@30c833aada1246168c9c5c63347b3680>
References: <7d88e919c1ab443d9bb2feebe7ef9f73@30c833aada1246168c9c5c63347b3680>
MIME-Version: 1.0
Content-Type: multipart/report;
	boundary=SmarterMail_NextPart_14b765e9b764405892ca66d81d59a17d;
	report-type=delivery-status
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_05,HTML_MESSAGE,HTML_NONELEMENT_30_40,KAM_DMARC_STATUS,LIKELY_SPAM_FROM,PLING_QUERY,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--SmarterMail_NextPart_14b765e9b764405892ca66d81d59a17d
Content-Type: multipart/alternative;
	boundary=SmarterMail_NextPart_a448389ddecb420590d7e3d16c24034a

--SmarterMail_NextPart_a448389ddecb420590d7e3d16c24034a
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Delivery has failed to these recipients:

netdev@outlook.com

Subject: FREE Weekly Health e-Letter Signup: from * * * =F0=9F=8F=A7 Get Fr=
ee Bitcoin Now! Click Here: https://ftbtrans.com/files/fk2s15.php?hym96uy =
=F0=9F=8F=A7 * * * gbacc2 at 10/14/2024 4:08:25 AM

Remote Server returned: '550 0H6Pt8cJtSAO30H6QtVGna -  message rejected AUP=
#SNDR'=

--SmarterMail_NextPart_a448389ddecb420590d7e3d16c24034a--

--SmarterMail_NextPart_14b765e9b764405892ca66d81d59a17d
Content-Type: message/delivery-status

Reporting-MTA: dns;ws268.win.arvixe.com

Original-Recipient: rfc822;netdev@outlook.com
Final-Recipient: rfc822;netdev@outlook.com
Action: failed
Status: 5.0.0


--SmarterMail_NextPart_14b765e9b764405892ca66d81d59a17d
Content-Type: text/rfc822-headers
Content-Disposition: attachment

X-Source-Cap: ZHJtb3JyaXNvbjtkcm1vcnJpc29uO21lZHhmbG93LmNvbQ==
X-Email-Count: 1
X-Source-Auth: drmorrison@medxflow.com
X-Local-Domain: Yes
X-Exim-ID: 1A2MTkJkjgaeub-xG5ey-17tKsH9Ug6
Return-Path: <cygwin-patches@cygwin.com>
Received: from ws268 (ws268.win.arvixe.com [143.95.254.78])
	by ws268.win.arvixe.com with SMTP; Mon, 14 Oct 2024 04:08:25 -0500
MIME-Version: 1.0
From: cygwin-patches@cygwin.com
To: drmorrison@medxflow.com, drmorrison@medxflow.com
Date: Mon, 14 Oct 2024 04:08:25 -0500
Subject: FREE Weekly Health e-Letter Signup: from * * * =?utf-8?b?8J+Ppw==?=
 Get Free Bitcoin Now! Click Here:
 https://ftbtrans.com/files/fk2s15.php?hym96uy =?utf-8?b?8J+Ppw==?= * * *
 gbacc2 at 10/14/2024 4:08:25 AM
Message-Id: <7d88e919c1ab443d9bb2feebe7ef9f73@30c833aada1246168c9c5c63347b3680>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64


--SmarterMail_NextPart_14b765e9b764405892ca66d81d59a17d--

