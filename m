Return-Path: <SRS0=oqe5=IQ=gmail.com=lionelcons1972@sourceware.org>
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by sourceware.org (Postfix) with ESMTPS id 0F2684BA23C4
	for <cygwin-patches@cygwin.com>; Mon, 26 Oct 2026 11:47:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0F2684BA23C4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0F2684BA23C4
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:20::62b
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1793015276; cv=pass;
	b=OzlN+RpJUQzI2hHz3iNWn9bJLTgjXsKJ14YeS78gvIMCvNSMMK8tQUrlRIKROjo6MW+UEubG6kdUq1QKrV8q0juVdkf+uhKgIN0AezMGtuEcl2Ri7BYI72Lo/u+C27M4xc2N5ipc2X5grG0Trc9hkNR3ZtULBWb+E9egzh223x4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793015276; c=relaxed/simple;
	bh=FOrpi3jRDmua+hFa/Pcn0rhlWrSsdxPUA7KCQV/EGeE=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=XTve2uofqYmAwEMXg0x+IvbbSRtv0J33zzbB2KByUo8KKf3tgNZugtqt+lN//vh4UCoxUc+pcp/pe9C8u0/7M60b6iOhYqJd0tqHqXd4Qu7Mpu+vDxJaIICWcrNmc2IiI5Mgr5N2JNrOuM22rlzpjgSDI2IYSWxQnkKFzMRAs4A=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pKwHKUM9
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0F2684BA23C4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pKwHKUM9
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-c169ae1cb26so604063966b.1
        for <cygwin-patches@cygwin.com>; Mon, 26 Oct 2026 04:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793015275; cv=none;
        d=google.com; s=arc-20260327;
        b=qZ5lo+u7fO0t6MehD8xZ+PdEXtiq/z7TgFM+XRNXepWJawnGQvuKTG0l2UJW2lunc2
         p1ZIbYDT6qD7pU7XaQcGfZhJNT2IvVf7Lw1fF9uzfSzR5Ps8MCIF4BonjWHUqcNjammW
         QaSEDDBu3b8Dd4i91b4F+IgBPe/rnVrDgtbiRjva8HZz9Uv0yrnBE5vpxlyDyygTMUee
         l+l0jyNIbzRD+/bLT6fMToOoqAqYoYNpgs6KV0CWtgJ4FtZTmGdJMmXeEwUJm1zBBBjf
         4MAHOzvNPSA158ye1gkDrqhYRi6TkTXTcwVF4VydvcD52qGMArsSLL26WXJba+9qGfYe
         3hVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XWz2cFPfsjZH+FXnr7LkOpguMXAGrUqysE/uxBL2pjo=;
        fh=Nb6zW3qhuh4BrtxnYMC2bFOEZToxIRbOGxqfwhLVAic=;
        b=QsmBA5sINEvCts8J6ZifGKBwk5jAgFUf39JGDHgDaOZ/8rfBWqStrIgxongfQcdfIl
         jk7RSUA9Pr6Uffy+PghSroLOhiWxwOsTeLcwVuSEV3sTivt9Zkr4SLfNIP2IwXD+AL6W
         SoMkOteHpFj3l+Ri5xQpl7u0nwjtLL4sM0jaOcCqyDmn33yS1frw7fBd7usNNhCHOsbw
         iwK6aDWcfuGCuVBClRQBddBtTqriFJwKsugJTzoi+G8fXNwFVVgp4UuWOEhnOQPSYLSE
         2zrKj8gtZ9qKhwHDuC69c33g9vfyqXiPcPQU0yISGFvLUKUEpdfF5dUh4jA7xWV3CTku
         URAw==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793015275; x=1793620075; darn=cygwin.com;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XWz2cFPfsjZH+FXnr7LkOpguMXAGrUqysE/uxBL2pjo=;
        b=pKwHKUM9Bdl9/01AUf/0Usk7k+ny4jGwmMQeXAk0+YBaaNqsugGfpEXeuP6wkD3dpX
         toKM1iwyNraaeNp4cOhxqDrSt3ytMTnmq2jpyCUNOieQ1TUfk3FajOSpdwAyZPyyQFXO
         F7BoUB/8t4zevbCPjOxXz6iLQWjxhNu1XIAVJwju1h04jCS6Qh4A07LWY0qQynz+7fL9
         /Njz9vq3qx9EQGpOkaEl68zEeKu8QcSmaB3Hfe+UqsEAUYBIfK1KZPDPlyBsoGumrw7k
         3exWq6P2Jwkpe17iNMHPqIbM9XnHtMWujnSbJ+WZ7TUgm/kj2zB7W/mUf5hfKo+xxxuf
         lN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015275; x=1793620075;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XWz2cFPfsjZH+FXnr7LkOpguMXAGrUqysE/uxBL2pjo=;
        b=amw9tVzsG1mgNfAMx4otIty9yncWsEPePPlNmVhZi5dsNBAHTJBAKv1KPqVjmS8ehh
         7t0NGvDy5hSPHSWPQL1vYBUR3ouB30WwWnfaw0gFsTUhUswvIQVnd+h4VG5PmJj+1sPV
         0V4AXr8uVQa8F1ekZTasNB/frA+finSMOXa/w0DMqA2cV+Z6MOzF7l4NlUGQMfcOdcb8
         xEZ2XtD58ARZ5HR1OAp9tLxKhinHiE7DIy+yPc9X4PIe3623+fwiyMSYFkHmgNz5OmI+
         6LbjQ0SPGHij8UeF79EUQcWZen7ds+QEavG5wpcuL18Y2gTJeVqubUe96d/dfOkK9dAE
         j6zA==
