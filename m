Return-Path: <cygwin-patches-return-9761-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63317 invoked by alias); 17 Oct 2019 16:36:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63308 invoked by uid 89); 17 Oct 2019 16:36:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=japanese, Japanese, H*Ad:U*cygwin-patches
X-HELO: NAM05-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr710110.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) (40.107.71.110) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 17 Oct 2019 16:36:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Cl/rwCSfRQSSb+puEnrfIzZQedrF6zcabHh43fBTw21MPKRXsy+nYookEIx2S8xHnBOsJ2Y7UWuLRnviIXwwu07uJF8Rj5y1f/k5hJuL8HV3lRY+a4AZOqVpC2OxyHPXuZer7xMOld/jEqrgnUhaxCNOKZTfklKDKHX2yc9RsNwMGMzEe0C4Pva8geeYuiEMJ1Ggl7X6KPs8KphT0fdgP13TgwxpYR90vWXqFG5uAplYQDbampc0uZu1P6o9mlg8Hl7NoiJwheMZKNSZi2/1IwKeFAm26Ot+SQxULadX9UhFqyTbUKhF3TvkhLa5W3ffP20zQz11TwdTqkuv3RARqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ZcvDNMLfdL3YNXCglgeFj68RYJ6gxs2PXvE3rROGv0E=; b=BgSO9hu1mGRYkKlCzGNEHlPAkbXLej0AYI1I/bM+Il2HX5ErsP3MiFs9Ql4ulhabQ02aco9XoG4n5me1MWFYbz53b0wcwVp1Q26YrhpLFvcjqoL96Jp21/pkaeoGov3LuYfaEGSpjORENYUgUX02mBJ9vMsseFxYhbDgxGw04Rhbi29JsCzZ+QbCesxZQ3DWoUcnGYEVbaogE2ICrtqi1BAFSyFFxF/MKNjTv7pXboDkyEb1IIhS2WbpUI4AigNb0Ebxw9n+4kqckiw/8/NzidHickbcxtWieGbg2bwvQ4Az2LP2Llh9VYS6zydn0q7DiwPXa2rAjhpdzcmAAucaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ZcvDNMLfdL3YNXCglgeFj68RYJ6gxs2PXvE3rROGv0E=; b=BXbzENmLpDaCFY3isuWEQkIesgu3kDa8HiSZ13uP0rb3aLK9Q639couGY0irhZ3zw4Tqai0aW/0X5Ro8qQb5WgED+r6/bfFSgJPElgEFktyRC2bnQ5hNa4l+8Nkujmdl7NNg17EXal7ZbwatKUxZOklzRw7RRPmJUsTxyBUAZMM=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6361.namprd04.prod.outlook.com (10.141.160.213) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.23; Thu, 17 Oct 2019 16:36:26 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172%4]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019 16:36:26 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: pty: Change the timing of clear screen.
Date: Thu, 17 Oct 2019 16:36:00 -0000
Message-ID: <1b7038e5-c0e4-b527-71e1-ee46799b215c@cornell.edu>
References: <20191016123409.457-1-takashi.yano@nifty.ne.jp> <20191016123409.457-2-takashi.yano@nifty.ne.jp> <0c90ed2b-ed1e-643c-5643-78f50444f97d@cornell.edu> <2943cac3-3b48-3753-1d06-dff6590bb3b3@ssi-schaefer.com>
In-Reply-To: <2943cac3-3b48-3753-1d06-dff6590bb3b3@ssi-schaefer.com>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:3044;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <27A3DF41F7E7CD488D02B08D7F57583C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssZix/n64uDUZ8C8S3NBrnM2Ck63Xbb2YLwE1+LS8U9BJv3vlmnCV/47sA9DBN6AQ6ayxf4J6NYbgTOrYuOfYQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00032.txt.bz2

On 10/17/2019 12:03 PM, Michael Haubenwallner wrote:
> On 10/17/19 4:55 PM, Ken Brown wrote:
>> On 10/16/2019 8:34 AM, Takashi Yano wrote:
>>> ---
>>>    winsup/cygwin/fhandler_tty.cc | 26 +++++++++++++-------------
>>>    1 file changed, 13 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty=
.cc
>>> index 1095c82eb..baf3c9794 100644
>>> --- a/winsup/cygwin/fhandler_tty.cc
>>> +++ b/winsup/cygwin/fhandler_tty.cc
>=20
>>
>> This and the previous patch look good to me, but we should probably wait
>> for Haubi to confirm that they fix the problems he reported.
>=20
> I'm unsure what the first patch does address: It does not fix the 'ssh -t=
' testcase,
> and I doubt it actually should.  But it doesn't seem to break anything he=
re so far.
>=20
> The second patch fixes the (minor) issue with the 'Last login' line as ex=
pected.

Thanks.  I'll go ahead and push both patches.  And thanks, Takashi.  (Or sh=
ould=20
I be addressing you as "Yano"?  I'm ignorant about Japanese names.)

Ken
