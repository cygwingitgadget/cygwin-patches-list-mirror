Return-Path: <SRS0=ok5k=HU=gmail.com=lionelcons1972@sourceware.org>
Received: from mail-ej2-x0d.google.com (mail-ej2-x0d.google.com [IPv6:2a00:1450:4864:34::d])
	by sourceware.org (Postfix) with ESMTPS id 5BF6A4BA9039
	for <cygwin-patches@cygwin.com>; Mon, 28 Sep 2026 19:24:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5BF6A4BA9039
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5BF6A4BA9039
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:34::d
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1790623474; cv=pass;
	b=quzPEwtaoW6po8n91tz0FWm6pF+sqE/ksEzk/1U1ZbCigtDfCdH/OmpzTEWn/r4dVmfD67qjwKip0IKWQNyrrm9oCHNGuuOBWWFupwoM6Q3pSxG8g0OjOi/ywzTiUnCmuAznzzdeSkHQc4sLRdi681i+zo58r8Oge51Z06AWs4w=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790623474; c=relaxed/simple;
	bh=bXpJerSVuxxN6l5dCq7ShkfXH6LJHM18YUJN/rl6N3E=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=Gdo1tYD6gKy494fIhNMIAUxRzecgMm/v/jxn7xOXeiLa14Vxa/jaueyCSKofAm3ybI1uma3T6E8ASuidVpAA05mAkDFenF8U13BwMrpL56yGnSzkcrEzOPP/7k74kqZHQ/c9syI6atrJeQZooHg7hc6cAcsC38avrWZGU7EOggQ=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NgqZ9RG9
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5BF6A4BA9039
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NgqZ9RG9
Received: by mail-ej2-x0d.google.com with SMTP id a640c23a62f3a-c2dc50c6edfso220120266b.1
        for <cygwin-patches@cygwin.com>; Mon, 28 Sep 2026 12:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790623473; cv=none;
        d=google.com; s=arc-20260327;
        b=nII8+/LTLDqLyMmaaUE5zpuhSy2OxBw8SvOjXIBIjLLHiR8pyy8HdwVUvESQlHRnZw
         AcXT497KkorpHIaXcehhagwl6A+zP21540pdKpZzWUOZRdgxUt/AZEAScSXo9iDtnpWE
         6y2hbeOr0ISmz8PDi7O6flcnXMqMyUHDGas5X8baZTztcDYmPD5/YZpRbErp75PDtFkh
         DBEQoLJ2VlWOlyq3Cy0nAfkecG3POwv011BQOa6lsQosAPv468kfhjHM3yUHVvHZagBh
         L/w2bRy4QDS8h/Jw5csS78Y4H9o0p0b8eAmrFFySSdexRme3IO3UBYkrij4ERniO+PVF
         qh9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bXpJerSVuxxN6l5dCq7ShkfXH6LJHM18YUJN/rl6N3E=;
        fh=A8sImovv95F9n6Cr4jr8ca6rFu75ODyOxV1cnZb1VFY=;
        b=QbPpxmIz50uFqzqK7ip/dj1kC391nU/c0uKp6RSW0C9yFWHGBlG3SMxjOxSRuiHJBG
         Z6FHaWDvAlhXBXoDtzwfyJcAKpG3/0NqFydThlGZnkpProHThVkO1F5wcjoEOU+h+Ha6
         uL42FP+hxAJ9mlL5p6j3+TWpERp+/FImYYeeY116Fea6+5F68JoQaeFC/MHLCjh9LA9L
         1E4XTXf+n/Ri/BvbXG5qqoOdXmqAXPLthPylEuY2Se2SxxwHo7wWd2RyBN3Xy1uu+9E6
         ZwW/pYR+SKxaBAjw0qpKoCD7q/aVvjhNcuntU60ZD9QRg8c0vsTboeF+zVUQHE8ECBrx
         GMWg==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790623473; x=1791228273; darn=cygwin.com;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXpJerSVuxxN6l5dCq7ShkfXH6LJHM18YUJN/rl6N3E=;
        b=NgqZ9RG9TdMCJ9P8/RmeNjNT4omMPTpYt3ho2N8eanE5xllXpbySlgvJJjfZEX87IU
         XO0bP4PTleRO+i7nMj6RE+bCaZ4cv3ABZMsw0/K0FJtuGYU1MjG2gwUIcQGYR3AImuWc
         WXtSQMZoqVRgCXb8P1OFYmcs5VqzLuyEapO71A+vNB5SSkrJ5Znm+cdC8chv7y5tJQRt
         0MSOKPC/pZgshb1aFFpBITwrDxr3LcTUyn19CFcJyH3INh/MHedfIi8j35I1bDsSWvzi
         PWXW1/2ZcspgahFhRtFTaJ3ikV9OFz3PjTakrRjjVviX4WjDgTpSNrOITWu/qv+qPRxr
         XbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790623473; x=1791228273;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bXpJerSVuxxN6l5dCq7ShkfXH6LJHM18YUJN/rl6N3E=;
        b=EvcVsb8MAvCTNWa7O0iF9aacPWgJasY64p7Ylq21aJnIUCHDQbgC8BfJQG8rPt6V+r
         zXzHi20AfJJUL+nWyVECMNgVZKTUjusTuWbV/H7xub4OxpFdVS8P2s1JgGpzZzyAfSIj
         DWVR9VhNojTs+yTGvzrENDQvwKBEU9rQLpZ1+xuI3hxVaRTG+PpDcmnFHKKRa8B1TQaA
         fzprOfBgpS3j82+firoNnJbqU4DZKkxaKcj49r0UlR9LpaLke62+eNH17LYTSO+1fEwP
         VkBE7RCGZ+6crTMTUlDlqJEYo89x+IU79E2yq3ygHhk+U4GnRl2NaMq+CqtOQthLtKT4
         b4Lg==
