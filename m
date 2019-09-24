Return-Path: <cygwin-patches-return-9719-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 99608 invoked by alias); 24 Sep 2019 17:42:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 99597 invoked by uid 89); 24 Sep 2019 17:42:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=Following
X-HELO: NAM03-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr780098.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) (40.107.78.98) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 24 Sep 2019 17:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=eggKjRlOz7+dzo+12QnDEpeSvxP95cpcJQiQqKllMNCKc6Do9D7D8GmwDx2AAcdONyHwNfM4uhjRCMwG70qM5GPc8nrLIqP9U9GYYpBSdEIwF5svdhrYJoX8ZqSWzXJLmwSD484WZTkm0QthHNBJMeaszbihT+ZaE6qGOZjMb+40P82zvqHSTduSqHxndjksslfs1XG4saRx6hWAlXt41y2ltW6vN049OlYnaAbDF5SkS2BKDUFDUrUT/UP6l0gYGLo+TxRbPy5FLgUT3Mu1klTNUknXx9I9WrB0R/jqgnV0X56L3xwIA2GeLK9Ua70gU2HiGMrSi9LIgnhm7+1OLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=cheOb1Cz3ADpp+FqYVI/Z4IqJmuWQeLQ0Q0mvL7nSwo=; b=RxclkFb8YB/WtkrmfL4QjEiBhikuBO5jpAb/R7LIMKE3WtC2BSdLDEqsoezHPN6r9XMN7GZAbar/tIhdK8RsvYOUxAgs6GtCXzYtApIzPRb1I3/TFKACKfRAdouKYPCCBGdS3ylgRa7RS4cK2rZnZbCVCuWgU0bKvuHcf332aRkEkFA9i7JbpB/X7rOXv8o+tOTrIJFT1Cbn9aYOHK/e1m2arS1Ztbwn2VPFW8VBLt37V/T9u3e/zRyyIvUZHw6xsdHYN9GGPYPgKBUBIhs2QzAvpwmEZkqsodWs0AgnueRPnRz+PdLCce5/uYrI7AUgzedSWXVpTMvYx3QbGrRWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=cheOb1Cz3ADpp+FqYVI/Z4IqJmuWQeLQ0Q0mvL7nSwo=; b=C5Sr7t6t3H09ArW+EdKIGMQeuEVGxY/N9Wb1WvCg9HzvcvC2vnAgMIqFGNqSFk346BIUsnX21apawiSqM/oo262wUTxv3L7b3FGaniLSYfmmf+oLXlWFgs9lep7LvC8qN8h4sKns5urTJdJtA6XznNYa9cdlyy7psk+Oso/IWOc=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4972.namprd04.prod.outlook.com (20.176.112.10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Tue, 24 Sep 2019 17:42:41 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019 17:42:41 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "eblake@redhat.com" <eblake@redhat.com>
Subject: Re: [PATCH] Cygwin: rmdir: fail if last component is a symlink, as on Linux
Date: Tue, 24 Sep 2019 17:42:00 -0000
Message-ID: <29f4f5b8-cd09-7378-823c-4627b3ca16fc@cornell.edu>
References: <20190922171823.3134-1-kbrown@cornell.edu>
In-Reply-To: <20190922171823.3134-1-kbrown@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:7691;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <17D7C98AA000E24FAFAEE0FE77861DDA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzgCAQDpJOHe/D9at8oDZ3pTb0nwW0lIOCLLO0yM4CLGFlW4LJngH7dc4HSXTFM0FvyKKXaJACyDM+eN89L4Mw==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00239.txt.bz2

On 9/22/2019 1:18 PM, Ken Brown wrote:
[...]
> @@ -354,6 +353,25 @@ rmdir (const char *dir)
>=20=20=20
>     __try
>       {
> +      if (!*dir)
> +	{
> +	  set_errno (ENOENT);
> +	  __leave;
> +	}
> +
> +      /* Following Linux, do not resolve the last component of DIR if
> +	 it is a symlink, even if DIR has a trailing slash.  Achieve
> +	 this by stripping trailing slashes or backslashes.  */
> +      if (isdirsep (dir[strlen (dir) - 1]))
> +	{
> +	  /* This converts // to /, but since both give ENOTEMPTY,
> +	     we're okay.  */
> +	  char *buf;
> +	  char *p =3D stpcpy (buf =3D tp.c_get (), dir) - 1;

I forgot to declare tp.  v2 is on the way.

Ken
