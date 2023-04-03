Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	by sourceware.org (Postfix) with ESMTPS id 1427D3858D37
	for <cygwin-patches@cygwin.com>; Mon,  3 Apr 2023 10:59:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1427D3858D37
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MbS0X-1qGQjO3O13-00brlA; Mon, 03 Apr 2023 12:59:27 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5E18DA80CED; Mon,  3 Apr 2023 12:59:27 +0200 (CEST)
Date: Mon, 3 Apr 2023 12:59:27 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 2/3] Respect `db_home` setting even for
 SYSTEM/Microsoft accounts
Message-ID: <ZCqxj6PWp0d0dikW@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	cygwin-patches@cygwin.com
References: <cover.1663761086.git.johannes.schindelin@gmx.de>
 <cover.1679991274.git.johannes.schindelin@gmx.de>
 <a70c77dc8f0d8417537557ea8e3a38f85bc582dd.1679991274.git.johannes.schindelin@gmx.de>
 <ZCK+mOdyaAQnLBwF@calimero.vinschen.de>
 <f14da2f0-2e7d-73c4-e6d9-e2516b8966f2@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f14da2f0-2e7d-73c4-e6d9-e2516b8966f2@gmx.de>
X-Provags-ID: V03:K1:lNv2dsie63CasG7LEBlPgBSo24M4U5g4jAvybA/kHrHCt3s4twf
 1+Qlo+jPaqvBVBTlwteVvNkG96JgaNDCeFwgOaQldkHG3IZX3Nefbezp0LxfhEFtSLCOFwB
 rRUNENw0MHkiPrnQWlB6JlIBCI06KRZpvX9L0A+KySft8Qzeo2HZVGQnRNCS/EYKm37GZ6Y
 eh+RCg3B1kLvCxtwhIAUQ==
UI-OutboundReport: notjunk:1;M01:P0:hChECPop/Fw=;OGYMqozCPQfobELNa5VxfVJ/Yr4
 0GJA26FlWZhyR3uvxwddEWm6jQCmnUzLXzQVY8ukd3tORLOzhOA174izJhGQmRt0W4k2z7Evh
 CR2u0+4EQhqbm9Tl5djlun4MbN46QFhqUo8jr/Oix6/fRDNlF+j2yx4WgzESXkYmbF5FJ7kfH
 prCg4Gr2GjAMQ+KeRAtLfP8hmmTBhBmdFf8mee6UDrnepBbGRPwA2uWmZcMfCMIF92Ubdap90
 leDX967xumf+tjS2PMa3g13Eaw/bVFl7r8K4gbvRR+rOHBwV9O9wUace7w/vk18ABLqasdTGH
 +NvjfZERVH6JeZ+rPoLYcmLiRIB0fqWeLIFZCS5n5cSFGUh0ujo5W5wCTCDAnBefPPTknZcLf
 Ph83cnFMNwgQRB+FJcCuMTrShGNkyIwCK2TQDo6zbMIj/MnJkUQIc1qg1smj1/tWCU0AjqGwR
 1Oo5URGiFyH7OwnGNxgcUhymVwNpR3wtZB30/6GrK++naeVWjeuw1iatc0RpQeV1b2Yu4l6Wj
 Z2cgwtALLv/6u4zk//djqPET/RLHJU53WBnVfjEj/njz+wf1CL4wBSlMFt3Wny5F1uz9HT55B
 NSW88tWN+XCcSdpHI7W8k0bFcT4ErkdJ+15MAxptkxBvh8hrXYuxzNr5NDsKpsLGXG6+Nm9HB
 dF9ujqWOpBGnw8uIzJxXa8/ONyJhxNwWd1o/IcgZSA==
X-Spam-Status: No, score=-97.7 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Apr  3 08:36, Johannes Schindelin wrote:
> Hi Corinna,
> 
> On Tue, 28 Mar 2023, Corinna Vinschen wrote:
> 
> > On Mar 28 10:17, Johannes Schindelin wrote:
> > > We should not blindly set the home directory of the SYSTEM account (or
> > > of Microsoft accounts) to /home/SYSTEM, especially not when that value
> >                                   ^^^^^^
> > That should probably better be <username>, no?
> 
> No, this is the actual name of the home directory when you start
> `Cygwin.bat` using the SYSTEM account.

I know, but that doesn't match the beginning of your sentence:

  We should not blindly set the home directory of the SYSTEM account
  (or of Microsoft accounts)
   ^^^^^^^^^^^^^^^^^^^^^^^^


Corinna
