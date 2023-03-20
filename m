Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by sourceware.org (Postfix) with ESMTPS id BF6D53858413
	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2023 14:54:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BF6D53858413
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MkYkC-1qLpeC3MlC-00m5TZ; Mon, 20 Mar 2023 15:54:38 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 163DFA80BBE; Mon, 20 Mar 2023 15:54:38 +0100 (CET)
Date: Mon, 20 Mar 2023 15:54:38 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Message-ID: <ZBhzrsckUqyn7dDZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Yoshinao Muramatsu <ysno@ac.auone-net.jp>,
	cygwin-patches@cygwin.com
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
 <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
 <ZBWL85hJIlbZHc/D@calimero.vinschen.de>
 <608a78b6-f523-14f1-333d-f59e9f2bb8d5@ac.auone-net.jp>
 <ZBhy7E4vKHTRNW6k@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBhy7E4vKHTRNW6k@calimero.vinschen.de>
X-Provags-ID: V03:K1:GOWJ7hQhgA1Mh+lH8Uax1Ln4iBbBPswJNxSbMoPi9OeWXyJv/2D
 Y4X23PepXnokgGkZqJyl+MLaco7b2kWVBuh5AtFnkh8YnrBW5OTp/6Y0JJX7q1CMMBz37Wx
 UKADGj/sDyzU0jfdfEaTK2wfnPJ/PEoF1a1kLaHrmnZVur4FkjFYhhnDNqa2jWz7oApwegf
 ZuPMBK6swWsuIVSNb9oxQ==
UI-OutboundReport: notjunk:1;M01:P0:MeiLaOPAt8k=;RxF8FQ2DxhmzRcqc/uJnCQrtbdh
 /5HxOIgEVjFXmWQKXfbpzd03SYGw/AMavXohQlz0buCGviCnWBqY4CRhWXgMdfwpKqPAd5yNP
 jQ6k+GAlZJrmciToAJLXLu3YhG18LjVOzD9tfY+LKVhrIQGVbvSJD6SuLDYCBt8STv8ATEN8U
 S0BiEptZc/iHi0zEpQpSw6fbo0jBs8k3B3v37sdE8FA8dfybEic9Ieq5QP9AF6SKj6PNJ18ev
 6/5hzKNuzvimPXstF4pBcC/TpNolnqgdjMjzpKH5eWr65GWTn+a5zDZdaZOVc6fY8F7cG93J6
 HGOglGPklDZQGK3BJWr7JEgVW7uZ4a2dOlyqRrXGI7UgQcgpwlEtIZBeaq12Rq1D+4B5wl3ul
 MCHeb224na7Abuz5egm+sPrQ7rzabeZ7qRDMCn3RrS8QMlu/l6AQcEp1qtq6M3RTHpht4hNIZ
 Drxm/Jj81iN4S2+7Xr81UDyCmU7XBqO3556TBADxxDS8VBuBNDpHAaOGNIuopaXhLT1cBt/hF
 n08BL5Y1MfKQ4VGgiG4t4P6oVEmTeB7kNHE32ZMZ71grRUBtxE8AvKJv5/UysGzTRy/vVXVG1
 Lh0rVoq2H/7Yl8sBhhlJxTCuqMi2lAglHWqd5RfBWucLmfw4yGw4WqtAnWtK8j6yLzavIuo3g
 H0BtdNYv+v+904b0gcBW4Qncohdr8RbitdVOiYU56w==
X-Spam-Status: No, score=-97.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mar 20 15:51, Corinna Vinschen wrote:
> On Mar 20 22:06, Yoshinao Muramatsu wrote:
> > On 2023/03/18 19:01, Corinna Vinschen wrote:
> > > FILE_SUPPORTS_OPEN_BY_FILE_ID flag is missing.
> > > 
> > > NTFS always supports this since Windows 2003!  So we could
> > > use this flag as indicator that, probably, POSIX rename/unlink
> > > won't work.
> > 
> > I thought that if there was no FILE_SUPPORTS_OPEN_BY_FILE_ID
> > and OpenByFileId() worked, it would be a Signature,
> > but the result was different.
> > 
> > I tested OpenByFileID() on a bind-mounted directory, it was failed.
> > Maybe it's because of the path isolation.
> > ltsc2022 process isolation says "I support it" but it not works.
> > Okay, it's not a security issue. So now I'm writing this here.
> > 
> > Unfortunately, the state of the FILE_SUPPORTS_OPEN_BY_FILE_ID flag
> > does not match the actual behavior, so I fear it may be corrected.
> 
> Actually, it doesn't matter if open by fileID works.  The fact that
> this flag is missing *is* a pattern we can use.  It allows us to
> distinguish the hyper-v isolated NTFS from a standard NTFS and thus,
> we can immediately do the right thing.

...and if Microsoft actually changes that at one point, your fallback
code will still work :)


Corinna
