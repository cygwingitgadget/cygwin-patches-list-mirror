Return-Path: <cygwin-patches-return-9976-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35214 invoked by alias); 22 Jan 2020 21:37:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35197 invoked by uid 89); 22 Jan 2020 21:37:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-13.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:2148, hadn't, hadnt
X-HELO: NAM12-BN8-obe.outbound.protection.outlook.com
Received: from mail-bn8nam12on2101.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) (40.107.237.101) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 22 Jan 2020 21:37:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=jNH8bD362Pr8DwLbu5S5NcX0jZWDaVXNUz3uKt3S/2YIkv3KPX9up4QFTydxUvOF6ptJrZxD/+IWJkFuVk2fful+httgPDfDeO8vEj4Fc0yMH5nEWfi3UqGy3Yk9xi6Wl7kUlEY3oi3n2YDEUcVthYkie7j0m/DV6pfgdkxXfwnCiZi65SFz6tksRgpi1WxY2J0SZMETgUT1ccoNhZP/swSHK01rzo/rYS7FQJ0XGMKhOf0m+WRlSL3DBXathZwA9Umy4u5peGck5r934EQ3xY2q9TMjvxv1F0BB+I7/iZEXQ+sTbAdT8sJOTmj1N1uq09L0IEdsV7mR3chWfEp75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=MeBcoA03a1d/0vtMPp7vGkXLYbxXKYZxHswJEnKZLBQ=; b=HW75hHq9XrfQ3wE3lWKp4ReQW/iHwDyf996f4lNViwYb48wtTkj6yhBxbIw/WefZultN3C2REUeJj/sFSzwSYWtUOTABs6eI63PuO0BjEdvwOImDTyzAy6f1nfaUbzPpOFQ9s1WfK33eysTXHsukxpj+8Y4+eQpTlCDvbBKgiAhITBDQOGwCRQYlGQJntsj0tR7zkJTRGzhFEGo9yl1WS7QfhQGalh4hEYNzMapjyZQQyGDoOn8zFYvrOt2UtYet/Rp2fev3RXQd+PbH9yMAOa5QX0pnZ7HF5ty0ywZAm61d+cmXxkmUX3uX44Gb6AhabYf1xSNWA31CyNd+Gj5PXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=MeBcoA03a1d/0vtMPp7vGkXLYbxXKYZxHswJEnKZLBQ=; b=IiqVtnVwqPSpI35m3HapJpRGJw5Y+IigqTihKLyY5udcs2ffKcLwYghY3bB8zMBa9yYfqSwK6LftAaZK2lSVXtrxO4uWcLxAwnydmQPd8toO1S8Y9XphmUIyOwNW0P9tDmBnIyPWtZpjpbk28ZHtIJ/dDumAYGPxjW4dIhlYCGA=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5980.namprd04.prod.outlook.com (20.178.228.14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Wed, 22 Jan 2020 21:37:22 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020 21:37:22 +0000
Received: from [10.13.22.8] (65.112.130.194) by BN4PR11CA0022.namprd11.prod.outlook.com (2603:10b6:403:1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend Transport; Wed, 22 Jan 2020 21:37:21 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: allow opening an AF_LOCAL/AF_UNIX socket with O_PATH
Date: Wed, 22 Jan 2020 21:37:00 -0000
Message-ID: <e0b5d8b4-02b0-9044-b033-760351b451a6@cornell.edu>
References: <20200116183355.1177-1-kbrown@cornell.edu> <20200117094826.GC5858@calimero.vinschen.de> <20200117095104.GD5858@calimero.vinschen.de> <f94efc8e-28d3-fd68-d6e4-a092637cf6e8@cornell.edu> <20200120093541.GC20672@calimero.vinschen.de>
In-Reply-To: <20200120093541.GC20672@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:1107;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <DC6EC67A2DD55A43903C008CBFF1E12D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKB5125c79Y7m9c+KlTXkA18vH45Ux8LpkPdg25Jikk5FMwBlZoCVi2gKbtp7Vk+rmJRBRVnW6+BtxG7WCLAWA==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00082.txt

On 1/20/2020 4:35 AM, Corinna Vinschen wrote:
> On Jan 19 20:25, Ken Brown wrote:
>> On 1/17/2020 4:51 AM, Corinna Vinschen wrote:
>>> On Jan 17 10:48, Corinna Vinschen wrote:
>>>> On Jan 16 18:34, Ken Brown wrote:
>>>>> If that flag is not set, or if an attempt is made to open a different
>>>>> type of socket, the errno is now EOPNOTSUPP instead of ENXIO.  This is
>>>>> consistent with POSIX, starting with the 2016 edition.  Earlier
>>>>> editions were silent on this issue.
>>>>> ---
>>>>>    winsup/cygwin/fhandler.h               |  2 ++
>>>>>    winsup/cygwin/fhandler_socket.cc       |  2 +-
>>>>>    winsup/cygwin/fhandler_socket_local.cc | 16 ++++++++++++++++
>>>>>    winsup/cygwin/fhandler_socket_unix.cc  | 16 ++++++++++++++++
>>>>>    winsup/cygwin/release/3.1.3            |  7 +++++++
>>>>>    winsup/doc/new-features.xml            |  6 ++++++
>>>>>    6 files changed, 48 insertions(+), 1 deletion(-)
>>>>
>>>> I'm a bit concerned here that some function calls might succeed
>>>> accidentally or even crash, given that the original socket code doesn't
>>>> cope with the nohandle flag.  Did you perform some basic testing?
>>>
>>> Iow, do the usual socket calls on a fhandler_socket_local return EBADF
>>> now?  Ignoring fhandler_socket_unix for now.
>>
>> I really hadn't thought this through very well.  I think the following
>> additional patch should do the job:
>>
>> --- a/winsup/cygwin/net.cc
>> +++ b/winsup/cygwin/net.cc
>> @@ -67,6 +67,11 @@ get (const int fd)
>>
>>      if (!fh)
>>        set_errno (ENOTSOCK);
>> +  else if (fh->get_flags () & O_PATH)
>> +    {
>> +      set_errno (EBADF);
>> +      fh =3D NULL;
>> +    }
>>
>>      return fh;
>>    }
>=20
> Looks like the easiest solution indeed.

It turns out that some further tweaks are needed, so it may be a while befo=
re a=20
finish this.  And in the course of working on it, I discovered that I was=20
careless when I attempted to support O_PATH for FIFOs in commit aa55d22c.  =
So=20
I'll be sending a fix for that shortly, along with a test program, and then=
 I'll=20
return to the socket case.

I *think* what I did for symlinks is OK as it stands, but I'll recheck that=
 too=20
with a suitable test program.

Ken
