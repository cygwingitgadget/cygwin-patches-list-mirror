Return-Path: <cygwin-patches-return-9742-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76019 invoked by alias); 6 Oct 2019 20:25:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76010 invoked by uid 89); 6 Oct 2019 20:25:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=cout, cat, iostream, H*f:sk:728d83f
X-HELO: NAM03-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr790092.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) (40.107.79.92) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 06 Oct 2019 20:24:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Nz/6HOg8rOp+bx5UvLfZMdHFiQi7FnnX71zXu99DcOTcWdeNfkPVq4quzj0l/IaSJPYkSl40O5vFG46sgbyNl4nlsSsHU/o/ibPlHXxFClJFdMUii4Fp31ZisCFsJP6SUXQu9oGuit/5mXJsFKnmzQOprA23CUXVlmt7maZzgJepqU1WGqvw3y4V17OZNZ8lEzcKX6YKRYY9KQaDX1wEwUZQf91nLzaCziG0WKOqtobbKhh9EVyVtT3b7nnLAZwl2UbOPZzXpcUzJxjv5RLVDu5A90hT9pBJngZJ1aYqGHR5Ldpn9SrR3Wa2w81cyi9MmKDo0Xj97IYYZ6ApBjCFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=F2NgYVJ7LkSuvir/EfehUslSHmWI5hvhW6uFotb53fU=; b=Ehn7pC4raNXflaFkmai7l1hNZrey5TY4AUn6tDcEctXQeLtx3EFynOA+4niCACixbXz6AwDIcPKB0e0wJ6URb50aTqk4dVmNZ/q3PrFQMa09k4/9AbpA2Ux0Vf6a0gf+32M7973L2XefCcwsoc4b72Wyzo3l84Ow06iRFImOMDuYMOzxvCxUDocDtWa9VR7ZAiINCs2uUvL0JPXRyiLQg4W1Yz/8dHaAcgxonx8GglYDvK9BLol+RX35+3Q5Q3s6B7+544K89R+CoXzBUpjZ+TEI6TRulOs+YzkEZKcSfouhUZ2WqJhgoYauGjO9TpvQLjGaGkvurM8Je3LfcTPQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=F2NgYVJ7LkSuvir/EfehUslSHmWI5hvhW6uFotb53fU=; b=QgBZCGi0zdAyAzkYbk4es9SH2JUmI7fHg72zu6u6xHdHNQqC+3+O+7CqB/k3zw3A71l4XSNBPiXceIg4aEBgzzJgc3rKEBIZ3uzCCLppIVSSP0wTm+0mKNq29oNXhHOtnugkDn4EXOoV2DFA9M9lmxnCn+N43YngfsfzqX1VWb4=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4284.namprd04.prod.outlook.com (20.176.76.29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Sun, 6 Oct 2019 20:24:55 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172%4]) with mapi id 15.20.2327.023; Sun, 6 Oct 2019 20:24:55 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): fix issues, add fields, flags
Date: Sun, 06 Oct 2019 20:25:00 -0000
Message-ID: <d8f80d65-a63a-7bd4-1a61-2ba27248643d@cornell.edu>
References: <20191004104457.33757-1-Brian.Inglis@SystematicSW.ab.ca> <95be25ec-eeea-060e-fb40-ed5c7fc787c1@cornell.edu> <82d83d79-b194-107c-3ff4-6b02e36ea198@SystematicSw.ab.ca> <829a76fa-30d0-2707-c8ba-534b1dc7ba3a@cornell.edu> <728d83f8-7ccf-ac26-2c37-73912c967507@SystematicSw.ab.ca>
In-Reply-To: <728d83f8-7ccf-ac26-2c37-73912c967507@SystematicSw.ab.ca>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:8882;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <B5F5FFF5188B1C47AF3174E20F6607BF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2tqGmuaLK22Hbc/GgUJtJzQJNe2D5VL10Ay22jB6ASYmAR4mDRMR/kAsmFrSLWh21PZlS/wfttdhMTMQvW4vJQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00013.txt.bz2

