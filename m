Return-Path: <SRS0=deyK=7U=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 2F1B53858438
	for <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 08:26:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2F1B53858438
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1679991977; i=johannes.schindelin@gmx.de;
	bh=A5EshyhmQxK9+Z9aiCpPgXTARxpi3Ph8ZEdlx61ImS0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=lgNnVKpW5S4BkBiU4Ib86qJnd3KhbFsslhKfoL0Fms36ucJVwO0EYUe15umHOCDam
	 +oaQ5Jy3eAhmK5zzgVlszqCvGs5g3rFyi501ZWTS6xA8p17qW57AyX8MLDwjMar+qX
	 la6sh0zkXKhNHE38opwUlwnKufu5oHK11XF8o69AOanicP6O2kv1R9u6hvhwZq/qH0
	 MzgeBU8K1iKCx/feYprGap0Wrjulmgyjqds+gEPUZSbdDxzEm1xbkTkvKVGPkawiVo
	 KTmLK7VDBu8iBMzRDI5p8rVnQFfAwg4Garu32EVN3UrGOKVZpRB9MBZ64snmAa6NW+
	 JQPo0Nc2OlJug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1qBiVV3TcW-00mZO4; Tue, 28
 Mar 2023 10:26:17 +0200
Date: Tue, 28 Mar 2023 10:26:14 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
In-Reply-To: <5de5fda5-b43c-affd-2c61-ad9986c1bf96@dronecode.org.uk>
Message-ID: <2f5a2bb0-f37c-ca90-230d-bf8b3557e849@gmx.de>
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk> <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net> <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de> <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk> <f2942e0e-ea5e-7ba9-8770-b422628dafad@gmail.com>
 <a2e01953-f6ef-cf08-f6e1-0c7632391ede@dronecode.org.uk> <Y3NuGWbczdW5f+rC@calimero.vinschen.de> <8a0287ed-6f20-4a05-b584-966bfded6833@dronecode.org.uk> <Y4TImGsIsHnJya3W@calimero.vinschen.de> <5spqn8n0-q9r4-48r5-qo91-0o4qs27358s1@tzk.qr>
 <9ae73a17-051e-b577-ccfc-a33c96076390@dronecode.org.uk> <769CE863-866A-4E6B-A7D6-8EFA09B5D9F8@gmx.de> <5de5fda5-b43c-affd-2c61-ad9986c1bf96@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XUaYNSLDq3HwXBy5Y6niRAjfDwE8IjPfelygrKYQxQdVRJSC3oY
 NUmZIPgq5mZ6XwG1fRuvtoiMM4oI8YzgAYqK30+N0OJChg8v2nwa7gCu/0t3m1HdVF5RbkJ
 d/fATIkA8zUbE09Kr27CsOnzLpClQeNUy47pc9vPQKqs1SVdM2rBPoZ7QbZGzOSiOHCRWnE
 BFBifG17jTuLp89k4qsZQ==
UI-OutboundReport: notjunk:1;M01:P0:BJzDSlQnxIg=;8B1lNDlIrmDKYwh/0+aoos6u0/6
 ZD8t+cBi+eecCD73+FF8CNDzxsU4mOxgr2fGhecAAbAhjXjeQvbVl8tYpGPpXXxdfnCdcrgzQ
 Q0OkAqfADBjEHu7a8TslSMaCr7g46/jigS5jpwPSw/fXhTZOt603BqY4x/mc13GroA5wyw1vB
 byxnPzAggZhIWK/lBOuJ+meJse7ujI8DH1CEr1FGuJZeJPIj1KmvZeuPpxliV3lUs4Dfem+Co
 p77mzZl9WetM7nvzw+ltgAo4OJFEoF7L1mV7lLQLVMqK9JWolowMbbCvB5fkUOxoT//jzvtPA
 SCx3JsaTq+c4JlLaC9lxunpReeJURnE1hUrhxK7JcrjRcJKMqUO+Xb25UKSzAYGd9RCkRodwu
 ctKZSrmgTJgXd6t1Rck1AR7GXWNdqgUtmV3XonNWeT3BtdaOkCF/MK8nXYm0biDmRI93YvrYv
 7YsMCoHAzjho4FrXMeBfckH4o0jHT3boJgaLRSW2WeJrn/Dt1QupJWUwa8tM+XragoIxUY4Pl
 +ydJkxMVT54uKGHBWm8i1+bYi885aoshdhwsu7YIHrmvmQ4jAI5dMIALrciYpm1mEWDeXiBS9
 zF0Sd1DoKP7ty3hDYvmwEj7LALa5F0b7sA66d0C8R+wT9Q4+yuPt9lbLFNanyh57NpmT0FTYe
 pjduqd2oTtY2YcAKuShefbvmebSVKvCJgIwRp9k8e1wq30AnFLW9hISqgz9HKWbqozYvpnajs
 4BRTcR0wakjuhvZCMfWCS22YLv+MhM8oZMJNxsSuFGMD6uxPjEQqQY0GdAejI/p/7UrcS8p0o
 YzJY8QIgdRiftZILmlEQGhO2JHkPAktxs2mtfGeP428AEDJ8SeIGrhk5jsqPgAEMhxhU8184o
 7kfCdGojbeEM4fY9it/AIkE55IlzG/nEq470FNOrpzytd6dMMiEInpxcVR/rsRONt/9lqhlKr
 PqttRki81ZhEt/EepXcvDyeVG14=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On Wed, 14 Dec 2022, Jon Turney wrote:

> On 11/12/2022 14:45, Johannes Schindelin wrote:
> > On December 11, 2022 2:54:02 PM GMT+01:00, Jon Turney
> > <jon.turney@dronecode.org.uk> wrote:
> > > On 05/12/2022 15:23, Johannes Schindelin wrote:
> > > > On Mon, 28 Nov 2022, Corinna Vinschen wrote:
> > > > > On Nov 28 13:00, Jon Turney wrote:
> > > > > > On 15/11/2022 10:46, Corinna Vinschen wrote:
> > > > > > >
> > > > > > > It would be great if we could get used to using the same syn=
tax as
> > > > > > > the
> > > > > > > Linux kernel project to document stuff.  I'm trying to follo=
w
> > > > > > > their lead
> > > > > > > for a while.  For fixes to former commits, it looks like thi=
s in
> > > > > > > the
> > > > > > > kernel, at the end of the commit message:
> > > > > > >
> > > > > > > Fixes: 123456789012 ("title of commit 123456789012")
> > > > > > >
> > > > > > > Yeah, core.abbrev is 12 digits.  I'm using this setting for =
quite
> > > > > > > some
> > > > > > > time locally.
> > > > > >
> > > > > > Sounds good.  Is there some script to automate generating this=
 kind
> > > > > > of
> > > > > > comment from a commit-id?
> > > > >
> > > > > I don't think so, at least I don't see anything like that in git
> > > > > docs...
> > > >
> > > > It's note _quite_ what you asked for, but `git show --pretty=3Dref=
erence
> > > > -s
> > > > <commit>` (https://git-scm.com/docs/git-show#_pretty_formats) give=
s you
> > > > _almost_ what you are looking for.
> > > >
> > > > But you can always call `git show -s --format=3D'%h ("%s")' <commi=
t>`, and
> > > > even configure an alias for this:
> > > >
> > > >  git config --global alias.pretty-print-commit \
> > > >   "-c core.abbrev=3D12 show -s --format=3D'%h (\"%s\")'"
> > > >
> > > Thanks!
> > >
> > > I added '-c core.pager=3D', but this is what I was looking for, to s=
ave a
> > > bit of copying and pasting and editing.
> > >
> >
> > Better use `git -P`, then... (see
> > https://git-scm.com/docs/git#Documentation/git.txt--P for full details=
)
> >
>
> I started off with that, but that fails when used with:
>
> fatal: alias 'pretty-print-commit' changes environment variables.
> You can use '!git' in the alias to do this
>
> ... which I'm sure tells me the right way to write this :)

My apologies for leading you on this windy path through Git's obscure and
intricate internals.

The problem is that the `-P` option claims to change the environment (see
https://github.com/git/git/blob/v2.40.0/git.c#L176-L179), and aliases are
not allowed to do that.

You _can_ work around that by using `!git -P [...]`, i.e. by forcing a
shell to be spawned that then spawns `git`. But that is wasteful,
especially given the performance characteristics of spawning processes in
Cygwin.

Therefore, your `-c core.pager=3D` solution is much preferable to my
suggestion to use `-P`.

Ciao,
Johannes
