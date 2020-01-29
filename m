Return-Path: <cygwin-patches-return-10025-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72160 invoked by alias); 29 Jan 2020 16:32:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72148 invoked by uid 89); 29 Jan 2020 16:32:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*r:399
X-HELO: NAM12-BN8-obe.outbound.protection.outlook.com
Received: from mail-bn8nam12on2101.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) (40.107.237.101) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jan 2020 16:32:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=TA1tK8LBwjvEw183dEeEElZBcwkBsH8f8wgWSDV9m4z+fEnoNCJPTUfyG3gjUZsfQhwY7HzrjINDmWNycYbaaSOER/IQHU+qPPVmxLvm//p4Yrqe6TLBOnGT1NY0Q1ydish0Zf9ogIX3vBaTjsS1uk9MnxSrNbghHOvvHQDsXtM1cu1imfxUZjWqW1q1OHNNHtLVa1ZvXB2wCXI0BMvEX7Eg/8KyhrC/9jmhSyrbPHTyrQ4X2HOSXAGQOM4xwey9+aRg0ldP7LmJ2iyEkyvIQyYlhL7H3n798BxfNlXXEHUmP+X2lr5TqYdboe3WVGygQ6eSQNm09+FAB6k6F9XX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=voLeIkfQwNbnpi0klHyV0g1EF0ETOTLZizhT1AdDm20=; b=mwGONmyijDAUW+5RHMBwTidtGqHQYJEaSEGJWRPUBqYMAGxj7lMDDTPGgpbgfs89OZumiUXMnJQjQDT8gUH7Wu8aX2T7E5z8zWhhUwL45hLXY2vMaf2oaMUDjN+HPzKcMgWCMlTaE78qRN0pQpF4abI4UKRsdwYDcqBAzhhJTtMpdessC5JDe9h2ICFV/n5JU8OKu7dbzR19Gmge9dEqv2wApZYIIahxn7iR5JS8Blg3G6O+e/35C1vkHKVwVK5Ihza2hlHOXoCazVTwajvH+kosOOYCY5V50T/ntAkCRmdD7jYfsItIc6BS6zdxVZNRai/3zXk/3Mg7rBkjhWhzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=voLeIkfQwNbnpi0klHyV0g1EF0ETOTLZizhT1AdDm20=; b=Fuj+oUdAey1je8lKtoMTOpSCFnHpzBU3Oy0IvIjBbijs2RoQxyzpgGy0uAs74jPnh5GTGukw5CQqG5mkaE1ItImsPELLBPZP3t8jwkr0HclRqLsvshRvvuCPnCCMWe+wPGhwniC9+8o8kI5EEEYXOt3o7kvVgw1kpwm7ihcgPHY=
Received: from BYAPR04MB5735.namprd04.prod.outlook.com (20.179.59.153) by BYAPR04MB6037.namprd04.prod.outlook.com (20.178.235.95) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20; Wed, 29 Jan 2020 16:31:59 +0000
Received: from BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399]) by BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399%5]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020 16:31:59 +0000
Received: from [10.13.22.8] (65.112.130.194) by BN7PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:20::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24 via Frontend Transport; Wed, 29 Jan 2020 16:31:59 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 0/3] Some O_PATH fixes
Date: Wed, 29 Jan 2020 16:32:00 -0000
Message-ID: <e9590c4c-d5ba-6bab-a187-1e5a9e35cd67@cornell.edu>
References: <20200127132050.4143-1-kbrown@cornell.edu> <20200128170651.GG3549@calimero.vinschen.de> <fccbc7cb-0ea5-17b4-0cbb-de44eb21fff6@cornell.edu> <bc7e009a-074c-36e7-e2d2-c4f2c0a045a0@cornell.edu> <c0d1e1da-f50d-a9f8-0148-0518690b906b@cornell.edu> <20200129095234.GJ3549@calimero.vinschen.de> <20200129142240.GN3549@calimero.vinschen.de>
In-Reply-To: <20200129142240.GN3549@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8882;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: FaMRXsmM0Mo3F3+TammajsdEbNQvMpHGSo2wJe9BIDnCf+Q931k1M+ZFif7pbzqHOqLVzKOpojyLEAZCUKCywL2hvg1pl6ygP5uafbcOrnTd5eiXNMvF7/GqP2GWzin/KPr5+v7duuJ9IPBxmyMTdg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0C5F41C988A22B449FCD3C63B8BBBB11@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8GbjSokAuJOFJhRvmnm/iFIERiZg3HAzfoLReDrKaOjs3884EfTQvlcalx7BxqHrI/Q5nGgmNsKcfivyFQVxA==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00131.txt

On 1/29/2020 9:22 AM, Corinna Vinschen wrote:
> On Jan 29 10:52, Corinna Vinschen wrote:
>> On Jan 29 03:08, Ken Brown wrote:
>>> On 1/28/2020 3:48 PM, Ken Brown wrote:
>>>> On 1/28/2020 2:01 PM, Ken Brown wrote:
>>>>> On 1/28/2020 12:06 PM, Corinna Vinschen wrote:
>>>>>> As outlined on IRC, I found a problem with the ACLs created on new
>>>>>> FIFOs and frixed that (I think).  However, Cygwin doesn't actually
>>>>>> return the real permissions in stat(), only the constant perms 0666,
>>>>>> kind of like for symlinks.  I didn't have time to look into that yet,
>>>>>> but it would be great if we could fix that, too.
>>>>>
>>>>> I'll take a look if you don't get to it first.
>>>>
>>>> Two quick thoughts, and then I won't have time to think about this any=
 more
>>>> until tomorrow:
>>>>
>>>> First, I wonder why in fstat_fs we're not using the stat handle (i.e.,=
 pc.handle()).
>>>
>>> Ignore this.  I was confused.
>>>
>>>> Second, in the call to get_file_attribute in fstat_helper
>>>> (fhandler_disk_file.cc:478), why do we set the first argument to NULL =
instead of
>>>> using our handle?
>>
>> The handle is a pipe handle, not the file handle, and the permissions
>> on the pipe handle were not reflecting the permissions on the file.
>> The NULL pointer was trying to make sure that the file gets opened
>> for fetching the security descriptor in get_file_sd().
>=20
> I pushed a fix for the permission problem, but I didn't touch the
> get_file_attribute() call in fstat_helper.  If you think this can
> be further streamlined, go ahead.

I'll take a closer look after I finish the O_PATH implementation for AF_LOC=
AL=20
sockets (almost done).

Ken
