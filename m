Return-Path: <cygwin-patches-return-9921-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123824 invoked by alias); 13 Jan 2020 16:56:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123809 invoked by uid 89); 13 Jan 2020 16:56:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM11-DM6-obe.outbound.protection.outlook.com
Received: from mail-dm6nam11on2095.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) (40.107.223.95) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 16:56:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=lsjvVh/YSDnvS7EHFfFE/bz8LSEYIjRpsR4vEURBDLP7vpq4Ep2LH25VUZANruBZLt1dxxWs1vNVFRxZ8o8fJEceXPVIwl0C/2UeOi9+Ww7YHgJzAFOnLZlKCbV77WBq6rsbVaa4EF3uRFD2EmNdnZmY41mFDSpEoW2itPcgjfYqmj/XylrLIKtVOPvtQ8OdQSX4KScQ+IoGjBYiAftdR5XpyhPQKBiW9IWcHMUg+07G60EhHiY46V+Yn2LzEbaPOZ0NiLAwjRsPEZFAV7pc9fiTLxMckygK8Bv+AAlyiEdW2ZW7eObMRdlIGWuw+nYG24BdVT6z0DXw3YiEBYAQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=xkTWFzFWz6S0m/1dFnzQ7hf8ACOzEP1cjS7wYGcA6kw=; b=H/ShgSCj8A1SaSv/3SOMuqk504xjlqfizQJaJwqNyneNrPcx9vmKdX5dG+R+fCNryyZ896agI24qeMnS/Ind/YxYutkL0SVM7+rObA844EptTi0NEFjSdZgnSpQxVxtdAbGfFk/2nDvSDzxX4j9lgVgay0eVlpH9nzAL7LtIiVwdg0rplGj0mKu5UxS5+/F63dvtKBizsv9bhCKE5I5kYkMJBhh+UuuW+SibmtG4D0Ywer1MOdwos5EiW2/lDzC472qcYw/9hlcS+CNyUrcyVI5pUczleEnZmLpJQIU7oYUqjvA568t1gAWG5tAjZ9umIHsCq7h1iAXy8jzD2zvsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=xkTWFzFWz6S0m/1dFnzQ7hf8ACOzEP1cjS7wYGcA6kw=; b=CvYxu8KDFssepinLDY7V8tYGRAw9bhhuNbnILdvhL5TgdWEm2tCIub19nV6O2VQJYk74kAG02reUfjfu68clsd7274kRbve4ymXbEYQZ/v5F3wesWzv7VI/wYKr6/cjoqiF23sfppGtnJP1is6lEhFHl9mbEGfWamVoYdtv6YLk=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6362.namprd04.prod.outlook.com (10.141.161.142) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8; Mon, 13 Jan 2020 16:56:13 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2623.017; Mon, 13 Jan 2020 16:56:13 +0000
Received: from [10.104.13.193] (63.148.235.187) by MN2PR22CA0011.namprd22.prod.outlook.com (2603:10b6:208:238::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend Transport; Mon, 13 Jan 2020 16:56:12 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: fhandler_socket::open: support the O_PATH flag
Date: Mon, 13 Jan 2020 16:56:00 -0000
Message-ID: <80e15aee-b4c6-7e40-a4ce-dc8b216655ab@cornell.edu>
References: <20191226152524.10816-1-kbrown@cornell.edu> <20200113153152.GF5858@calimero.vinschen.de>
In-Reply-To: <20200113153152.GF5858@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.3.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:3826;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4519E012592B6D49A4A89E2C16A5F42F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8Gq3w2DnvKd6Nou6pw/i3Y/dCHXI7AIbV3PRgsEwlADOqnFWvQJ5AUI+ufo754FWj1KED16hYjdWzHLQ/mjQA==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00027.txt

On 1/13/2020 10:31 AM, Corinna Vinschen wrote:
> Hi Ken,
>=20
> On Dec 26 15:25, Ken Brown wrote:
>> If that flag is not set, fail with EOPNOTSUPP instead of ENXIO.  This
>> is consistent with POSIX, starting with the 2016 edition.  Earlier
>> editions were silent on this issue.
>> ---
>>   winsup/cygwin/fhandler_socket.cc | 13 +++++++++++--
>>   winsup/cygwin/release/3.1.3      |  5 +++++
>>   winsup/doc/new-features.xml      |  5 +++++
>>   3 files changed, 21 insertions(+), 2 deletions(-)
>>   create mode 100644 winsup/cygwin/release/3.1.3
>>
>> diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_s=
ocket.cc
>> index 9f33d8087..4a46d5a64 100644
>> --- a/winsup/cygwin/fhandler_socket.cc
>> +++ b/winsup/cygwin/fhandler_socket.cc
>> @@ -269,8 +269,17 @@ fhandler_socket::fcntl (int cmd, intptr_t arg)
>>   int
>>   fhandler_socket::open (int flags, mode_t mode)
>>   {
>> -  set_errno (ENXIO);
>> -  return 0;
>> +  /* We don't support opening sockets unless O_PATH is specified. */
>> +  if (!(flags & O_PATH))
>> +    {
>> +      set_errno (EOPNOTSUPP);
>> +      return 0;
>> +    }
>> +
>> +  query_open (query_read_attributes);
>> +  nohandle (true);
>> +  set_flags (flags);
>=20
> Shouldn't that only work with AF_LOCAL/AF_UNIX sockets?  This looks
> like it will return a valid descriptor even for IP sockets.

Thanks for catching that.  I'll fix it.

Ken
