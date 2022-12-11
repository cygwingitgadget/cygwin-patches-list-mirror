Return-Path: <SRS0=JC1T=4J=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 32E673850B2E
	for <cygwin-patches@cygwin.com>; Sun, 11 Dec 2022 14:45:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 32E673850B2E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1670769946; bh=SwOezWPErKufmYH0X7m5gDxeyloflNt5Zqnz8wuBeDI=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
	b=hiAtjcUN54GQZYdVgrrXA1LvXyT2CG6lLn/8fX8scUyOb+Q6KY0LxLlFAFJTxjV0S
	 S3hKGEAI+Fx/O5dgDUQrZB21nsvqnHiHZWzDk1R04dHODS8A7PcpZunry3QZWSo3CS
	 9F21A3DL9GuTMuqgyb+1jmtEwq5PlBxLHbV4ZcFWk+8+mjPpvQyVOkFCY0wlcytfMd
	 U7VII9iBted7iHGioPErwfOtteD+FxCB6RummW/WqWKn62OJ1CIkMTYnAyeQbSXV5s
	 U13jmGB6MyqLP30NNxtOsYT+GFbXMAYwRx6GEQww5yGJGcBe4YmIzTnXjlUnnP5vgH
	 VE2uk3Nd/qTOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([89.1.215.49]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1p6IKJ1IBV-002YLO; Sun, 11
 Dec 2022 15:45:46 +0100
Date: Sun, 11 Dec 2022 15:45:43 +0100
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jon Turney <jon.turney@dronecode.org.uk>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
User-Agent: K-9 Mail for Android
In-Reply-To: <9ae73a17-051e-b577-ccfc-a33c96076390@dronecode.org.uk>
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk> <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net> <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de> <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk> <f2942e0e-ea5e-7ba9-8770-b422628dafad@gmail.com> <a2e01953-f6ef-cf08-f6e1-0c7632391ede@dronecode.org.uk> <Y3NuGWbczdW5f+rC@calimero.vinschen.de> <8a0287ed-6f20-4a05-b584-966bfded6833@dronecode.org.uk> <Y4TImGsIsHnJya3W@calimero.vinschen.de> <5spqn8n0-q9r4-48r5-qo91-0o4qs27358s1@tzk.qr> <9ae73a17-051e-b577-ccfc-a33c96076390@dronecode.org.uk>
Message-ID: <769CE863-866A-4E6B-A7D6-8EFA09B5D9F8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lcy2ql14dyh1A7FUmdDBXLQtV+8IGSMa0JW/mOmDA943Vi7+pl2
 pnNS1KjuI47D/ghGM41Lquxl2zeQ1DW9Vzwx8ufcOY6ODyV93Jal0geGFAOm1X9i6Z6CCXC
 Ue1TnzvVgfeUsUcf4S8zWrd5xIkhVBMO11Q708za/yEzNZfn8eQRk1AVKfptIn/n+6Nek5u
 txCEK3Q5DFUsUabwbVngQ==
UI-OutboundReport: notjunk:1;M01:P0:unB29w5Md+Q=;Bjom0DNTWwwn3iGUH2EWet4QA6M
 /MREMb7ZCp+ocwTBXIto3etLRi3Qo0v8sHdfFxzVjY7tMVH/1LTDX1pHQjgX4igjV3JJWNjS3
 M5gTwbo//6ZZvNuK9KnpyEkDG0RGC1LICtlIyyZV7EgPNUylLXfezLKt2utWRdpwk3FiujQDa
 EmYR8/FEmVNdlBMFTr7Y2TzBE5n/qHxQZz+GbsZSiXGNTj3j5MPunsAhmcR7JOSIabx0NftWw
 tC0MU2rzkWCuovfMht+pD3pah/RJbtuRm2EUsaWrzsBAVn7SO0KxsDIcHL+c7S5Q9NJL5+KYx
 XNsjyo78cfrIRXzfKDuLpSl7lragosA7nQWn1tMDtUtdaitF6DJaodFsAGGUJW4qJIctcJkVJ
 XwibeOJUznDMiq0/8x6iFIvlm8wNAYXL9UMaRIRQvcCqM0fVTAf3tYMGG1nphTnizDR9CI2WR
 rVTfyAvFrtG4OT72r/eCoI6yl3APWgckXbDW8YnIzMI4UoU5+euFC3FNsmY++wDExbX+aPuhh
 nEV4ECRwOfaE5dxNN+nxUdIBhwfxZS64fOiz068Gznbk+OVhXnWAMeb3SlIoU4CDlQrY5b/7v
 yQu6HTror8SlfOI1iWkrknoBsp1+EMP5IiTegHti6H7cXoVJie5kx3B4+NyG1IcN0iONxhp3t
 6AxX6ZNF8eBYRA7Wujm42Rai+D9IKu0HfJA4TxGw7GG7vRchwObUZRe97upPl3W3y7eLLg7CR
 hX924Ak0cX55k2VBgr3Tz86Yh5sV5liq94ygQfIp1YRN8NDM4zxIo4cO3bccC1ZybbwzoZIhS
 lENjaI72YWSikRsPYWlX5swCxeh6QKscdqPlJ7EKVw6Pr/co56nx2YGkPl7nd9YGDKY3jSGj4
 PHnMTWNZvLb30KiBuo7tLjVx0FPHwhWY0L3qeNpDrmDjwY+8a9P7DmNoK+qCPVnw0fJC7zdFG
 I2WTBQ==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On December 11, 2022 2:54:02 PM GMT+01:00, Jon Turney <jon=2Eturney@droneco=
de=2Eorg=2Euk> wrote:
>On 05/12/2022 15:23, Johannes Schindelin wrote:
>> On Mon, 28 Nov 2022, Corinna Vinschen wrote:
>>> On Nov 28 13:00, Jon Turney wrote:
>>>> On 15/11/2022 10:46, Corinna Vinschen wrote:
>>>>>
>>>>> It would be great if we could get used to using the same syntax as t=
he
>>>>> Linux kernel project to document stuff=2E  I'm trying to follow thei=
r lead
>>>>> for a while=2E  For fixes to former commits, it looks like this in t=
he
>>>>> kernel, at the end of the commit message:
>>>>>
>>>>> Fixes: 123456789012 ("title of commit 123456789012")
>>>>>
>>>>> Yeah, core=2Eabbrev is 12 digits=2E  I'm using this setting for quit=
e some
>>>>> time locally=2E
>>>>
>>>> Sounds good=2E  Is there some script to automate generating this kind=
 of
>>>> comment from a commit-id?
>>>
>>> I don't think so, at least I don't see anything like that in git docs=
=2E=2E=2E
>>=20
>> It's note _quite_ what you asked for, but `git show --pretty=3Dreferenc=
e -s
>> <commit>` (https://git-scm=2Ecom/docs/git-show#_pretty_formats) gives y=
ou
>> _almost_ what you are looking for=2E
>>=20
>> But you can always call `git show -s --format=3D'%h ("%s")' <commit>`, =
and
>> even configure an alias for this:
>>=20
>> 	git config --global alias=2Epretty-print-commit \
>> 		"-c core=2Eabbrev=3D12 show -s --format=3D'%h (\"%s\")'"
>>=20
>Thanks!
>
>I added '-c core=2Epager=3D', but this is what I was looking for, to save=
 a=20
>bit of copying and pasting and editing=2E
>

Better use `git -P`, then=2E=2E=2E (see https://git-scm=2Ecom/docs/git#Doc=
umentation/git=2Etxt--P for full details)
