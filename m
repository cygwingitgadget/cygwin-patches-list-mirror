Return-Path: <SRS0=R+fa=6R=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 0F43D385841C
	for <cygwin-patches@cygwin.com>; Tue, 21 Feb 2023 14:38:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0F43D385841C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTP
	id U9fKpUgDOuZMSUTmypmtIi; Tue, 21 Feb 2023 14:38:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1676990320; bh=Msv1FdLQ3AmL7HrBDBZhMDdwdqnSq7rjNXrg6+WpuRY=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=hMvursUMpnLyO6FCmmAqztu0AJdbjMgk5BsqQTuJxAsOQagKH5Wsu+u2DiDO4TnbG
	 CEgG4S27aA8/9e0YVfNAukD0q5mLjuaZqVDGA8d6aLc/C7M1mMWbfQWcPyRifABXKM
	 Dl9ksXsE9KFJLA0fQHFuwNv5AELJmTvMBY8WIKCZdTFOsv1j69pvwdF6tfbX6+erIi
	 VPlxkal0uCCIk1/8qRoNKhCk+kVWowgD5wwn0DFxql+H7Po21kutMDg1pmlyDY2MKq
	 jo9Y/M19bG5iIA3HKNQ2OrYpzf7fFxIcyLgnqnlQ/t2a7WlCjm+Kz/QBXuVu0Hy4RS
	 NJvS5t0TurpNw==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id UTmypFzUy3fOSUTmyppNmp; Tue, 21 Feb 2023 14:38:40 +0000
X-Authority-Analysis: v=2.4 cv=J8G5USrS c=1 sm=1 tr=0 ts=63f4d770
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=qfbqWCo9KFbHWd945IcA:9 a=QEXdDO2ut3YA:10
 a=OCWz5_UTjG4A:10 a=9c8rtzwoRDUA:10 a=yipANtDfiQYA:10
 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <1ebd89f7-eeec-c019-0f2f-8d71afd0c602@Shaw.ca>
Date: Tue, 21 Feb 2023 07:38:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: cygwin-patches@cygwin.com
Subject: Re: Copyright outdated? in Cygwin/X FAQ 12.6 and not addressed in
 Cygwin FAQ 7.1 link
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <6b01a995-96e5-7b46-3323-1cf348d25252@Shaw.ca>
 <Y/SLEH6/phijPZb4@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <Y/SLEH6/phijPZb4@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDlpNRDQP4glVj2JAIW2aAI+tFZAsD8aTfRgQlfkQbQ8G2U+ESJUhSuhTvAMo9warCpRtYXYQ7Uw9Sv3GincaHWsbKibvSsDsSRrunrZ/V8X/fw1HwG/
 hwehl3fQE4TQnP1gLOoxa06TBFdMtANZlVcbP89m5mP2R8QSJr59wCA2ma3W/YQrz9bTqZDC84SOVopcdE2q4VpSv2u7mNZ+VNk=
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-02-21 02:12, Corinna Vinschen wrote:
> On Feb 20 13:20, Brian Inglis wrote:
>> Hi folks,
>> [Addressing to patches as that's where we'll fix it, and not a general issue.]
>> Noticed that:
>> https://x.cygwin.com/docs/faq/cygwin-x-faq.html#q-copyright-cygwin
>> "12.6. Who holds the copyright on the Cygwin source code?
>> Red Hat owns the copyright on the Cygwin source code. Red Hat requires that
>> copyright be assigned to Red Hat for non-trivial changes to Cygwin. You must
>> fill out a copyright transfer form if you are going to contribute
>> substantial changes to Cygwin."
>> Has that not been assigned to the project?
>> And also:
>> https://cygwin.com/faq/faq.html#faq.what.copyright
>> "7.1. What are the copyrights?
>> 7.1.
>> What are the copyrights?
>> Please see https://cygwin.com/licensing.html for more information about
>> Cygwin copyright and licensing."
>> ->
>> "Cygwin™ Linking Exception
>> As a special exception, the copyright holders of the Cygwin library"
>> Is that the project?

> Yes, that's the Cygwin project, not the distro as a whole.  All packages
> in the distro have their own license.  THe above is strictly only about
> the Cygwin project license as defined by ...

>> [...]
>> Or does it belong to the authors individually and/or the project or the

> https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/CYGWIN_LICENSE
> After Red Hat stopped selling the Cygwin buyout license, Red Hat changed
> the license of the DLL to "GPLv3+ w/ linking exception" and handed the
> copyright over to the community, so the copyright holders are the
> individual contributors, most of which are mentioned in
> https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/CONTRIBUTORS
> The former buyout licenses had a pretty long lifetime, so it was
> necessary from a legal perspective, that contributors passed over the
> code under a BSD-2-clause license as long as the buyout licenses were
> active.  This time has passed in the meantime, so we don't really need
> the CONTRIBUTORS file anymore.

>> "Cygwin authors" collectively?

> The project doesn't "belong" anybody anymore.  The project has copyright
> holders. Those are the developers contributing code to the project
> collectively.

Thanks Corinna,

That makes sense and I will see how I can tweak the FAQs to reflect the current 
status, likely X 12.6 refers to Cygwin 7.1, which makes that explicit statement.
I will make and send patches.

It is still worth getting licence agreements and updating and maintaining the 
CONTRIBUTORS file to acknowledge the copyright holders, and give the project a 
basis for contact in case there is ever any need to modify licences, or any 
other reason to contact copyright holders.
Without that list, the project can not contact copyright holders, so terms or 
licences can never change, if the current sources or licence(s) ever have 
problem(s) for any reason, so the project could have to reconstituted on some 
other basis, or else abandoned!

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