On 10/6/2019 12:23 PM, Brian Inglis wrote:
> On 2019-10-06 08:31, Ken Brown wrote:
>> On 10/5/2019 5:42 PM, Brian Inglis wrote:
>>> On 2019-10-05 15:06, Ken Brown wrote:
>>>> On 10/4/2019 6:44 AM, Brian Inglis wrote:
>>>>> fix cache size return code handling and make AMD/Intel code common;
>>>>> fix cpuid level count as number of non-zero leafs excluding sub-leafs;
>>>>> fix AMD physical cores count to be documented nc + 1;
>>>>> round cpu MHz to correct Windows and match Linux cpuinfo;
>>>>> add microcode from Windows registry Update Revision REG_BINARY;
>>>>> add bogomips which has been cpu MHz*2 since Pentium MMX;
>>>>> handle as common former Intel only feature flags also supported on AM=
D;
>>>>> add 88 feature flags inc. AVX512 extensions, AES, SHA with 20 cpuid c=
alls;
>>>>> commented out flags are mostly used but not currently reported in cpu=
info
>>>>> but some may not currently be used by Linux
>>>>
>>>> Thanks!  This must have been a lot of work.
>>>
>>> Already had the info in some of my own code, that pointed out the discr=
epancies
>>> between Cygwin and Linux, and prompted the desired to level up.
>>>
>>>> It would be easier to review if you would split it up into smaller pat=
ches, each
>>>> doing one thing, to the extent that this makes sense.  For example, the
>>>> simplification achieved by using the ftcprint macro could be done in a=
 single
>>>> patch that's separate from the substantive changes.
>>>
>>> Unfortunately, that was added later to make the got it/add it/skip it f=
lag cross
>>> checks in Linux order more certain vs my own sequential tabular source.
>>
>> What I was suggesting was that you go back after the fact and split up y=
our
>> patch into smaller, more easily digestible patches.  This simplifies rev=
iew as
>> well as later debugging.  The order in which you did things while develo=
ping the
>> patch is not really relevant.
>=20
> How on earth does one accomplish that?

Think about how to logically divide your work into several tasks.  Then do =
one=20
task at a time, making a commit after each one.  For example, "code=20
simplification via ftcprint" might be task 1.

You can do this by hand, but there are also tools that can help.  Achim=20
mentioned Emacs/magit, but that doesn't make sense for you unless you're al=
ready=20
an Emacs user and willing to learn magit.  Another tool that I've occasiona=
lly=20
found useful is splitpatch.  Finally, git itself provides a tool=20
(https://git-scm.com/book/en/v2/Git-Tools-Interactive-Staging).
>>>> A few nits:
>>>>
>>>>> -      DWORD cpu_mhz =3D 0;
>>>>> -      RTL_QUERY_REGISTRY_TABLE tab[2] =3D {
>>>>> +      DWORD cpu_mhz;
>>>>> +      DWORD bogomips;
>>>>> +      long long microcode =3D 0xffffffff;	/* at least 8 bytes for AM=
D */
>>>>> +      union {
>>>>> +	  LONG len;
>>>>> +	  char uc_microcode[16];
>>>>> +      } uc;
>>>>> +
>>>>> +      cpu_mhz =3D 0;
>>>>> +      bogomips =3D 0;
>>>>> +      microcode =3D 0;
>>>>
>>>> Why change the existing intialization style?  How about
>>>>
>>>>          DWORD cpu_mhz =3D 0;
>>>>          DWORD bogomips =3D 0;
>>>>          long long microcode =3D 0;	/* at least 8 bytes for AMD */
>>>
>>> Need to ensure they are initialized each time thru the CPU loop, not ju=
st once
>>> on entry, mainly because of what I found out about what I needed to do =
to get
>>> the variable length REG_BINARY key.
>>
>> They get initialized each time through the loop even with the initializa=
tion as
>> it was originally (DWORD cpu_mhz =3D 0;).  Or am I missing something?
>=20
> I assume that initializations are done as if at compile time, so do assig=
nments
> at the appropriate points.
> I have no idea what C++ does for local non-object data type initializatio=
n.

$ cat a.cc
#include <iostream>
using namespace std;

int
main ()
{
   for (int i =3D 0; i < 5; i++)
     {
       int n =3D 0;
       cout << i << " " << n << endl;
       n++;
     }
}

$ g++ a.cc

$ ./a
0 0
1 0
2 0
3 0
4 0

Ken
