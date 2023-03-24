Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	by sourceware.org (Postfix) with ESMTPS id B2ECD3858D38
	for <cygwin-patches@cygwin.com>; Fri, 24 Mar 2023 13:22:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B2ECD3858D38
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mo7Bb-1qHEG10nGN-00pcRX; Fri, 24 Mar 2023 14:22:18 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DF0D9A80CC8; Fri, 24 Mar 2023 14:22:16 +0100 (CET)
Date: Fri, 24 Mar 2023 14:22:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Message-ID: <ZB2kCC4TF2xCns47@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Yoshinao Muramatsu <ysno@ac.auone-net.jp>
References: <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
 <ZBWL85hJIlbZHc/D@calimero.vinschen.de>
 <608a78b6-f523-14f1-333d-f59e9f2bb8d5@ac.auone-net.jp>
 <ZBhy7E4vKHTRNW6k@calimero.vinschen.de>
 <ZBjD9exM9ZBGDzK3@calimero.vinschen.de>
 <434bbf77-6a08-3be2-747f-13dfc4637275@ac.auone-net.jp>
 <ZBnwKcr+ZL6sv0jh@calimero.vinschen.de>
 <f82458c2-72be-7485-66da-82b0342ae729@ac.auone-net.jp>
 <ZB2Ph+7EkP8evVJo@calimero.vinschen.de>
 <3ca8b41e-41c4-7c34-8912-dc515b3da57e@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ca8b41e-41c4-7c34-8912-dc515b3da57e@dronecode.org.uk>
X-Provags-ID: V03:K1:e/4fiDxHVdjttx3UP+Te2DzdjkaY6Hj9MDNK3I5aU9Alem1K4eo
 z0vPtDd8O1t9ZkNCvzXWgIYJsOCJAVPLoSVvi8+mnjDM2MiDd6Wzcsegsd3OrCqI+bytRb6
 I5miU/cUQp0o7Avmwwpe2wezvcuhUA/2W0Wt7GQOSPo87YMkpr9gqyTvf4u70c/r4hzt5fr
 cC6Xj7r+LAIR7SjdQ4bhQ==
UI-OutboundReport: notjunk:1;M01:P0:v0qDikXqu2E=;RCxopUdpxn3Z/1dPIG2RyGqToqQ
 e5/pAI5A680FalWg+mgTtxhSworXCnS3bmVcT8gzZckgu3DEDW+gnb/4vThCsToleN4kaBrfc
 cPvIQOu5mEkFOz6OwoFg7BOxSMHB5AXmXajTmo/B7s3e9avuIL3a1EkkNQOHjv4tsHmiP2OwP
 7AUECVITWKwpuKl705g2tqtIPwqYX8KoSsTtiWer/qGaAzQwQS8kMF2IHXpZyYPmStVcU/B+k
 0oGvW014uvh0fEzRgM8LhaM8ZSUrwO5AvptLgYzcVRwPHEVtOtSRF3QiMMNkmNyE8pAo9OPVA
 ONlnCtt9D2B9sXHcDRg+07rkTsGazSQqB2e1pUb3om9mWNCIeJ1j1/U6TT6pcrIOfOS0X74YA
 nV1yTLwaDazb8E5dKlbl13mgRlMW+6C6VaQqBp1nNOXtsPEbWKo5bNWQ/La0O4MmJJnqlW0ew
 ruaJbFDqHT4rkQZIXcKIkO4FuXNlVrXoeTEB4bIx4rt1E+biEw4Jpp2ktZA24uCrQah1nlUxt
 vf3ymuyeCTx82Vvlt+iRkmuWKHUslSqFePrKp0yaRDP67rUYx6yvR7P156yjK+B1qi0gwqU6W
 uhV+2HaVv1q3eIX9Ftd9spoEo4MQclRlXuDav3xQwY8ZpmBX03rch2K96lgMYcAYyQ+Blenpk
 Skp+rek/9MoTlSOcd+h2Qv0YwezT8yk4iBY/gl5c9Q==
X-Spam-Status: No, score=-97.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mar 24 13:20, Jon Turney wrote:
> On 24/03/2023 11:54, Corinna Vinschen wrote:
> > On Mar 24 01:40, Yoshinao Muramatsu wrote:
> > > On 2023/03/22 2:58, Corinna Vinschen wrote:
> > > > I pushed a new Cygwin DLL, test release 3.5.0-0.251.gfe2545e9faaf.
> > > > This should do what we want, now.  If you can confirm, I'll push
> > > > your workaround afterwards.
> > > 
> > > I have tested cygwin-3.5.0-0.251.gfe2545e9faaf.
> > > It works fine with bind mounted directory in the hyper-v container.
> > 
> > Thanks, I pushed your patches.  We can reevaluate the
> > FILE_SUPPORTS_OPEN_BY_FILE_ID handling if Microsoft actually
> > changes this in Hyper-V.
> > 
> > > Slightly off-topic, but since I could not use gui to set up cygwin
> > > in the container, I am using setup-x86_64.exe with cli.
> > > Is there a way to install the cygwin package by specifying
> > > the package version from cli?
> > 
> > Uhm... I don't think so.  I'm not aware of such a way to define the
> > desired package version on the CLI.  That would be a nice feature...
> 
> '-P cygwin=3.5.0-0.251.gfe2545e9faaf' allegedly works, for a while now.

Oh, wow, great!


Thanks,
Corinna