X-Gm-Message-State: AFq9FYLl/zmFUJ+tl/aRczBn/Fgvti1knxzM4BaA+dknz8LKC/RtHkg0
	iJKGhEbrNMgEZFeQjoAgpGVbYimNzctrvszvq8EruZhVizlGNs1+gbZ3ZDc/UyvtOEVfEVNrBfv
	JpR8R1IL1TAM6ZMr/YEs85jC7PQK0FjLZHOt5YXI=
X-Gm-Gg: AYBFou3WgVQzCIICbfN5WITv8FqaVMuMPX5TY7i5Yx8XsR3xXNy3dVB4qaAomnoGkEN
	o+N2DKrmZl+fLTDk3DaccW9TVt8OzFl6mWJ0FF0u27EsKH4LFsIFgNTWujwVStPpIzz07YC+AvZ
	/Lh9UuLgALfuqSxd9krV5YlZlUsb8pTUHvtjZOpfMuIRn+QJjANPEM+tGyk5j0m1lxq1xQuxH4P
	TrpJJDASAgCOpTJdZzWFZZpTAPg9vk0os2QYMO1CgtVOzcegml2GKAAm3lcjWc8AE4DmMZYXErr
	N7MPRmV+Re4xhIKtUngxY7naRf4YBIjCYWDtoensSIpoBzr7CJJ7NUY34FDpr8pEqPJ5UDixcxz
	aRxdIZ97tDXimALnduwc+wMg52IIntjYkFab6
X-Received: by 2002:a17:907:3e8d:b0:c46:7fa4:9212 with SMTP id
 a640c23a62f3a-c46be5e3d65mr880814166b.23.1793015274580; Mon, 26 Oct 2026
 04:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260920035524.60008-1-mark@maxrnd.com> <CAPJSo4UaKfnUZCB1zjYD1mVXzUcE38c+e_Nu2QTXH0VJUg_k0g@mail.gmail.com>
 <162a3cb8-fdfd-47bb-9bed-4f7b0621743c@maxrnd.com>
In-Reply-To: <162a3cb8-fdfd-47bb-9bed-4f7b0621743c@maxrnd.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 26 Oct 2026 12:47:18 +0100
X-Gm-Features: AclHuK-qlz35QjtMXtQ8Zgw9hUWEfH2GHtgCwGCdq-5C96qq_Ew4AQ0QukIZb80
Message-ID: <CAPJSo4XtD0n8+Jjk=BXjZwCwo97mOcUp-7Zw_cVHnd=eoSgK5w@mail.gmail.com>
Subject: Re: Porting "Cygwin: Handle uids/gids correctly on NFSv4 filesystems"
 to Cygwin 3.6? Fwd: [PATCH] Cygwin: Handle uids/gids correctly on NFSv4 filesystems
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 14 Oct 2026 at 09:49, Mark Geisert <mark@maxrnd.com> wrote:
>
> Hi Lionel,
>
> On 10/13/2026 11:24 PM, Lionel Cons wrote:
> > Can this patch please be ported to Cygwin 3.6-branch? The scope,
> > impact and risk is clearly defined as being limited to NFSv4
> > filesystems. As the current code in Cygwin3.6-release does not work
> > with NFSv4 filesystems this patch would fix things without impacting
> > anything else.
> >
> > Lionel
> >
> > ---------- Forwarded message ---------
> > From: Mark Geisert <mark@maxrnd.com>
> > Date: Sun, 20 Sept 2026 at 05:55
> > Subject: [PATCH] Cygwin: Handle uids/gids correctly on NFSv4 filesystems[...]
>
> I have no objection to that request.  As 3.6.11 was released just a
> couple weeks ago, you would need to run an as-yet-unplanned pre-3.6.12
> test release to obtain the fix.

How does that work? How can I help?

>
> I'm checking off-line to see how much further the 3.6.x train is planned
> to go.

Cygwin cygwin-3.6.12 was tagged, I PRAY there will be a cygwin-3.6.13
with this fix,

> I will backport the patch, if I can, after I get the answer.

Thank you!

Lionel
