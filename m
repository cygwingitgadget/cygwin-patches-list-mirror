Return-Path: <cygwin-patches-return-9962-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6351 invoked by alias); 20 Jan 2020 14:57:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6341 invoked by uid 89); 20 Jan 2020 14:57:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-13.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM11-CO1-obe.outbound.protection.outlook.com
Received: from mail-co1nam11on2114.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) (40.107.220.114) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Jan 2020 14:57:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=h2aZakUZgwcYpXI1JOwl6eAukSkbQUQx1MnxnwLE6Ijt4lshY7RJtKWh9f+uZvH0sUK+4I3ZKc8g0v6InckV9Xzh9ycipu4FARCUk6z/Zvl9KGSs9+YoMAcIkGhTu/qPelbt6FmU8RGM5yrt/hvzMKjsEthZ0HR48HyHbN0qHAOC7TtU3IwN/j9UaXzRynCBmmu6ghPYsbPE1APGHYw/LzzqyaNLdszEY9Ipv/BgaW6f9pUUqc13qMf4g3ud2+0JNz8JcU96Dam6cpRemTyX/SlE1+XxBL4l9oeft2qVMtMh4k3jAU/RSIxracrcMO2sN5uyLdvn/puIKEC7MSia0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=UFv5/fZ8iOVA/hrtYb5Y6BHLHS4XwXEcH4WeTEEax4o=; b=nG81Jikc6hzjKqydhn1+QFCveFziWerPvkrrvwIw9LvNYCU/RV4qlR4lq34Jap6bqVjp6rBAkDTdR8hvfV8yQmFKUY86Srx4z5oUZ3N6ID0h4g3mrJwcrPZGG709HYjaynBhxIBqmds12AwKsE8f5iokSJMTO88vmSlzFGyGbJGzi2eepA/9Hewz4C1NVbqRX8KRbCjblza1TYRygzdFsiNsFxL7NYKti6U5yORzSEvLW1hScA9YcXlzv4SEEchy9nqnsDN6Fy21rcnuL6NlHkB4alLbRZiN277vV6kOR1cX1wVelYyNRA04aBEhi1BtjLnqht4Hc1MTx6BLQEAt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=UFv5/fZ8iOVA/hrtYb5Y6BHLHS4XwXEcH4WeTEEax4o=; b=coNQsTQPg47PQh0IeVptlfyPVPTpHUjhPGpK1xohZK7vQ0+Se5bb6ke7t7yvZskwMoAX/xacgMbT/IRNZFTq7Hf8ZQhHUnWpb18CvLiuh6Rpx9zGU+gqbB0AwcEzGr8qvqmvBPbothqZuw91XWX1D0QFQT8rTWEtuttrm/628XQ=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB7099.namprd04.prod.outlook.com (10.186.141.201) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Mon, 20 Jan 2020 14:57:29 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020 14:57:29 +0000
Received: from [10.13.22.8] (65.112.130.194) by BN6PR17CA0002.namprd17.prod.outlook.com (2603:10b6:404:65::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 14:57:29 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v4 0/4] Support opening a symlink with O_PATH | O_NOFOLLOW
Date: Mon, 20 Jan 2020 14:57:00 -0000
Message-ID: <ed4780cb-709a-b130-4221-18974648d584@cornell.edu>
References: <20200117161037.1828-1-kbrown@cornell.edu> <20200120095607.GD20672@calimero.vinschen.de>
In-Reply-To: <20200120095607.GD20672@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:5797;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <8D8AF0381164E54AA4786C74F90F9482@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zG2YKS0u5oswEY8Q8YCr8fvAvjUMcgO46D0Ktmh63cx7i45fo5KjRW8jcaLoAaSvRjtrVElqY3gSpx6soqnupQ==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00068.txt

On 1/20/2020 4:56 AM, Corinna Vinschen wrote:
> On Jan 17 16:10, Ken Brown wrote:
>> Currently, opening a symlink with O_NOFOLLOW fails with ELOOP.
>> Following Linux, the first patch in this series allows the call to
>> succeed if O_PATH is also specified.
>>
>> According to the Linux man page for open(2), "the call returns a file
>> descriptor referring to the symbolic link.  This file descriptor can
>> be used as the dirfd argument in calls to fchownat(2), fstatat(2),
>> linkat(2), and readlinkat(2) with an empty pathname to have the calls
>> operate on the symbolic link."
>>
>> The second patch achieves this for readlinkat.  The third patch does
>> this for fstatat and fchownat by adding support for the AT_EMPTY_PATH
>> flag.  Nothing needs to be done for linkat, which already supports the
>> AT_EMPTY_PATH flag.
>>
>>
>> Ken Brown (4):
>>    Cygwin: allow opening a symlink with O_PATH | O_NOFOLLOW
>>    Cygwin: readlinkat: allow pathname to be empty
>>    Cygwin: fstatat, fchownat: support the AT_EMPTY_PATH flag
>>    Cygwin: document recent changes
>>
>>   winsup/cygwin/release/3.1.3 | 19 +++++++++--
>>   winsup/cygwin/syscalls.cc   | 68 ++++++++++++++++++++++++++++++++-----
>>   winsup/doc/new-features.xml | 19 +++++++++++
>>   3 files changed, 94 insertions(+), 12 deletions(-)
>=20
> This looks good to me.  Please push.  I just wonder if this isn't
> new feature enough to bump the Cygwin version to 3.2...

Maybe.  You're in a better position to judge this than I am.  If you decide=
 to=20
do it, I'll tweak the documentation accordingly.

Ken
