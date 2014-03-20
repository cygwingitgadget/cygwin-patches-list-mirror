Return-Path: <cygwin-patches-return-7975-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20226 invoked by alias); 20 Mar 2014 21:10:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20207 invoked by uid 89); 20 Mar 2014 21:10:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: am1outboundpool.messaging.microsoft.com
Received: from am1ehsobe003.messaging.microsoft.com (HELO am1outboundpool.messaging.microsoft.com) (213.199.154.206) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Thu, 20 Mar 2014 21:10:15 +0000
Received: from mail41-am1-R.bigfish.com (10.3.201.239) by AM1EHSOBE017.bigfish.com (10.3.207.139) with Microsoft SMTP Server id 14.1.225.22; Thu, 20 Mar 2014 21:10:12 +0000
Received: from mail41-am1 (localhost [127.0.0.1])	by mail41-am1-R.bigfish.com (Postfix) with ESMTP id B4DB2460550	for <cygwin-patches@cygwin.com>; Thu, 20 Mar 2014 21:10:11 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.249.197;KIP:(null);UIP:(null);IPV:NLI;H:AM2PRD0210HT001.eurprd02.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: 1
X-BigFish: PS1(zz148cIzz1f42h208ch1ee6h1de0h1fdah2073h2146h1202h1e76h2189h1d1ah1d2ah21bch1fc6hzz177df4h17326ah8275bh1de097h186068h172d07hz2fh109h2a8h839h944hd24hf0ah1220h1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh162dh1631h1758h18e1h1946h19b5h19ceh1ad9h1b0ah224fh1d07h1d0ch1d2eh1d3fh1dc1h1de9h1dfeh1dffh1e1dh1fe8h1ff5h2216h22d0h2336h2461h2487h24d7h2516h2545h255eh25cch25f6h2605h262fh9a9j1155h)
Received-SPF: pass (mail41-am1: domain of dnvgl.com designates 157.56.249.197 as permitted sender) client-ip=157.56.249.197; envelope-from=mark.weber@dnvgl.com; helo=AM2PRD0210HT001.eurprd02.prod.outlook.com ;.outlook.com ;
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009001)(6009001)(428001)(52604005)(189002)(199002)(66066001)(20776003)(63696002)(74706001)(54316002)(54356001)(65816001)(53806001)(56776001)(77982001)(80022001)(59766001)(74876001)(33646001)(76482001)(46102001)(51856001)(15202345003)(15395725003)(97336001)(97186001)(74366001)(76176001)(49866001)(76786001)(83322001)(77096001)(19580395003)(80976001)(85306002)(15188555004)(76796001)(85852003)(4396001)(74316001)(87936001)(15975445006)(47736001)(69226001)(2656002)(47976001)(93136001)(50986001)(76576001)(81816001)(81342001)(81686001)(87266001)(81542001)(92566001)(93516002)(94316002)(79102001)(95416001)(31966008)(95666003)(74662001)(90146001)(86362001)(74502001)(56816005)(83072002)(94946001)(47446002)(24736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR02MB113;H:AM3PR02MB113.eurprd02.prod.outlook.com;FPR:BFA6DD48.2E308739.71DC37B8.44E7398B.20170;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received: from mail41-am1 (localhost.localdomain [127.0.0.1]) by mail41-am1 (MessageSwitch) id 1395349808579943_445; Thu, 20 Mar 2014 21:10:08 +0000 (UTC)
Received: from AM1EHSMHS018.bigfish.com (unknown [10.3.201.227])	by mail41-am1.bigfish.com (Postfix) with ESMTP id 80322440071	for <cygwin-patches@cygwin.com>; Thu, 20 Mar 2014 21:10:08 +0000 (UTC)
Received: from AM2PRD0210HT001.eurprd02.prod.outlook.com (157.56.249.197) by AM1EHSMHS018.bigfish.com (10.3.207.156) with Microsoft SMTP Server (TLS) id 14.16.227.3; Thu, 20 Mar 2014 21:10:07 +0000
Received: from AM3PR02MB113.eurprd02.prod.outlook.com (10.242.243.140) by AM2PRD0210HT001.eurprd02.prod.outlook.com (10.255.164.36) with Microsoft SMTP Server (TLS) id 14.16.423.0; Thu, 20 Mar 2014 21:10:07 +0000
Received: from AM3PR02MB113.eurprd02.prod.outlook.com (10.242.243.140) by AM3PR02MB113.eurprd02.prod.outlook.com (10.242.243.140) with Microsoft SMTP Server (TLS) id 15.0.898.11; Thu, 20 Mar 2014 21:10:06 +0000
Received: from AM3PR02MB113.eurprd02.prod.outlook.com ([169.254.7.202]) by AM3PR02MB113.eurprd02.prod.outlook.com ([169.254.7.202]) with mapi id 15.00.0898.005; Thu, 20 Mar 2014 21:10:06 +0000
From: "Weber, Mark" <mark.weber@dnvgl.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: patch for command line containing equals sign
Date: Thu, 20 Mar 2014 21:10:00 -0000
Message-ID: <d67f6d61ce414f719b5c26c3d71f301b@AM3PR02MB113.eurprd02.prod.outlook.com>
x-forefront-prvs: 01565FED4C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dnvgl.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00048.txt.bz2


See
http://cygwin.com/ml/cygwin-patches/2014-q1/msg00017.html
and related.

Thanks for posting how the new behavior is different from the old.
I am having a related issue, with C++ code that parses the command line.

The command line we support is something like -
  program_name   arg1  -option1=3Dval1  -option2=3Dval2  ...

You get the idea.

Now, with the above mentioned Cygwin patch, we are seeing the input argumen=
ts

arg1  "-option1=3Dval1"   "-option2=3Dval2"  ...

If this were the extent of the issue, it would be no big deal to strip off =
the quotes. However, the user may have put quotes on the command line himse=
lf, which Cygwin now moves around.
Such as:
  program_name  arg1  -option1=3D"file name with spaces in it"

Is there any way to reliably tell what the user entered on the command line?


