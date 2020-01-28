Return-Path: <cygwin-patches-return-10021-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 58787 invoked by alias); 28 Jan 2020 20:48:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 58589 invoked by uid 89); 28 Jan 2020 20:48:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-12.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*i:sk:fccbc7c, H*f:sk:fccbc7c, H*MI:sk:fccbc7c
X-HELO: NAM10-DM6-obe.outbound.protection.outlook.com
Received: from mail-dm6nam10on2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) (40.107.93.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Jan 2020 20:48:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=LA3r16xLSwnog499X2WGAT4aFpSNDqUvYt+ez7TyZGpCVZ9uhE+sUcB1fM6FOuF2ajoDmZRGkdrarz0Bffx0sNifOc3gmp0Hm3PKxr3HBEFr10+1Z5noY5wd56oPRR7sWGAiuAXxYwY488qsF7pYWM/RZriIE2Upz37sJb4wWkba0R3T3bCvZbdV4vHRcScxU2ZEFhwaQmR3XMralkVbFJIZeJ/X/Cg70KN8NLqQYN6lYIQ9KdAn3kypFOyldDJ78QZSwxjJYE5/9FFQTdL0v8oyp5xKVW+QQro25iFOxjZQjMVgi+uz3eFHFOuUgbArLKvuQnPII1KK+xb5T14IYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Qn0QGtqLaHVpRLvImHxCi74rGqtRSfduh907OhPF52s=; b=UZGYJOSQ5vj5l5R6Z8eoIQssj1mK4VkMd3UonAkure3ngx1qeAf4hgVgu2eOfKNJPW65PpZZZ68aJ+9w3wJP6rc9RTDgN4amV/kaqqcM04s1O5CdIAws6mt6kODfUmoHC4/mfn3+ynWMQbA/P7gSbKIdlNqHdFkqGyihfyJ+Li3nkyfcqWZR0MhpWSABEAd51lPzUWCVo23e0JYzQHfkiMCD7TkN7YpAIBNW3SVl+avfHMg151X8d7otDqHx/d/DcS0xIrOGeiEzKTLzpLrONVUXNHy19hAThVGHy/biCEV2zkOMmFeMXswXBNa0utAimQAuDY/HEUcsdwMlDd3xWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Qn0QGtqLaHVpRLvImHxCi74rGqtRSfduh907OhPF52s=; b=cLBep92kOQ2OXFl/tmoKFrJp9vuiV4wxg9o4uq+oSnYAkCycgUaEh0LnuVzAsnhwYI7wdIa2IZ+I6W3by72EltK8QYh7x4Lmpn8Gaa3zISATQlQUoT0WtqSAs5NOhGPpKf/9sym00fWeVDUmuZVQrOnBtf8hOhR5PZULioEojfY=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4988.namprd04.prod.outlook.com (20.176.111.216) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24; Tue, 28 Jan 2020 20:48:08 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020 20:48:08 +0000
Received: from [10.13.22.8] (65.112.130.194) by BN6PR22CA0063.namprd22.prod.outlook.com (2603:10b6:404:ca::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend Transport; Tue, 28 Jan 2020 20:48:07 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 0/3] Some O_PATH fixes
Date: Tue, 28 Jan 2020 20:48:00 -0000
Message-ID: <bc7e009a-074c-36e7-e2d2-c4f2c0a045a0@cornell.edu>
References: <20200127132050.4143-1-kbrown@cornell.edu> <20200128170651.GG3549@calimero.vinschen.de> <fccbc7cb-0ea5-17b4-0cbb-de44eb21fff6@cornell.edu>
In-Reply-To: <fccbc7cb-0ea5-17b4-0cbb-de44eb21fff6@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:10000;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: 0jxBgNq25VRKIFc9yfy2BLiV3EuFXwL7K0wudO9JJ2HqsdTNL2p7Q4t89bpmiPhz10CqSpMU/lLCDiWWJcvkDPCLtgx+LxauxqJgtoYsOFcrh/4Ud8wlp7TI8t79MkO+6SNlYM6rJc0h1nDwphmJlA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4F8F2D39AE8A6F4A9CB9F61E0EBFC1C7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L064n8e6Hpz2b+1YHb7Kg+KzCt+LpMyvhL1ZijMrw2LaHRBZ6V4imrQRNWXrMid+BnLQ6EhrKaiSRegffjvX3g==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00127.txt

On 1/28/2020 2:01 PM, Ken Brown wrote:
> On 1/28/2020 12:06 PM, Corinna Vinschen wrote:
>> On Jan 27 13:21, Ken Brown wrote:
>>> Ken Brown (3):
>>>     Cygwin: fhandler_base::fstat_fs: accomodate the O_PATH flag
>>>     Cygwin: fhandler_disk_file::fstatvfs: refactor
>>>     Cygwin: FIFO::fstatvfs: use our handle if O_PATH is set
>>>
>>>    winsup/cygwin/fhandler.h            |  1 +
>>>    winsup/cygwin/fhandler_disk_file.cc | 24 +++++++++++++++++-------
>>>    winsup/cygwin/fhandler_fifo.cc      |  8 ++++++++
>>>    3 files changed, 26 insertions(+), 7 deletions(-)
>>>
>>> --=20
>>> 2.21.0
>>
>> Patches are looking good to me.
>=20
> OK, I'll push them.
>=20
>> As outlined on IRC, I found a problem with the ACLs created on new
>> FIFOs and frixed that (I think).  However, Cygwin doesn't actually
>> return the real permissions in stat(), only the constant perms 0666,
>> kind of like for symlinks.  I didn't have time to look into that yet,
>> but it would be great if we could fix that, too.
>=20
> I'll take a look if you don't get to it first.

Two quick thoughts, and then I won't have time to think about this any more=
=20
until tomorrow:

First, I wonder why in fstat_fs we're not using the stat handle (i.e., pc.h=
andle()).

Second, in the call to get_file_attribute in fstat_helper=20
(fhandler_disk_file.cc:478), why do we set the first argument to NULL inste=
ad of=20
using our handle?

In both cases I don't immediately see a connection with the permissions pro=
blem,=20
but it seems inefficient and makes the code confusing.  I might well be mis=
sing=20
something, however.

Ken
