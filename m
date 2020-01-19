Return-Path: <cygwin-patches-return-9953-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26736 invoked by alias); 19 Jan 2020 20:25:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26382 invoked by uid 89); 19 Jan 2020 20:25:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-13.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=Cygwin, H*r:2603, H*r:403, edition
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690134.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 19 Jan 2020 20:25:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=FQZh7A6lP067VuXvnrxV4XCLoz2unDHpLHOSepw23YESqkfKAIKiVymBHrPhjFdYFDzv6aP/7pGNSCbHStK0oWUUTphtDSQB+GZmc8/YVmBEOI5lSUdNa4/XOpvW6gBzztJZouTfMEeD8BKO6xMtfh1ICKXmWJhXoaegky0Qn2biqXcVKHML1Aud8rVpLPhWGvf5LQN6I4I/ZxSyxlY+cEhU+uDGbgGa/pjMFoNHD353xkpy/63M/t5yqKeh3srxgCtkc562abivM3iB6ePy/YmtWrdFiidm3V9Xq+5PDDd1AmoZQA4AyqiWt7ctKEBwhpqnGN0kC+FnC56x+Y6nJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=JxkV1kJ4iemn/3At6ohz+eIosLGdjr0q79Lw4/Vhp30=; b=Mb/rwbSMRlwSAwfxJYGzl//dGjZpQAiOq97+sn5Pq1/ZuGlJH5a2+3G2nFL6nXKlbZexti3f+BUWaDQdxlUCDOXZrOuBWaf2gj2wmNZtLSsXBAKlhVKwdzTgAMsZrxuEb+QXxjpyPu+G5yZvHrH4eZ+Y53GNNwgex9SXT7GYHTCn07t3gwdBY1Zaw08Ycxv4WMrceBuH3B7wnhjHYwine+ams9noZIyfY2Wgo2wrMpNx9caXBfTVjkE44Ev8gdi7e8pZ0tT8e0/vIP4qHVmbWAYVzF8krnZhyRKipwIRJMadCA/3PLfYOR1qzMCf7q0b+fXgQZFGuX49IGvEj8tSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=JxkV1kJ4iemn/3At6ohz+eIosLGdjr0q79Lw4/Vhp30=; b=IJVLGRzFHqkvYg6OFA+WUpbr61Y24EwZ5unLOtecMGH5Cc4nu0BJkXKvGMWJqAa5ppKelkCFmrM7BMpOMH8Cea8gQDrRJ6SC85ldG8bwc5UQq5+kNm29BHifP3zBgHY5/GzGOFFmGFOE2iaSQVuGsbTTXof9feO9Zixra20P7q0=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4300.namprd04.prod.outlook.com (20.176.76.13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Sun, 19 Jan 2020 20:25:31 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.024; Sun, 19 Jan 2020 20:25:31 +0000
Received: from [10.13.22.8] (65.112.130.194) by BN4PR10CA0003.namprd10.prod.outlook.com (2603:10b6:403::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Sun, 19 Jan 2020 20:25:30 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: allow opening an AF_LOCAL/AF_UNIX socket with O_PATH
Date: Sun, 19 Jan 2020 20:25:00 -0000
Message-ID: <f94efc8e-28d3-fd68-d6e4-a092637cf6e8@cornell.edu>
References: <20200116183355.1177-1-kbrown@cornell.edu> <20200117094826.GC5858@calimero.vinschen.de> <20200117095104.GD5858@calimero.vinschen.de>
In-Reply-To: <20200117095104.GD5858@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:4714;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E033E6AF929056489AA2EDB3CC4C80E7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nB3B7D+Nj+Tv4i9vfFtskyENjeOzDLT/ZKM9xrV4V0ewvQ4BfwKOqbP9KkxhV8Nzhk5+7XGf5Vb5Cguzrtt0PA==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00059.txt

On 1/17/2020 4:51 AM, Corinna Vinschen wrote:
> On Jan 17 10:48, Corinna Vinschen wrote:
>> On Jan 16 18:34, Ken Brown wrote:
>>> If that flag is not set, or if an attempt is made to open a different
>>> type of socket, the errno is now EOPNOTSUPP instead of ENXIO.  This is
>>> consistent with POSIX, starting with the 2016 edition.  Earlier
>>> editions were silent on this issue.
>>> ---
>>>   winsup/cygwin/fhandler.h               |  2 ++
>>>   winsup/cygwin/fhandler_socket.cc       |  2 +-
>>>   winsup/cygwin/fhandler_socket_local.cc | 16 ++++++++++++++++
>>>   winsup/cygwin/fhandler_socket_unix.cc  | 16 ++++++++++++++++
>>>   winsup/cygwin/release/3.1.3            |  7 +++++++
>>>   winsup/doc/new-features.xml            |  6 ++++++
>>>   6 files changed, 48 insertions(+), 1 deletion(-)
>>
>> I'm a bit concerned here that some function calls might succeed
>> accidentally or even crash, given that the original socket code doesn't
>> cope with the nohandle flag.  Did you perform some basic testing?
>=20
> Iow, do the usual socket calls on a fhandler_socket_local return EBADF
> now?  Ignoring fhandler_socket_unix for now.

I really hadn't thought this through very well.  I think the following=20
additional patch should do the job:

--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -67,6 +67,11 @@ get (const int fd)

    if (!fh)
      set_errno (ENOTSOCK);
+  else if (fh->get_flags () & O_PATH)
+    {
+      set_errno (EBADF);
+      fh =3D NULL;
+    }

    return fh;
  }

I'll do some testing and then report back with a revised patch.  Thanks for=
=20
catching my mistakes.

Ken
