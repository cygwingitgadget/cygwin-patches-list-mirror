Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	by sourceware.org (Postfix) with ESMTPS id D2FBC3858431
	for <cygwin-patches@cygwin.com>; Fri, 24 Mar 2023 11:54:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D2FBC3858431
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mbzdn-1qBhAd3KYR-00davM; Fri, 24 Mar 2023 12:54:48 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1E882A80C30; Fri, 24 Mar 2023 12:54:47 +0100 (CET)
Date: Fri, 24 Mar 2023 12:54:47 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Message-ID: <ZB2Ph+7EkP8evVJo@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Yoshinao Muramatsu <ysno@ac.auone-net.jp>
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
 <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
 <ZBWL85hJIlbZHc/D@calimero.vinschen.de>
 <608a78b6-f523-14f1-333d-f59e9f2bb8d5@ac.auone-net.jp>
 <ZBhy7E4vKHTRNW6k@calimero.vinschen.de>
 <ZBjD9exM9ZBGDzK3@calimero.vinschen.de>
 <434bbf77-6a08-3be2-747f-13dfc4637275@ac.auone-net.jp>
 <ZBnwKcr+ZL6sv0jh@calimero.vinschen.de>
 <f82458c2-72be-7485-66da-82b0342ae729@ac.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f82458c2-72be-7485-66da-82b0342ae729@ac.auone-net.jp>
X-Provags-ID: V03:K1:CHXgScRhmKX4S14Cn+DOr8RzJ1TjzM6t4wpYoAJekLJk8JpZ0Vb
 sNAq/3Bkbb6HE5kJi/TbMeWQ46OR+bKuQgEPwvEW+N3fQp+PFU7R1S2zc/AXxnqqrEDoG0K
 aB/Cppv7Y4NJ5j6GQbB9P4jCERmn4YniaG8A0aCkD7ywsyabAplP/meS2OL+zrnMGsJuB1i
 Q7I2f1FhNspD3shBsHfew==
UI-OutboundReport: notjunk:1;M01:P0:KnXLmBlvcSQ=;eKgfqMtbf/LV26GRTikd9X+7bjo
 P2MZzHL5LszdKufrqZBTQbeH4XNb+xlH5+p4jtg992DDMJuwd4HLC1cAstZFu7p6in8DbKF2z
 xC9+8WibaRxy2Zy1oUeiU3wNg8WhIpt14/TVGZltTUDKoF1dbWs0aXGASNg0KWf0gwipYeM4+
 Qai5p1jaJPBu5RqOCCJIhtz623eTRjjaiHYdiuDjlhdv8h6eIIUMPKi1D68VtT8LMeHORh4R6
 3LYf46YIA6VkTHmDDbyr2U0qgiMg0fpTVcBsISWegUfRcoPmTS9xbH2sZtil5uxhNSk1dIcFn
 RpQYyfANQiv3dgHfUbGs3x58GnLFtWpCRoqZYCJhpn1zqkKQN174fNLm3FRrv3UyT63rmU5Ff
 nrSdGLaGA/xPnS5RxU+koJLoj4WEH5i9GL78yQ0+2kXcNzPp9177eNB78grbBbaS5PquSw2iU
 PgzkXgZhwzYiPuY8jq2O2SYNyVKvt6vF/7xZdW4UI/o/iaank0mIkiimuPhiMg5nafzUBis/V
 oF2DqVQcvFPnChnKCrk2kWHurZuKPVH56u6FFjqifBaM6M5iG7STe2aGz6NbM/ID7ay1RwIcJ
 nzuXIB000qTRRnjcXAy2U+TdtNYoXxyqngPDEp97mU45dvbea/ZakLKhxB8k54SPSoz4lZUqp
 idznpNqrTzzkZWrAUbMJrqDmn4EKluSJX5cXHgwibg==
X-Spam-Status: No, score=-97.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mar 24 01:40, Yoshinao Muramatsu wrote:
> On 2023/03/22 2:58, Corinna Vinschen wrote:
> > I pushed a new Cygwin DLL, test release 3.5.0-0.251.gfe2545e9faaf.
> > This should do what we want, now.  If you can confirm, I'll push
> > your workaround afterwards.
> 
> I have tested cygwin-3.5.0-0.251.gfe2545e9faaf.
> It works fine with bind mounted directory in the hyper-v container.

Thanks, I pushed your patches.  We can reevaluate the
FILE_SUPPORTS_OPEN_BY_FILE_ID handling if Microsoft actually 
changes this in Hyper-V.

> Slightly off-topic, but since I could not use gui to set up cygwin
> in the container, I am using setup-x86_64.exe with cli.
> Is there a way to install the cygwin package by specifying
> the package version from cli?

Uhm... I don't think so.  I'm not aware of such a way to define the
desired package version on the CLI.  That would be a nice feature...


Thanks,
Corinna
