Return-Path: <cygwin-patches-return-10020-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123246 invoked by alias); 28 Jan 2020 19:01:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123145 invoked by uid 89); 28 Jan 2020 19:01:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-12.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM02-CY1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr760124.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) (40.107.76.124) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Jan 2020 19:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=S0WAWTaai1q3yKusmACrIU8KbBxI2/pxgaeKMlb5Bj+QyDT8/y7GRSZ4MwJtJ+dDiXBvTwgb0NIp5xJJdQoHHiuES1SYBjFphZTzfd9h6hnEgYLcpXbplHRIQYX1WaNlDUWwJNhWirMwAEKX76cqV9HPdKxCaaVIqIHDUtcJdd/iF9aGaAgr9pqByW7ZBmLaiykpRTGDON+MsgSRadM+gFQm1RW+lHdvji4zqOIS9S1N+Co6XWo4UacaOSTchqJwAsg6Bvk1SlWWgYDOC/+CYCtsvPdsrXC/F9PpyheaCZzUuRWlSfSk5cKmr5zh8gh18ZzCz8SuwwgXPgtzoChA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=S7CSRIJZi8cSVlcd2KKigZeqfkJyKczPmOakz+5Y9oI=; b=SK6KKGxXEbpi6UP9x4nerGUOPF310LauYDjMkkFbNoPhGxC56fhetDPpd6krAD6Awp+9v541EDiFeb5hH2lVV+elKNw0O+JVgt0bheZ5PKPlL2eeE8qzchWIkLmkS4rEb7uehXx9T/STOlNe0u5+iJtDX3MyuVQWxKvsd55Rqi6i94wDv2vmeP5M2qDWbqCNcNVTSmEmxHRvIXarLdrtubMoQWycKYtd8gb87edf+cPlmnYurItHiIeiF48PueHvPsmzCiLQO3LqkliU58yKO7OOoKqm3dgWkZ8WIfjFWp9H/cYXG+Rv27XnG1STF9mtAVHJbRXjJn2+myzaC2gu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=S7CSRIJZi8cSVlcd2KKigZeqfkJyKczPmOakz+5Y9oI=; b=QM+cB+Cq/Qn49tigEY8157ZtPfEnfQjhmh4PfXuWN92fqyE+pqWw0NX+ir2E3oEWBmZzYNQOMjtnkwubtrd+iZI1Cz9U1BtL/x9IQArT+FVisckd/2x2uiAC7Dxv3lNm1I8t8/rwYRfIVi5HqM3EyiUXWDwF0ieHQvL548lJQEk=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB3913.namprd04.prod.outlook.com (20.176.86.158) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24; Tue, 28 Jan 2020 19:01:41 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020 19:01:41 +0000
Received: from [10.13.22.8] (65.112.130.194) by BN7PR02CA0018.namprd02.prod.outlook.com (2603:10b6:408:20::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Tue, 28 Jan 2020 19:01:40 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 0/3] Some O_PATH fixes
Date: Tue, 28 Jan 2020 19:01:00 -0000
Message-ID: <fccbc7cb-0ea5-17b4-0cbb-de44eb21fff6@cornell.edu>
References: <20200127132050.4143-1-kbrown@cornell.edu> <20200128170651.GG3549@calimero.vinschen.de>
In-Reply-To: <20200128170651.GG3549@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: qWaSumPVdPeXpeTW3RXrtre8RDOZB/d389vD/NS/zwUO04HZTlGArgC3EFACQUK3QSxd7EJMNBvPbiVxOjWxjTT66wtjGRglog2eXlhfCHEUEGCr9sy5qsgDRVYqRUHOCdmqLCZ5rXf+jQVkHax9Xg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FBE22AC90D9E6848ADE802D22BD28888@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRVvbszSbRRqe4PcxHsoo9wBP8F6drjUPRU/Zid6rPdzUijDjppOMe7rxz3RcxGertkmuxCuDYZ6QpLOi4rG/g==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00126.txt

On 1/28/2020 12:06 PM, Corinna Vinschen wrote:
> On Jan 27 13:21, Ken Brown wrote:
>> Ken Brown (3):
>>    Cygwin: fhandler_base::fstat_fs: accomodate the O_PATH flag
>>    Cygwin: fhandler_disk_file::fstatvfs: refactor
>>    Cygwin: FIFO::fstatvfs: use our handle if O_PATH is set
>>
>>   winsup/cygwin/fhandler.h            |  1 +
>>   winsup/cygwin/fhandler_disk_file.cc | 24 +++++++++++++++++-------
>>   winsup/cygwin/fhandler_fifo.cc      |  8 ++++++++
>>   3 files changed, 26 insertions(+), 7 deletions(-)
>>
>> --=20
>> 2.21.0
>=20
> Patches are looking good to me.

OK, I'll push them.

> As outlined on IRC, I found a problem with the ACLs created on new
> FIFOs and frixed that (I think).  However, Cygwin doesn't actually
> return the real permissions in stat(), only the constant perms 0666,
> kind of like for symlinks.  I didn't have time to look into that yet,
> but it would be great if we could fix that, too.

I'll take a look if you don't get to it first.

Ken
