Return-Path: <HBBroeker@t-online.de>
Received: from mailout09.t-online.de (mailout09.t-online.de [194.25.134.84])
 by sourceware.org (Postfix) with ESMTPS id B74E83857C50
 for <cygwin-patches@cygwin.com>; Wed, 24 Mar 2021 18:56:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B74E83857C50
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=HBBroeker@t-online.de
Received: from fwd19.aul.t-online.de (fwd19.aul.t-online.de [172.20.27.65])
 by mailout09.t-online.de (Postfix) with SMTP id A75F5AE130
 for <cygwin-patches@cygwin.com>; Wed, 24 Mar 2021 19:55:50 +0100 (CET)
Received: from [192.168.178.26]
 (Z2mquwZXghl9x6HzU2ksIB9tKJ9lEamFLvusH1wQTBUzvMIhi6luIERNFgni7N5gZi@[79.228.81.44])
 by fwd19.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1lP8fV-2QLLrU0; Wed, 24 Mar 2021 19:55:49 +0100
Subject: Re: [PATCH 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
 <ff661784-ae78-4a98-8f6d-cddd57b0d216@pismotec.com>
 <nycvar.QRO.7.76.6.2103140115180.50@tvgsbejvaqbjf.bet>
 <86c7c1b6-06f9-9e60-e9d7-072b6e8c806f@pismotec.com>
 <nycvar.QRO.7.76.6.2103150408230.50@tvgsbejvaqbjf.bet>
 <69dc492e-cce9-1a1a-7d4b-92a58dbfe981@t-online.de>
 <nycvar.QRO.7.76.6.2103221603030.50@tvgsbejvaqbjf.bet>
 <830d2446-691e-957e-9531-856e58e79c08@t-online.de>
 <YFm1GF/90te95gh8@calimero.vinschen.de>
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
Message-ID: <b20e45d8-26fd-3186-581b-a44a4ba971ca@t-online.de>
Date: Wed, 24 Mar 2021 19:55:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFm1GF/90te95gh8@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-ID: Z2mquwZXghl9x6HzU2ksIB9tKJ9lEamFLvusH1wQTBUzvMIhi6luIERNFgni7N5gZi
X-TOI-EXPURGATEID: 150726::1616612149-00008954-1C160E30/0/0 CLEAN NORMAL
X-TOI-MSGID: 9674ec4b-81f0-4006-86de-05d944c01501
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 24 Mar 2021 18:56:15 -0000

Am 23.03.2021 um 10:30 schrieb Corinna Vinschen via Cygwin-patches:
 > On Mar 22 22:54, Hans-Bernhard Bröker wrote:
 >> Am 22.03.2021 um 16:22 schrieb Johannes Schindelin:
 >>> One of those under-documented reparse point types is the WSL symbolic
 >>> link, which you will notice are supported in Cygwin, removing quite 
some
 >>> sway from your argument...
 >>
 >> I notice no such thing right now, running the currently available 
release
 >> version 3.1.7:
 >>
 >> stat: cannot stat '//wsl$/Debian/home/hbbro/link_to_a': Input/output 
error
 >
 > What type of WSL symlink is that?

It's what WSL Debian creates when I 'ln -s' inside its own filesystem.

Windows' own "dir" command shows it as

22.03.2021  22:34    <JUNCTION>     link_to_a [...]

But it cannot do anything else with it.  Even fsutil doesn't work on 
that thing:

C:\prg\test>fsutil reparsePoint query \\wsl$\Debian\home\hbbro
Fehler:  Unzulässige Funktion.
