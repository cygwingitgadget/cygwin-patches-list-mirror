Return-Path: <cygwin-patches-return-9838-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89934 invoked by alias); 12 Nov 2019 19:53:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89924 invoked by uid 89); 12 Nov 2019 19:53:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:8736eso, H*MI:sk:8736eso, H*i:sk:8736eso
X-HELO: nihcesxwayst03.hub.nih.gov
Received: from nihcesxwayst03.hub.nih.gov (HELO nihcesxwayst03.hub.nih.gov) (165.112.13.34) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 12 Nov 2019 19:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;  d=nih.gov; i=@nih.gov; q=dns/txt; s=NIH; t=1573588382;  x=1605124382;  h=from:to:subject:date:message-id:references:in-reply-to:   content-transfer-encoding:mime-version;  bh=wNxs6HoVVq0zoPcKWAiQk2otqKh8eW10FaU/lerMT0A=;  b=pcidQNroHLZIguX+Vx38STPUbsVpDvGFAxGY7Ze81F1JSsQA3V/D8KH8   zROozVyzSpn+4pMLmtdtBq3Cr0/pl2+yDq15/Rbc2vh2PVu9oUVMTAPEf   /Ippg9XJ6YOo81uzjg8VGB5L6REwfQbHwtIBTjJwoB8wDVU33+vrZ0F/y   NhxVIzCQnXmXgR5NLhKWA4XtMrefJJtdkIXMPK3WCQn+6pZbbTYudYSB0   lkfKPQ+L0XoaKAKSc6O4dSmtZUKgJsyhT/fYhW3JqDTR7f61rqqJ28MqL   LA4Fsgz8xBaYDymxB9Lz+Ia7yc3xCO/k8HJtpiVdzATyuvDFYASTPWGAz   A==;
IronPort-SDR: gGFdUxhn9xQbYGTQ2qCx4/TAS3IClOQOLKKI3PgQevsUS4WIyi7ptOxN5BmcDPey6REZOLymuC Mn5PHyGjnxmw==
Received: from uccsx03.nih.gov (HELO ces.nih.gov) ([165.112.194.93])  by nihcesxwayst03.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 12 Nov 2019 14:53:00 -0500
Received: from uccsX02.nih.gov (165.112.194.92) by uccsX03.nih.gov (165.112.194.93) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov 2019 14:52:59 -0500
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (165.112.194.6) by uccsX02.nih.gov (165.112.194.92) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend Transport; Tue, 12 Nov 2019 14:53:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Lejv/ocGQ2PURmZfqZF+Rw3/3ZR3Oz4fP/I1LLJ8cEvEf+0AJrVDgKYGSgE2kDEySj0VknoGtq6wIXANUaAaC/Kb5BHRf3Q/NRHMCyBWAjYzNyEMlkAytX1sAkqdIIvyK+SJBGjbxjZtjd1Ut/OLSgc7Lfkx5lzezvdnYThVNqXf/wL8Py1YCTu7fHWHAtlFGIek13GbSls+VVlrHNHDeT9zPwRQ5ShtHHQMVNolwKzDZqk3GS1g0+x9ng4SccU/rpLAWPwv/dKasRt19ZJyFOIJF7eCna/+EA4mKzq5K7aZCcVv9YBdi5oyPIivo3JSvyNZcU2dJ8TtyvcbDOs2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=wNxs6HoVVq0zoPcKWAiQk2otqKh8eW10FaU/lerMT0A=; b=XtaQvwB7hqJ77bM+bNHKyk4yjymgArqARuzteHZhAIj9d0Cp5HdG+nauVVVpMBZN99zPKNrYsWOBt5d0tnjubfiItKKLqjnFWRuqdKAB0LIKsFiSZ4OAi8xnqRf26tCHIyB2fOwI9nbffaDenf6QQSLgX2ofVedO+kIPGxkVNFQmJHvmiub2rPBXFe6b1M/ULveo92S/oeyh7zZe71NpJRJB8VfFA6ccJqxRm59JBvR2yLlPOaYefOYsq8VWGiz4F+K5RPxyx5mUeQT726C+2DRlYRiYDSUfusUhy9DuggUY95cU8yp/0fujKdzovUjqMQSjPIbPDeIBuCX/zaD7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nih.onmicrosoft.com; s=selector2-nih-onmicrosoft-com; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=wNxs6HoVVq0zoPcKWAiQk2otqKh8eW10FaU/lerMT0A=; b=pAPfKWL2FWRVmjBmaHtXBuTJ8dPaKyKRSqE4eSE96/uSf+4nabv4adbEpajfHqmhf46xbbTrG4lVV1UPTMWWBYahatEPjUElR4LbLzneLp7Eox0RdWxJ8br6//2e6GxgMWSwyLYdWQu1mBeN9UuAwA8feoQHXkq4MSJSOiWAd9g=
Received: from MN2PR09MB3983.namprd09.prod.outlook.com (52.132.174.141) by MN2PR09MB3965.namprd09.prod.outlook.com (52.132.172.96) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Tue, 12 Nov 2019 19:52:59 +0000
Received: from MN2PR09MB3983.namprd09.prod.outlook.com ([fe80::58e8:d488:497a:428d]) by MN2PR09MB3983.namprd09.prod.outlook.com ([fe80::58e8:d488:497a:428d%7]) with mapi id 15.20.2430.020; Tue, 12 Nov 2019 19:52:59 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C] via cygwin-patches" <cygwin-patches@cygwin.com>
Reply-To: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: cygrunsrv patch
Date: Tue, 12 Nov 2019 19:53:00 -0000
Message-ID: <MN2PR09MB3983757C7386E83D9964A098A5770@MN2PR09MB3983.namprd09.prod.outlook.com>
References: <MN2PR09MB398333C47F420E68A5E95E93A5770@MN2PR09MB3983.namprd09.prod.outlook.com> <8736esoozx.fsf@Rainer.invalid>
In-Reply-To: <8736esoozx.fsf@Rainer.invalid>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=lavr@ncbi.nlm.nih.gov;
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOolh0usqvLqPV+Xoppc669Lrq9H1IoNm69l32uy3t7Rlb5kS5ZP9DkP1t1P1sOq
Return-Path: lavr@ncbi.nlm.nih.gov
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00109.txt.bz2

> git://sourceware.org/git/cygwin-apps/cygrunsrv.git

Thanks, that worked.  I was using a static source archive (cygrunsrv-1.62) =
to make all the changes, so didn't need git until now.
