Return-Path: <SRS0=l5Hp=4D=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 39D6038AA245;
	Mon,  5 Dec 2022 15:23:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 39D6038AA245
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1670253809; bh=HLyVQukMAysTnbvVip7GUI0LMr8Np4vaWc6AoCs57QY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=R544N0squxIM+zgtwCdbR4fIvuT1ogGEbhT+IRps44LGnX0K36qNLX6L8lsR5rZ0c
	 KNDoFIZP7SnyU5JfLWvkRdqSGaTRxES043ONmOVhapA0JgcZrfXVyk9Mp5spKzX1wm
	 7lQtXvlehNR0maiLvs6nrDWQA7Df6iioXKFGIuKEGy+Mrd2i22L4R5wdslPKEsEphw
	 r0BDAkKY7pX77Yyx8PApfZsEK01D3T+2EFmVnXhaZROEk0mqaqppjfN35wkUwQHGYq
	 f/mq9fOd5MsxlgergnQIgjLgps3XUHVhN9UzrnCjngFoLH5pq7QVRWLQHXzof6rHtx
	 kg53o6grsvfwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.24.155.134] ([89.1.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1pHOv53aqx-00Keol; Mon, 05
 Dec 2022 16:23:28 +0100
Date: Mon, 5 Dec 2022 16:23:27 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
In-Reply-To: <Y4TImGsIsHnJya3W@calimero.vinschen.de>
Message-ID: <5spqn8n0-q9r4-48r5-qo91-0o4qs27358s1@tzk.qr>
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk> <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net> <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de> <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk> <f2942e0e-ea5e-7ba9-8770-b422628dafad@gmail.com>
 <a2e01953-f6ef-cf08-f6e1-0c7632391ede@dronecode.org.uk> <Y3NuGWbczdW5f+rC@calimero.vinschen.de> <8a0287ed-6f20-4a05-b584-966bfded6833@dronecode.org.uk> <Y4TImGsIsHnJya3W@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nZsp0OiQ+olLqmyAJe5aatlOKKCCjcDe6llDjO8DFf9GaR5yXwz
 7niyZocpb8hydnMfVLRfM29YU9utlQ8XDXg6hV5o3NdAol6KyYsbsJNf6t4gGLMbgFupbLV
 I90bibOTgPDGIHPgClh8gBs/JCjAdbDY+FoNXWBsR4o/FnKtvhYK9kvMNRrBvqmXcqzQfJe
 80ztn/V+E9XG5wA3bZ0JA==
UI-OutboundReport: notjunk:1;M01:P0:FC9AywtYoAk=;woq0FCcdYZScI5Q2va7zpmZWPtD
 LvQhDTAMEs0fLgbSdHDvcoTWkIC0K+UmyKA5/GyZych8TS7yHvzNz6T8k5fIk+siuFLqoS+Ez
 sgguQJCFCrKLmCHuyelK3IA7He08PT6zjwVbiFipr8OTOsDmoA/tfWnqgcwfJpP52ba7+0XCT
 Oel/XuTZT2kXGrZZI6qL2Vr1mGjwVGYc039ZMXA+nIPgdwBcNatXq5FAnMTowQAPomOdTuqLo
 OdKhUuT0PlgWb+EZ5e5r2hltyHadYVZyJEKG1qSR03U2eozq8sFPeLr8EQzfPg2i86GiZFvqW
 jrhe2r1pZThIA0K5CarS7kN3rs1L7WOQjG/WmgbgQr8fiTNpAG8NVqz/rVV+6XeEr+wtKFz0o
 CGZCpnc37evsTEjWtWJVBtjMGMrryO0k2+WZmiyuoytH6eYj/zXYqzWFDstt9jUII5LAuy08T
 qlAPWH2zvoObKE+wcrxoqYdjSOSit5/tymIRQxvATFEKecgRI2qQklyGGCdwDc6v4eQG2YmEM
 k6F00q+RupyAdwmfjdRUf9xG5+Sw+YGLDhn6FTq98z+sUTNPBjYjgKujmGj2Fq08Gde/QZ0rw
 HmNMhYK5gUynlCxlv0qcxbH4gyqXYRe9aATXh3RBegiwO3baauD90EJFCbbkzj59j0GAkFZx1
 bXaDbOSWckK3lKI7nYZ5A/njVvDjhSec3XgfVbwZCIuKgk/PmZ0UtUY0RJG2E5S844AHSncd2
 pV64VqPoQlTzYy0T+9Rf2IMKDy8OQhRsnIBBTPFZb0k5q4fImi+wGYLQUS7TK3F4KHq1sRR7O
 9dbAuwkBV4J9NGJfUCYTB8+N0jNOthouYdANDHCxmdIAh0lv140TDo1rJFaXGZpLi1jBoNeCf
 G73kN/uExyy2DAE7C7mKSifYlL5nBA636LEy731YA1cI38RhBC394nQKRv9L9Qpd4rcl20Di+
 /zZ++yVOBXuTkiYIbtKxPaHFOrw=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi,

On Mon, 28 Nov 2022, Corinna Vinschen wrote:

> On Nov 28 13:00, Jon Turney wrote:
> > On 15/11/2022 10:46, Corinna Vinschen wrote:
> > >
> > > It would be great if we could get used to using the same syntax as t=
he
> > > Linux kernel project to document stuff.  I'm trying to follow their =
lead
> > > for a while.  For fixes to former commits, it looks like this in the
> > > kernel, at the end of the commit message:
> > >
> > > Fixes: 123456789012 ("title of commit 123456789012")
> > >
> > > Yeah, core.abbrev is 12 digits.  I'm using this setting for quite so=
me
> > > time locally.
> >
> > Sounds good.  Is there some script to automate generating this kind of
> > comment from a commit-id?
>
> I don't think so, at least I don't see anything like that in git docs...

It's note _quite_ what you asked for, but `git show --pretty=3Dreference -=
s
<commit>` (https://git-scm.com/docs/git-show#_pretty_formats) gives you
_almost_ what you are looking for.

But you can always call `git show -s --format=3D'%h ("%s")' <commit>`, and
even configure an alias for this:

	git config --global alias.pretty-print-commit \
		"-c core.abbrev=3D12 show -s --format=3D'%h (\"%s\")'"

Ciao,
Johannes