X-Gm-Message-State: AFuF++lOik2677gZRda8fJ/9uhHt9B5M8DIJ3bcA4PufuJvSDXwX611Z
	8FBb2oyub6hwZ2RFsKezSMNnx05ZS1OmjmgwaG0Hi36RGTFQ6kULjE5ezUL4EjmwwgtWYjxNFat
	p67zCkWtpLYmiBhpleqND3ULKx5KLifXsCSLD
X-Gm-Gg: AYBFou2E/a3aGRC2AB+3ucjscemO6EJjB+PA2Htm3pbw1pBfRhCCziUi1oCw2QCuWgF
	bkK3nd2DyklJo2qZsT9RhfsyXmint6e0nLiuR5DwcGN1zP2Q0NZo/rqpno/lwECsmTvFWZMo+uW
	gtcW4OQIVWN/jJaiGRYhq5qAFKnSvr4G8Mwynvjv/5sLt7Lysks+jruSwiUAsVAKZG5cIAPhxhV
	LdnJ5G3BuBbal3PhHFd9UxUN4ZanRks+hIerV/NvC8XGikyzKRobrv5WBHR71XmUMDhbXW1uu+/
	7MEVzkmfj0VEKP2sHhG/NHQCdnyGfib35uMCsPx2ocR9CCmxU2uF/nM=
X-Received: by 2002:a17:907:968b:b0:c29:f5d5:5a9c with SMTP id
 a640c23a62f3a-c2ac2454d00mr1176178766b.38.1790623472797; Mon, 28 Sep 2026
 12:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260920035524.60008-1-mark@maxrnd.com>
In-Reply-To: <20260920035524.60008-1-mark@maxrnd.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 28 Sep 2026 21:24:00 +0200
X-Gm-Features: AclHuK9bc1KiCKe4jx1N5TVbDPIRgs02n8sZ9ZUJjqBeV2PQlAmVFz2z9Or6gbw
Message-ID: <CAPJSo4UEuMKidYirkWwTXPKB4ePp-a3RgVKtQjhHS-ru0BnSVw@mail.gmail.com>
Subject: Re: [PATCH] Cygwin: Handle uids/gids correctly on NFSv4 filesystems
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com, Roland Mainz <roland.mainz@nrubsig.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 20 Sept 2026 at 05:55, Mark Geisert <mark@maxrnd.com> wrote:
>
> Currently, Cygwin assumes that all Windows NFS clients operate
> similarly to the Windows NFSv3 client. It expects that account names
> and numeric uid/gid values are identical on both the client and server
> sides, with LDAP acting as the sole authority for these numeric
> values.
>
> However, the NFSv4 protocol fundamentally changes this paradigm. As
> defined in RFC 7530 (Section 5.9) and expanded upon in RFC 8178 (Rules
> for NFSv4 Domain and ID Mapping), NFSv4 deprecates raw numeric uid/gid
> protocol representation in favor of string-based identifiers (e.g.,
> user@domain and group@domain).
>
> To handle this, all NFSv4 clients implement a local "idmapper"
> component that translates these string-based identities from the
> network side into local account data (in the case of Windows, mapping
> user/group names and uid/gid values via nfs3attr XATTR). Because NFSv4
> clients manage their own uid/gid translation locally, Cygwin's
> reliance on raw LDAP data fails in these environments and results in
> the dreaded "Unix_User+<1234>" and "Unix_Group+<5678>"-kind of
> owner/group output in Cygwin ls -l.
>
> The [...] patch addresses this by detecting whether the underlying
> filesystem is NFSv4. If it is, Cygwin bypasses the LDAP assumption and
> performs a direct pass-through of the uid/gid values supplied by the
> NFSv4 client's idmapper.
>
> [Lionel has] successfully tested this fix against several major clients,
> including:
> - Exceed NFSv4 client
> - OpenText NFSv4 client
> - ms-nfs41-client
> - ms-nfs42-client
> - Windows NFSv3 client (no change, it continues to use LDAP raw data)
>
> Reported-by: Lionel Cons <lionelcons1972@gmail.com>
> Addresses: https://cygwin.com/pipermail/cygwin-patches/2026q3/015287.html
> Authored-by: Roland Mainz <roland.mainz@nrubsig.org>
> Reviewed-by: Mark Geisert <mark@maxrnd.com>
> Fixes: 88dce3a (Try harder to avoid LDAP access for RFC2307 mapping)

Mark, thank you for picking this up :)

Lionel
