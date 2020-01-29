Return-Path: <cygwin-patches-return-10022-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32556 invoked by alias); 29 Jan 2020 03:08:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32547 invoked by uid 89); 29 Jan 2020 03:08:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-12.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*i:sk:bc7e009, H*f:sk:bc7e009, H*MI:sk:bc7e009
X-HELO: NAM10-MW2-obe.outbound.protection.outlook.com
Received: from mail-mw2nam10on2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) (40.107.94.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jan 2020 03:08:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=N2wBeOnn/sMxdDLmcSD++gFKpt07EXA5q4hN2uiNoHFQ3DveL26jFKjulXOX0GCclxDKHX5gY6Ww9vS6C+I9Fi2pxWJazhlqfEDxEwyFbqghXl6mLsAAO6XotdTU9f80HAl3SEqbYewshFNcLz8IKlgHralSV+FMzcbwh1O3jpBaxF3XK6WfG9AVQh1/i0QgkmVku3mPFYhtxiUr+WPwVmQma4+WHP1OxzDkROnhff7LJGlBLmEfWFBnFVI9Qd+XYA4Th20tc+6TqTbrC3/QUUlyr9OZj12nzAaSRVjZqbSGapZhLgVzVHRAbeGo/fduNcbYxr9oO3uwdFcUEgSk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ZslCAFGqHzRUiufTaflOCu5WuMNzRJ5Bo+wf2gk6AWM=; b=iUeySGAX1mi9i0g++bQqrrGtQz7xFCgbe/fb2OksFmAFjDy8B3XXBMuEYy3fvQiQ/Ak2/YP4iZaxwrJhd1fOPxRvmk0TJv6nvULOOnJMzfbjiiUlcqn9gXfTaeTifRLErfCxtQo1zWLgB5Z9dWakk9nrwaTAM+KCDWgBgjOfwWDBnrbsWzq+ADT06jRehg1S3wK4+Jok3Ud0DrWeWKQwootS3wIkpbm+91rk7+LDNU5h35CwNHTRgmzLr31ftENYr5PhFi1UwU35ZVpA6AuMEczUmUTMU+R8Vc/vQtQqRHqzOauaZolB2cDMqcN1sZWJzuwM6tKfENfpZEvgGzzAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ZslCAFGqHzRUiufTaflOCu5WuMNzRJ5Bo+wf2gk6AWM=; b=OdA+2SZQoVUNalFEBb8dUpQtfTeA3O3/uTQUWXhqKqGnHGLPaGYPbL84WwFePTV3v4S5DrFkqdIjDvGQeYT1myVj4JQYiw1eRY1MS3GgEHbCH8nLW82/LCFv3Vvi/4xZEiAEp0udOGEKeQ6sF5fcffestx0dH9dzE7QgsnT2CWI=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5451.namprd04.prod.outlook.com (20.178.26.89) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19; Wed, 29 Jan 2020 03:08:30 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020 03:08:30 +0000
Received: from [10.13.22.8] (65.112.130.194) by BN8PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:94::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.21 via Frontend Transport; Wed, 29 Jan 2020 03:08:29 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 0/3] Some O_PATH fixes
Date: Wed, 29 Jan 2020 03:08:00 -0000
Message-ID: <c0d1e1da-f50d-a9f8-0148-0518690b906b@cornell.edu>
References: <20200127132050.4143-1-kbrown@cornell.edu> <20200128170651.GG3549@calimero.vinschen.de> <fccbc7cb-0ea5-17b4-0cbb-de44eb21fff6@cornell.edu> <bc7e009a-074c-36e7-e2d2-c4f2c0a045a0@cornell.edu>
In-Reply-To: <bc7e009a-074c-36e7-e2d2-c4f2c0a045a0@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:10000;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: tttdhmInVENDvhe72uHrnbiBj7XtWAjJC9biHQtkCEXCoQu857XxKqZ0whEvkVxCJ1g630ZNhu0lpUm7ImKO9cgqIEbAP7WPxOHDbfn7iXg7YLpj9DAiXabE9QloF9zAJcR8oidipPW5mj5hinKRUw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <65F2B2F17D62E044B89510ECC36D478F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdiK0TOn00YdK8YPehzOsuclN2sto75OpO0G/NoD7305Z8RmSMdTxIdH90Yoj4Ys0GEAv5vTJNnp7zTWUD7Saw==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00128.txt

On 1/28/2020 3:48 PM, Ken Brown wrote:
> On 1/28/2020 2:01 PM, Ken Brown wrote:
>> On 1/28/2020 12:06 PM, Corinna Vinschen wrote:
>>> On Jan 27 13:21, Ken Brown wrote:
>>>> Ken Brown (3):
>>>>      Cygwin: fhandler_base::fstat_fs: accomodate the O_PATH flag
>>>>      Cygwin: fhandler_disk_file::fstatvfs: refactor
>>>>      Cygwin: FIFO::fstatvfs: use our handle if O_PATH is set
>>>>
>>>>     winsup/cygwin/fhandler.h            |  1 +
>>>>     winsup/cygwin/fhandler_disk_file.cc | 24 +++++++++++++++++-------
>>>>     winsup/cygwin/fhandler_fifo.cc      |  8 ++++++++
>>>>     3 files changed, 26 insertions(+), 7 deletions(-)
>>>>
>>>> --=20
>>>> 2.21.0
>>>
>>> Patches are looking good to me.
>>
>> OK, I'll push them.
>>
>>> As outlined on IRC, I found a problem with the ACLs created on new
>>> FIFOs and frixed that (I think).  However, Cygwin doesn't actually
>>> return the real permissions in stat(), only the constant perms 0666,
>>> kind of like for symlinks.  I didn't have time to look into that yet,
>>> but it would be great if we could fix that, too.
>>
>> I'll take a look if you don't get to it first.
>=20
> Two quick thoughts, and then I won't have time to think about this any mo=
re
> until tomorrow:
>=20
> First, I wonder why in fstat_fs we're not using the stat handle (i.e., pc=
.handle()).

Ignore this.  I was confused.

> Second, in the call to get_file_attribute in fstat_helper
> (fhandler_disk_file.cc:478), why do we set the first argument to NULL ins=
tead of
> using our handle?
>=20
> In both cases I don't immediately see a connection with the permissions p=
roblem,
> but it seems inefficient and makes the code confusing.  I might well be m=
issing
> something, however.
>=20
> Ken
>=20
