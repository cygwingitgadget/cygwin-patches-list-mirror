Return-Path: <SRS0=iXc4=UH=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 9F6323858CD1
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 11:44:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9F6323858CD1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9F6323858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736941485; cv=none;
	b=B+W80JyTKizmjLLL6hk35rIh2MkBWTsefd0DQcgAFgFACOCZ3umH51i8/gfV3c7yfC12nIq7j3oKDox4WMyHpv3S0Yz3L6rDBqFm8NSlDMZh25xvSdMGmpdeKPgIRuwicpR+MUx/nTo0nairIMfgeJ838mh6gumv3s/Z6XU0K6k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736941485; c=relaxed/simple;
	bh=BHoaJADIIwoRl0i1LktMFMGu5B62cGcxocjvYQLgcrI=;
	h=Date:From:To:Message-ID:Subject:MIME-Version; b=ajp3zBsntLgtmQU78+hvP4dMTep1JETbXuyS1/j3CWbygp4WIsxlseel+458VFLO1vTvys7dypIFolsQcuc69NuFfHSIipYbsJNEhPSL88QEolzN7kRchu9ENY+V5awAot3qnUc2AZwrSjSHwUYVviCtH6UcsWQVeKGfhS3ubnI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9F6323858CD1
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 50FBosfi013588
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 03:50:54 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from mfone.maxrnd.com(127.0.0.127)
 via SMTP by m0.truegem.net, id smtpd1rdLmn; Wed Jan 15 03:50:54 2025
Date: Wed, 15 Jan 2025 03:44:42 -0800 (PST)
From: mark@maxrnd.com
To: cygwin-patches@cygwin.com
Message-ID: <5b57c36a-0cbe-49e3-977c-348fe8e773aa@maxrnd.com>
In-Reply-To: <2d113b48-752b-fe90-cce7-cf826c341f49@t-online.de>
References: <20250115105006.471-1-mark@maxrnd.com> <2d113b48-752b-fe90-cce7-cf826c341f49@t-online.de>
Subject: Re: [PATCH] Cygwin: add fd validation to mq_* functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <5b57c36a-0cbe-49e3-977c-348fe8e773aa@maxrnd.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,BODY_8BITS,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

I believe a positive but nonexistent fd passed to cygheap_getfd results in =
a -1, so that case should be covered by this patch.
However I botched the coding for mq_close. That fix plus anything else need=
ed per reviews will appear as a v2.
Thanks & Regards,
..mark

Jan 15, 2025 3:35:43 AM Christian Franke <Christian.Franke@t-online.de>:

> Mark Geisert wrote:
>> Validate the fd returned by cygheap_getfd operating on given mqd.
>>=20
>> Reported-by: Christian Franke <Christian.Franke@t-online.de>
>> Addresses: https://cygwin.com/pipermail/cygwin/2025-January/257090.html
>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>> Fixes: 46f3b0ce85a9 (Cygwin: POSIX msg queues: move all mq_* functionali=
ty into fhandler_mqueue)
>>=20
>> ---
>> =C2=A0 winsup/cygwin/posix_ipc.cc | 88 +++++++++++++++++++++++----------=
-----
>> =C2=A0 1 file changed, 53 insertions(+), 35 deletions(-)
>>=20
>> diff --git a/winsup/cygwin/posix_ipc.cc b/winsup/cygwin/posix_ipc.cc
>> index 34fd2ba34..3ce1ecda6 100644
>> --- a/winsup/cygwin/posix_ipc.cc
>> +++ b/winsup/cygwin/posix_ipc.cc
>> @@ -225,11 +225,14 @@ mq_getattr (mqd_t mqd, struct mq_attr *mqstat)
>> =C2=A0=C2=A0=C2=A0 int ret =3D -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cygheap_fdget fd ((int) mqd, true);
>> -=C2=A0 fhandler_mqueue *fh =3D fd->is_mqueue ();
>> -=C2=A0 if (!fh)
>> -=C2=A0=C2=A0=C2=A0 set_errno (EBADF);
>> -=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0 ret =3D fh->mq_getattr (mqstat);
>> +=C2=A0 if (fd >=3D 0)
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fhandler_mqueue *fh =3D fd->is_mqueue ()=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!fh)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_errno (EBADF);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D fh->mq_getattr (mqst=
at);
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> Sorry, I forgot to mention that the testcase also "works" (segfaults) if =
a positive but nonexistent fd is used. I'm not sure whether the (fd >=3D 0)=
 check is sufficient.
