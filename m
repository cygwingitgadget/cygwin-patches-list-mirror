Return-Path: <cygwin-patches-return-9584-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 99610 invoked by alias); 1 Sep 2019 15:13:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 99598 invoked by uid 89); 1 Sep 2019 15:13:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=management
X-HELO: NAM03-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr780094.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) (40.107.78.94) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 01 Sep 2019 15:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=DfQ4kwSZKykelc16uvUG0YvDdzYxu0idpH3aGppahYQsHBswZ5W9AaOirSSPy13s5eYzZiRNop15B85CW+f1S8mA7DoleNeTl+DrMu/M0nA/lJu+dsgY6zxzwxbmPJ3t6Zfn211Elb2rSwKulyleKDQxxBbV+1qZ9ntNYEkA4bgnaFBwf29AAvkOZzO7Mbc/T3nHvc+PATxVVpURgF5DZofxrtURtQYDZWiI/dq0icnLwm88IylgQRUmKXXRD1IS6Zz3d7ypeQ53go9tz5+A1R/J4FbemPe1QT/OepobOgUC35UAL1+NlOW/XtAlGFqT3XsVYwoldFTV1tXrjqBn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=cuA0j+/Ghq3s2AyFdzgyy4yffBYCsDw1k+g3NY3K7Uk=; b=HZfoX2TVHOVOr5Aw+eziVjXyvGcNelHF+RkQU655qfzw06kZkqsDReoGFvdutatKmr0B7wXEuCLrO7KkiVhMnPe2bjtMiyC6/SrmuoZ2revoy8eZ9QGcOz8j9QDYYTu6nakYQQOPHfPJoRgVD9GNKnzZduIJ7RUEvYnNpVu/KQ/13an1MSPwKqLrHTt65/P+3WdPMfXUhJlo7Mpo0u5Ghqz1by5z7jRQ4YDbmbWRrIrP/8n7XbsO7VnfzQPL7v3/GD+oXhMffHcPDxcgPLbxyTxR91UmgcAp52cJJEKfidHEgLRlRKsrx6sPoRQ6t2TAipFwJv6slSp14eVzIHu/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=cuA0j+/Ghq3s2AyFdzgyy4yffBYCsDw1k+g3NY3K7Uk=; b=K0XLJEca3plvOtl3wNzZVAGRpSIna23mL4yOw+RSVJ6Hreq98G7wUWKtoTVI8984LeJDDMoN4EVlczNDsfYwfoe6HzMcFl/ZRLwBl++TNikCgTR1n76cAT/VwXvdp+zsmsqYU+Wl99N99VELD+TrsWuzQUs4gsDmCK3ZqnYCxQc=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5324.namprd04.prod.outlook.com (20.178.26.81) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18; Sun, 1 Sep 2019 15:13:47 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2220.021; Sun, 1 Sep 2019 15:13:47 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 0/1] Fix PTY state management in pseudo console support.
Date: Sun, 01 Sep 2019 15:13:00 -0000
Message-ID: <1169565b-6e96-2865-4cad-eb7b2e6abe05@cornell.edu>
References: <20190831225446.1506-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190831225446.1506-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:1002;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <210D7D68D58A4F4092CBA94EFC414155@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuLL4Z+re5qZh6bp+7gPAPEapL6xg4iKmJtP3byue1nrVpCk32uuKQePzHW8mltWVF+ihz31XdH3ECHiLPKXYg==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00104.txt.bz2

Hi Takashi,

On 8/31/2019 6:54 PM, Takashi Yano wrote:
> Pseudo console support in test release TEST: Cygwin 3.1.0-0.3,
> introduced by commit 169d65a5774acc76ce3f3feeedcbae7405aa9b57,
> has some bugs which cause mismatch between state variables and
> real pseudo console state regarding console attaching and r/w
> pipe switching. This patch fixes this issue by redesigning the
> state management.

After applying this patch, I get the following in mintty:

$ cygcheck -cd | grep bash
grep: write error: Bad file descriptor

Further commands after that lead to the cursor jumping around.

Here's a second glitch I've noticed (starting with commit=20
169d65a5774acc76ce3f3feeedcbae7405aa9b57): In emacs, if I run a command tha=
t=20
uses compilation mode, the output displayed in the compilation buffer start=
s=20
with ^[[H^[[J.  Here ^[ is the escape character, so this is apparently the =
two=20
ANSI escape sequences ESC[H and ESC[J.

Sample commands that use compilation mode are 'M-x compile', 'M-x rgrep', a=
nd=20
'M-x find-name-directory'.  I can provide more detailed reproduction=20
instructions if you're not an emacs user.

I can also try to make an STC, but that will take me longer.

Ken
