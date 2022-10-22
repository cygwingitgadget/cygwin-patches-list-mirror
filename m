Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 83A773858C2C
	for <cygwin-patches@cygwin.com>; Sat, 22 Oct 2022 05:56:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 83A773858C2C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1666418158;
	bh=/riQ31UE3/ClvnTuoCAK73LgLFQMhmQgM6EtnRVzrVA=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=iNArRPs87a4g6mn+T4my/8gjlhDrLNBjbRmzo1uDryEMqFjlwmRUNmqcMW1WQS4g3
	 z+3hO4aNnv2gEQ0TXxJgLaKYOa5Rxcel5o9KuylN6d219lrTjM4P0UgPSBzFQn0DTh
	 ycX0Pn/h14aUtDoRefZHHZXUo+ZUFOhHdbgonKkk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [127.0.0.1] ([213.196.212.100]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1of5FP3brO-00TFCO; Sat, 22
 Oct 2022 07:55:57 +0200
Date: Sat, 22 Oct 2022 07:55:53 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix `Bad address` when running `cmd /c [...]`
User-Agent: K-9 Mail for Android
In-Reply-To: <20221022143709.b54643c7b29b3d6260382e85@nifty.ne.jp>
References: <8rqs6n82-0oq9-2200-944n-74s7o699385o@tzk.qr> <20221022103639.0be6d01709fc99d06b3d0d41@nifty.ne.jp> <20221022105406.12f2c65e497e80df4014a8fb@nifty.ne.jp> <20221022143709.b54643c7b29b3d6260382e85@nifty.ne.jp>
Message-ID: <9E4B94F4-2E88-4B95-AEB0-24B083662D32@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sSOlZfQr0D6pZyD7QNtY7BV6HalCLMnZLqgSZ/Tyr6llvCVjnZ8
 Glh2oOM2wBpYZry26g3uOqMbKkGhKQicaI9Sog12GGzV5uV5GrESw51dkQxpsQAspK3g10h
 N9nFDLMSp9lYzNQ8+T6Kj5Jp3xWLqoMguQox4Qz0ZgE3E0NpfRpTWub6w+o3WP7+gBWzmnP
 DthpBHECgOf1jN0DisVzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7F+gYMlUdhc=:T/3b7xjRZ10pR/Hws9dKK3
 tut4mzMRFfGA5G5UG6Lmi8eyg95a+JkhWpEtX++0gYqv6YtD6pOa/EDi+7a+u/abLGfvsJCS4
 lKddHPWdHhQp3a3ZqE/3h0+bgwb37+5nGRzkuwzYPu+Lp7O5bMDHYcnHrBJtGTHIO/zcaEmu6
 6uE7pU8RbhrCBSXDnC8bBhtyDmpQeLBAwVGRjcBptre/zo92PCvgpJlB8HeUj4qZ5VzZIQtgI
 lym44OC8KKfiPjC2AQEoWY+b+ISFbtkjYXHjcpOLt+iOHsImrarCaU1vVRmBmLR7xaBWgu+zG
 DGgS1D4yKIzXyFaxQ3X4VNSR06Pj6SGQckZNEtvMi5+g7zgwO7SCiOoNPBI7f1ZdANQMSx5N9
 aJEsVZYrHD+Ae3JdTemmEAmonypqgMX7qpFlp2hUHQho2xEAKp4kXXGdsb28kevtTaoOvF/v6
 5pYMc8NkDOsKYXnKlRk6N2QmHWIwR53hUtf4ONSA2dQd5fWZ+4NZaB6hEJsT+xw/R+m8iWhHD
 dxOXLx4xxciA/XoQfbRIAbJmHxm/2bcKI6MofXLxcFB4lvp+5BmpNXWpeFXMEBzMAazuO2w6A
 mGb4qsHfN4BaNg7gc9TW3nPECaIVM9a56la7gPazforFgbO+2sxBcnOZubUMNgz7EcC7jVK8k
 Vo1M4e3337nlywFIvvmX2bR+GuMje/GYKfS/3Vy7iIDd6ph4f9tVP5M0TpfqemhOZMNiFwKHw
 7749DMhzJWdvxMYi/c6hRdOcP6OTRqkIr0CGPQlcQwZmxkgT1s7LLSAyZ4lnMdI/XkzT+hzEJ
 cqDzLdcMsggb52BMoGUVlcvXVY+rIXQUrDr8sNCPwdZ/0rMQZhc/mY/WPuIxu3LzYwza2KH8b
 l09u/veu0kAlkWT+bOghyw3l7YrfDvPT8zz1wh2VtfVVBZ2JjGfaAB8rQNL+IsN6HI+U52dbx
 9LLxuzdKEP+bs6vS1Ygo4FTk218hrIxDaGuY0cP3BFN92IwXkLu1UlxNAGkGjSB2IPuKt+e07
 hnGEzMrQXpQbKSjdHE85eSAuQcNMEA2Hghuz3Wp9pXi3dvlk62j93LTnTBxWHl4vvPjcu9eWq
 EJhur0HcdHXzmKwQ7H6mqA1Dr9kTZNCLvbTdn0CScJJPzJRv6xapfLgnTuuB5b+bjHhk42ahL
 oT3nfWPjICrgXzuVLFPCvM5TUsg/PmLsEYGsOST2xAC/sGpA5IhINZ7UdpbJFcucA5nBZBAWQ
 QcEkBQ1df6NduqjTU4KwKP/CY+1sIChfTiU7z3QWEcle2+OAY77BPmRUedsC+QrHNoLJ/IeeI
 VFIDnONAvxEcq/mQvlRbPaJMpGVu9zxq8F9yxSRL2JECDz8u5Xq+5O30XUAVkPXbVEXPd752+
 cBqO1LWVPZz+uQezDQ64alOwKpzqo9WkeJppNCPreeXGntXesil2qlkiOLFcOJczKgpIjtbuQ
 iSncqIfVyhvRS9h7ImJwyLPf3gRBMg480eJ55M/LgaUvfBdwDEEBxn7QJddPgKxlz0JkZEB4L
 u7fqIEnRmS3bnCfLHYYNj7TLG51kIXGkteznfdyCke8M3Jxgo18XX53Gl6fCijB/Ulw==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On October 22, 2022 7:37:09 AM GMT+02:00, Takashi Yano <takashi=2Eyano@nift=
y=2Ene=2Ejp> wrote:
>On Sat, 22 Oct 2022 10:54:06 +0900
>Takashi Yano wrote:
>> On Sat, 22 Oct 2022 10:36:39 +0900
>> Takashi Yano wrote:
>> > On Fri, 21 Oct 2022 23:37:35 +0200 (CEST)
>> > Johannes Schindelin wrote:
>> > > In 2b4f986e49 (Cygwin: pty: Treat *=2Ebat and *=2Ecmd as a non-cygw=
in
>> > > console app=2E, 2022-07-31), we introduced a bug fix that specifica=
lly
>> > > looks for a suffix of the command's file name=2E
>> > >=20
>> > > However, that file name might be set to `NULL`, namely when
>> > > `null_app_name =3D=3D true`, which is the case when we detected a
>> > > command-line `cmd /c [=2E=2E=2E]`=2E
>> >=20
>> > It seems that this is msys2 specific issue=2E
>> > I also noticed that
>> > cmd //c 'echo AAA' instead of cmd /c 'echo AAA' works in msys2=2E
>> >=20
>> > In cygwin, filename is
>> > C:\WINDOWS\system32\cmd=2Eexe
>> > for cmd /c 'echo AAA'=2E
>> >=20
>> > Why the filename can be NULL in msys2 in the case of cmd /c 'echo AAA=
'?
>>=20
>> I can reproduce the issue in cygwin with cmd=2Eexe /c 'echo AAA'
>> instead of cmd /c 'echo AAA'=2E
>
>I have just pushed a counter patch=2E Thanks for the report=2E
>

Thanks, I guess?

It's not very nice to simply drop my work, and then not even link to your =
"counter"=2E
