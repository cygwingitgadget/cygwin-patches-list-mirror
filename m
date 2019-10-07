Return-Path: <cygwin-patches-return-9755-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 33998 invoked by alias); 7 Oct 2019 20:16:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 33988 invoked by uid 89); 7 Oct 2019 20:16:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:719
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730096.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.96) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Oct 2019 20:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=lydDu8x+kT8aanKFA09EBImC9larfR+u3+jilelhTvr8cYl965zMc5Vb4F+tYCtqC1Csi28m23g3deLRUaPOb3Hhfjqv9PLWKFG3kK4QvYnEcG2wd96oOoYV1c/bFK1oGkQeT0cJf/5EabV1P8uj/VJjOLzve64EdcEhlPFThHYSLurBJtf5EOkwqdPuTaL920QJC+d1zpk8Rc6+X70P++1SG5DJvGr7FC6M8yQETfTGpkMrWO10ozPch5sdK7+V1soI9FsGsDpj41OYUbEMeZV1T5MqR3hyxGs363NresYHJnaNszHWzxQk152A3I5rN1EKngoYrH3bCOwGBojl2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=AbxSd/7U1alhxx6uuklbT17zVdXVp2SpZTQ++hIb1fk=; b=CaediX/ESANlMJS5mndnVxazCXjDIX5By3udMb1SH+Kuieju+sYwnQUSZeuP0FHQHUrNX7uoP9XolpGJhR/ujsbcY2ed2b9y/Z9399bZ+pV0K6x3/3REEFY86EuMh8GYGrnC0fSRpww5fX0CxOuzPgXpRy2WYIfKphjdWo9GggTNNFIT6jrgkeaJcrrNJ/B3soCWKYufIs3x0idJR6YDUvsvOf+oL+XgeFr3ohAWAFpN4Z5Z3BaadbkfVaOEV9SkKT/ka3KmL3u6I7IDUCxiielfWsRD/2ZLSG4GeMegFLwE7SWhlGBWcwDQgGQS1Rfi+UoFgLbA8hVKBw4NgBkaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=AbxSd/7U1alhxx6uuklbT17zVdXVp2SpZTQ++hIb1fk=; b=araNFB+RenUQ8xikdZqgzMu/RLOQmCdUBbPRRSjxOzyzb3n0KlqaFUMov1tdncVPbqZpq/UodsAMdXdwMc9gEFZav8rrMbJPUEufPso3nSjOq8x8Tdg1GkglHgctLVSxVjR4Lb6jRcUzion2A4C24Uk/SCRX/yWWGdv+GeYHwBA=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6633.namprd04.prod.outlook.com (10.186.143.71) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Mon, 7 Oct 2019 20:16:12 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172%4]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019 20:16:12 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: mkdir and rmdir: treat drive names specially
Date: Mon, 07 Oct 2019 20:16:00 -0000
Message-ID: <8a5a5979-c632-ca36-bc56-6945f3c33812@cornell.edu>
References: <20190927184400.1478-1-kbrown@cornell.edu>
In-Reply-To: <20190927184400.1478-1-kbrown@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:7691;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <75B9F85DAA998542BBA6264ED7CB120A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WH5WhJ6cCFsLTOlie7fiO4Yd+EvsK8eqI4vgxe2QpCRhZ8flx0MNW6DgAxrhLCeN+i13LhFhWYoo7IS5KVpnpQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00026.txt.bz2

On 9/27/2019 2:44 PM, Ken Brown wrote:
> If the directory name has the form 'x:' followed by one or more
> slashes or backslashes, and if there's at least one backslash, assume
> that the user is referring to 'x:\', the root directory of drive x,
> and don't strip the backslash.
>=20
> Previously all trailing slashes and backslashes were stripped, and the
> name was treated as a relative file name containing a literal colon.
>=20
> Addresses https://cygwin.com/ml/cygwin/2019-08/msg00334.html.
> ---
>   winsup/cygwin/dir.cc | 33 ++++++++++++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 5 deletions(-)

No complaints, so I've pushed this.

Ken
