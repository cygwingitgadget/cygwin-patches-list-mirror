Return-Path: <SRS0=deyK=7U=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 902203858C00
	for <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 08:36:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 902203858C00
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1679992589; i=johannes.schindelin@gmx.de;
	bh=CYWXhwTe9lOSoSnC+t1laSdCzLRulDbC/UV/+aFvRf8=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=QBUK9OjIYlifhDt5Io5DFDcZWyLE/iWgW/3oRqiN9CZZMJZb3qR/uSsTnYWDgrQ14
	 CWGsOfo7FNIu2tohIAL3Rrtd71SEKRErxLLPWTWKIkOBu9xuFOEWqijHuIIDwYCoM9
	 TNJr25IBokJLE1wY9HoG98XT2c/pf2uVYLPKyURZZ+U/zP42m3gM2wgvlRBvnu4niM
	 6XOg0AH6/yJ1aI0tSVsst6c4hOSL2vaSvXFJCEwcUzQcoQCH9IJF3ac2LX7oyF3i9C
	 6UGIpcaH78T/3am2PpDGxXd+smMDmeOsUd9CDz6iztJiLdh8ePTSZJWWxJ2Jw4Qas1
	 iuPnPauyL02vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIwzA-1q0Ous3kB0-00KPgy for
 <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 10:36:28 +0200
Date: Tue, 28 Mar 2023 10:36:27 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Provide virtual /dev/fd and /dev/{stdin,stdout,stderr}
 symlinks
In-Reply-To: <2526762f-71f0-2341-03cc-27f18c0c30f3@SystematicSw.ab.ca>
Message-ID: <c0814aec-3f82-673b-37b7-e7b20c9c1f15@gmx.de>
References: <cover.1645450518.git.johannes.schindelin@gmx.de> <2526762f-71f0-2341-03cc-27f18c0c30f3@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DUkwK4nLXCnCGeOxxYS9jv8V8J27TOFZmAc1cO/MvjTNW/pTTL+
 EMF5JXnAOO62vI8jzN+oibVIoKmhXDTFEveO+cOs+XZGobsVC6CEOZu7eH4SBIOp4N2dsjx
 HLVu61eiXB5baGeiRTLhYi9AwQp60u8tHZM3krDrVb9zACHze8PZRzXkKDrXQ/2QQFacWYS
 8QF0gznwkiY9d4V8TaMFA==
UI-OutboundReport: notjunk:1;M01:P0:htv8pZoLcrI=;JfFhJ5M+BGfAlVVNn66E2vbEKrO
 RXlKGa0CfCCMGYCKR1sx6+pMvm9+eBH4ViJzKMOIbwYTACxouzqp7ATesiKn7iTcxlIhmXjBW
 E/oJWAWMWUQK+EgBougDbr6dnuCVdMgGA15elekueipead6PnOtqVjcv9woNCijTZaK6zvYul
 aCy1+MVGyXjcDsClknDtHdKJv9QK4OSi1+J8FASnPwF3l8i6BS6zdVzp+ycwPLxyd1Y56gcI6
 mnzBRNBkMIfk7IvqmEN2ByPlGw6DqMvoE7S+Ue8y5aADh2YM3j7naspv6PQB6IGK/370NC4G9
 lOT92H/QZBVIvTsVSKLm1yGzO3PlbD51p0EzCSC7apnYte7vVa8fKpWt5hTwLVIeKsW8DF0b5
 eGYb3Yc0szHpgz+Fl+M0aUH6EkpRoaX9YCiiFz+k8v2f5vDw50/b3BlnUj9MwQapAr5ZaRgVV
 cQnJrUSM2AaO4L1fQelVg/zBRg6KqyJuo2XKVn1FpdbVGuwttLcT2gEf3FsOFvOV7woBrVTfS
 VnbGj//AFYlRmKnDyAQuJhVxt5JKK2G7qT1A7q/fXOLW6cXBacUGebZwu+1XMeCYzLZnvFli5
 v8zPBMjN1ynkyTPyZyf24UvVnRO3Sobig0oZaKLAbfojRArFd/aDWQLVvqxiJOa0ugSO4alpU
 bY6lvT4s97a/pIJXONpvdLEo9u4S2bj6tKrmJcNogGvg+J3AUDfUlnhiNVh9ZXRPtGW3jViCQ
 Xfe1jyyHQpmvPVIdzZrGs4A7I+RhDd0l7cvy0meGl6zzPva/DDAovnNBOWjnMe1FVC+VcpVhg
 KGlgIRY7rvBtZ4J6ob0EL02LN7HgVcsggw/vPjRdudWHoFSfzv7PTqMuZUsZF4OPDICydwQyi
 /BHhSF9UuYNFiO51BdYQGbTGFEkvGObtQuVbtKLns97YpOjin8rjIKiUaohINKw1ahDMGoEhP
 feOP5K5Vi/rJ4pXGraCxjSJ/8E8=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Brian,

On Fri, 25 Feb 2022, Brian Inglis wrote:

> On 2022-02-21 06:36, Johannes Schindelin wrote:
> > These symbolic links are crucial e.g. to support process substitution
> > (Bash's
> > very nice `<(SOME-COMMAND)` feature).
> >
> > For various reasons, it is a bit cumbersome (or impossible) to generat=
e
> > these
> > symbolic links in all circumstances where Git for Windows wants to use=
 its
> > close fork of the Cygwin runtime.
> >
> > Therefore, let's just handle these symbolic links as implicit, virtual=
 ones.
> >
> > If there is appetite for it, I wonder whether we should do something s=
imilar
> > for `/dev/shm` and `/dev/mqueue`? Are these even still used in Cygwin?
>
> Looks like that would make sense, as Cygwin appears to create all of tho=
se
> only on first startup (and probably rechecks if they need created every
> startup) e.g.
>
> Cygwin-32 $ ls -Fglot /dev/ | tail -6
> lrwxrwxrwx  1       13 Apr 29  2012 fd -> /proc/self/fd/
> lrwxrwxrwx  1       15 Apr 29  2012 stderr -> /proc/self/fd/2
> lrwxrwxrwx  1       15 Apr 29  2012 stdout -> /proc/self/fd/1|
> lrwxrwxrwx  1       15 Apr 29  2012 stdin -> /proc/self/fd/0
> drwxr-xr-x+ 1        0 Apr 29  2012 mqueue/
> drwxr-xr-x+ 1        0 Apr 29  2012 shm/
>
> Cygwin-64 $ ls -Fglot /dev/ | tail -6
> drwxrwxrwt+ 1        0 Dec  2  2017 shm/
> lrwxrwxrwx  1       13 May 14  2013 fd -> /proc/self/fd/
> lrwxrwxrwx  1       15 May 14  2013 stderr -> /proc/self/fd/2
> lrwxrwxrwx  1       15 May 14  2013 stdout -> /proc/self/fd/1|
> lrwxrwxrwx  1       15 May 14  2013 stdin -> /proc/self/fd/0
> drwxrwxrwt+ 1        0 May 14  2013 mqueue/
>
> so they would all get 2006-12-01 00:00:00+0000 birth time.
>
> [Looks like I ran something using shm in 2017!]

Thank you for that additional context!

As Corinna pointed out, the directories currently need to exist on disk
(so that mmap()able files can be created in them), though, and even if
there _might_ be a way to avoid this (which would be good, in Git for
Windows' context, where the runtime's pseudo root directory is inside
`C:\Program Files`, i.e. read-only) it looks like a bit too much of a
challenge for me to take on, at least for now.

Ciao,
Johannes
