Return-Path: <cygwin-patches-return-9722-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 45976 invoked by alias); 24 Sep 2019 19:28:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 45959 invoked by uid 89); 24 Sep 2019 19:28:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_STOCKGEN,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Spam-Relays-External:sk:NAM01-B, H*RU:sk:NAM01-B, HX-HELO:sk:NAM01-B
X-HELO: NAM01-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr740133.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) (40.107.74.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 24 Sep 2019 19:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=oLOHkALHjwi1GQzBlW9yfyITbFImrX3y+J707cA0hERM9gc/O4DsmOL0hPSFfMUdCH2oOwI4CMKDlXTgV3lVERTmLLhc88BaXJ8WfwUPMcGkZM3yUaTeongvL1XYO4ivKJM6IYrUqQAXwhUpAgzqQ78aGnEUMG6X0dWYYvrnKFld3qeojAjgRh4Xa0sE3QlLhv3EmVuwyTktrbPYDgh/uYQC+6wKY8gaxw2Qb/ekb4XI2GxUbxHEh5xWtrqqJR4J3WuJoliZhC/FAuTMZUM9ZFZR9l/GyiMsOaw0LPuoiobY9Y49s5skBQJ6aJiSAjjGbnJPK88BJiamODvgTV1gnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=QdoU4suE4RRLsV9y79/intnjnlVP59QPzPht+gyBccA=; b=SObDP/mxM1IAW0LCV0borAEQgB6p+t9z4jffMgvjMjNZjyZ1lqdTfDiHkBgqkNLW3m0SyWQyRffnwqA7LX04jwJbpnHRph8jvuU4nXwpxORbqDKytAAbx8iKq0gCAYTOenB6lctwW4AmeTe1YL6byz4BzsO6+2By/1QQjlo4j0CpaqmFbyHkostfOvjE4cqfl1X9csztyqm3leHybPy5ICHgzQp7U/ezlOW4HuFv3K42I8BzRFnBEkDv0zQLqCe7FwYsbXRM3LwVEul3U7vBD6MwLc8gHw7HoB4MycQlg7s06YDZfIV2JxGdfFXMdM91Rni89hCnaEnpnd8hYZAfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=QdoU4suE4RRLsV9y79/intnjnlVP59QPzPht+gyBccA=; b=FmOsrnefyrTkoQVwDQu2dEzQgJlDIcE+PNGs3EwBt3KIoT6DGEYuDdhmgYfDf4GjbOpasPj/xpAdWfABq74TM0qOI0Kll0inJzFU88qvu+Kx9qWSHkUeDHQzuTUDtiSHwdWTB9UnGsvvSDxHIygPJElNs9U7H6Yu41gMcqYwLuw=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB3817.namprd04.prod.outlook.com (20.176.87.10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.25; Tue, 24 Sep 2019 19:28:26 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019 19:28:26 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2] Cygwin: rmdir: fail if last component is a symlink, as on Linux
Date: Tue, 24 Sep 2019 19:28:00 -0000
Message-ID: <b3edf101-b719-0a82-6ad3-54f0c1afc5ad@cornell.edu>
References: <20190924175530.1565-1-kbrown@cornell.edu> <5a1ced2e-ad71-0765-03af-a7bb421acad0@redhat.com>
In-Reply-To: <5a1ced2e-ad71-0765-03af-a7bb421acad0@redhat.com>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 2
x-ms-oob-tlc-oobclassifiers: OLM:3383;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <BE1CA719595B2948AF485239FF30B997@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XW3S5TA3Kz9YCBZG7yP4BQIH4tLeuoMve5yDRB2mahV4CtOmpviLqaEdG9Il2pegkUjhXphmrqa6cJEu82xfQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00242.txt.bz2

On 9/24/2019 2:27 PM, Eric Blake wrote:
> On 9/24/19 12:55 PM, Ken Brown wrote:
>> If the last component of the directory name is a symlink followed by a
>> slash, rmdir should fail, even if the symlink resolves to an existing
>> empty directory.
>>
>> mkdir was similarly fixed in 2009 in commit
>> 52dba6a5c45e8d8ba1e237a15213311dc11d91fb.  Modify a comment to clarify
>> the purpose of that commit.
>>
>> Addresses https://cygwin.com/ml/cygwin/2019-09/msg00221.html.
>> ---
>>   winsup/cygwin/dir.cc | 27 +++++++++++++++++++++++----
>>   1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
>> index b757851d5..0e0535891 100644
>> --- a/winsup/cygwin/dir.cc
>> +++ b/winsup/cygwin/dir.cc
>> @@ -305,15 +305,14 @@ mkdir (const char *dir, mode_t mode)
>>=20=20=20
>>     __try
>>       {
>> -      /* POSIX says mkdir("symlink-to-missing/") should create the
>> -	 directory "missing", but Linux rejects it with EEXIST.  Copy
>> -	 Linux behavior for now.  */
>> -
>>         if (!*dir)
>>   	{
>>   	  set_errno (ENOENT);
>>   	  __leave;
>>   	}
>> +      /* Following Linux, do not resolve the last component of DIR if
>> +	 it is a symlink, even if DIR has a trailing slash.  Achieve
>> +	 this by stripping trailing slashes or backslashes.  */
>=20
> Maybe even "Following Linux, and intentionally ignoring POSIX, do not..."
>=20
>> +
>> +      /* Following Linux, do not resolve the last component of DIR if
>> +	 it is a symlink, even if DIR has a trailing slash.  Achieve
>> +	 this by stripping trailing slashes or backslashes.  */
>> +      if (isdirsep (dir[strlen (dir) - 1]))
>> +	{
>> +	  /* This converts // to /, but since both give ENOTEMPTY,
>> +	     we're okay.  */
>> +	  char *buf;
>> +	  char *p =3D stpcpy (buf =3D tp.c_get (), dir) - 1;
>> +	  dir =3D buf;
>> +	  while (p > dir && isdirsep (*p))
>> +	    *p-- =3D '\0';
>> +	}
>>         if (!(fh =3D build_fh_name (dir, PC_SYM_NOFOLLOW)))
>>   	__leave;   /* errno already set */;
>>=20=20=20
>=20
> Looks okay to me.

Thanks.  Does the "intentionally ignoring POSIX" part apply to rmdir also? =
 I=20
didn't find it easy to decipher POSIX.

Even for mkdir, POSIX says, "If path names a symbolic link, mkdir() shall f=
ail=20
and set errno to [EEXIST]."  See=20
https://pubs.opengroup.org/onlinepubs/9699919799/functions/mkdir.html#tag_1=
6_325.

But I'm not clear on how POSIX decides whether "path names a symbolic link"=
 in=20
the case where the last component is a symlink followed by a slash.

Ken
