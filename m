Return-Path: <cygwin-patches-return-9740-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 118134 invoked by alias); 6 Oct 2019 14:31:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 118123 invoked by uid 89); 6 Oct 2019 14:31:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr720125.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) (40.107.72.125) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 06 Oct 2019 14:31:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=guZmKW/OgI9XnNfvKrlCS4HAhzz0HJczwFrxpzqgD2gmsGgAMR1PX0R1Bi0O+qU6GMsaJjiGnUQCSM7XwNKpCdNdcAUwKva45n5R3QmD+aTe24kXm7uE1GjsjNrQuN11sRSWg4C01GyoCzak8sM2nw4lzR8Vjrv+vN5Re+Y773WonX8XRJETy1GFEM6AXuSgUzss1Rq0TWyoqB1bW5Y7e4XBJiB4Bx7i5zkiR/ga3hzXGhL3edkam50Fm5HKMkInl01ui2JXFV4yT2DiMz/6gstbn3dEwOFDM6/lOQVzdLz99036Aj1I+Osl7ghtzadApX9CDdgEyrOPUJw6DTOuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=nDKku0ltqgwH2tdahRakrwex8tmqtGUAOTWDXDRLiL4=; b=JQj8gQpF9hCQzXUztruYhDnArJ/F4VjXsGTOP7/dUGdtY54LUnKanNyZteSrq31F0g0Z2kzBCZZs7CPuq1NUE0pOzYSp2LjOgwwYwQ2gKKgegtpVwyAeYllFoqHdcgT62wuIvWwpPMS5/8LAR2GFaSM6z9jsV9k4d+E9DUZbktKb0/dZQXHWivvE3+RzTcikACMtO+mE/bYZo7SXKFe65YQ9T6HNNaw18Gv3+xqudWEqORg11Q68QRXepGv6IJwhhlhcs76M+sSIPYW+pD4VHXeLONgQyCpr6/kxg1Ryd3Hr4vqu1YvJ+ZCgONJ/L9mcqUM/QRcw65WG9lqWpYFV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=nDKku0ltqgwH2tdahRakrwex8tmqtGUAOTWDXDRLiL4=; b=bkcQBxcc7KLQIxlK95gJYSwsmpyYbXB3OKYTscYZe+U6GyOCMRqaJSmp94pTFyqWkj4qpzlBF+ePrMv8tts1IDfsk3qFWYSFG4i53nqxDVYNxgSxaex+MEPGLJznMSgQWe3wNFAw8JtfxkBj4Y9mpKF4f0knjGZxF4hD+73Hpc8=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4505.namprd04.prod.outlook.com (20.176.105.138) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Sun, 6 Oct 2019 14:31:53 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172%4]) with mapi id 15.20.2327.023; Sun, 6 Oct 2019 14:31:53 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): fix issues, add fields, flags
Date: Sun, 06 Oct 2019 14:31:00 -0000
Message-ID: <829a76fa-30d0-2707-c8ba-534b1dc7ba3a@cornell.edu>
References: <20191004104457.33757-1-Brian.Inglis@SystematicSW.ab.ca> <95be25ec-eeea-060e-fb40-ed5c7fc787c1@cornell.edu> <82d83d79-b194-107c-3ff4-6b02e36ea198@SystematicSw.ab.ca>
In-Reply-To: <82d83d79-b194-107c-3ff4-6b02e36ea198@SystematicSw.ab.ca>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F613F53383B6FE46B80A656AE5F5AED9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2BWjVlEXcH7XQ49yD0M0O2qK0BxO+N5yFRD38TZD2EYDDxCnQSYpfF6+CZXKHX0/YxWFSqexvbVq4xBdFxuI1w==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00011.txt.bz2

On 10/5/2019 5:42 PM, Brian Inglis wrote:
> On 2019-10-05 15:06, Ken Brown wrote:
>> On 10/4/2019 6:44 AM, Brian Inglis wrote:
>>> fix cache size return code handling and make AMD/Intel code common;
>>> fix cpuid level count as number of non-zero leafs excluding sub-leafs;
>>> fix AMD physical cores count to be documented nc + 1;
>>> round cpu MHz to correct Windows and match Linux cpuinfo;
>>> add microcode from Windows registry Update Revision REG_BINARY;
>>> add bogomips which has been cpu MHz*2 since Pentium MMX;
>>> handle as common former Intel only feature flags also supported on AMD;
>>> add 88 feature flags inc. AVX512 extensions, AES, SHA with 20 cpuid cal=
ls;
>>> commented out flags are mostly used but not currently reported in cpuin=
fo
>>> but some may not currently be used by Linux
>>
>> Thanks!  This must have been a lot of work.
>=20
> Already had the info in some of my own code, that pointed out the discrep=
ancies
> between Cygwin and Linux, and prompted the desired to level up.
>=20
>> It would be easier to review if you would split it up into smaller patch=
es, each
>> doing one thing, to the extent that this makes sense.  For example, the
>> simplification achieved by using the ftcprint macro could be done in a s=
ingle
>> patch that's separate from the substantive changes.
>=20
> Unfortunately, that was added later to make the got it/add it/skip it fla=
g cross
> checks in Linux order more certain vs my own sequential tabular source.

What I was suggesting was that you go back after the fact and split up your=
=20
patch into smaller, more easily digestible patches.  This simplifies review=
 as=20
well as later debugging.  The order in which you did things while developin=
g the=20
patch is not really relevant.

>> A few nits:
>>
>>> -      DWORD cpu_mhz =3D 0;
>>> -      RTL_QUERY_REGISTRY_TABLE tab[2] =3D {
>>> +      DWORD cpu_mhz;
>>> +      DWORD bogomips;
>>> +      long long microcode =3D 0xffffffff;	/* at least 8 bytes for AMD =
*/
>>> +      union {
>>> +	  LONG len;
>>> +	  char uc_microcode[16];
>>> +      } uc;
>>> +
>>> +      cpu_mhz =3D 0;
>>> +      bogomips =3D 0;
>>> +      microcode =3D 0;
>>
>> Why change the existing intialization style?  How about
>>
>>         DWORD cpu_mhz =3D 0;
>>         DWORD bogomips =3D 0;
>>         long long microcode =3D 0;	/* at least 8 bytes for AMD */
>=20
> Need to ensure they are initialized each time thru the CPU loop, not just=
 once
> on entry, mainly because of what I found out about what I needed to do to=
 get
> the variable length REG_BINARY key.

They get initialized each time through the loop even with the initializatio=
n as=20
it was originally (DWORD cpu_mhz =3D 0;).  Or am I missing something?

Ken
