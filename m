Return-Path: <SRS0=CPJX=VH=gmail.com=lionelcons1972@sourceware.org>
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by sourceware.org (Postfix) with ESMTPS id 724493858D20;
	Sun, 16 Feb 2025 22:34:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 724493858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 724493858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::636
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739745270; cv=none;
	b=mSL9P8M9Ta5yVj4Ok0SkSQVmJPTvAk6TZJ0V7yykXw16li/3naRANIBRSvE85+AFUw8MdpcMHZBXInlA5NgBFsJ1IIr43UtO6BLupjOW+JHmwg0YWwznig8Dy0DvGBvkv95rae08ncD3zi/po1Cpba2MpJ6c4H+dwRoxWbB01xM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739745270; c=relaxed/simple;
	bh=SG0sFAMMy3y0VCn0rT0XPVYukanQoYJn3QapinKjZ7s=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=sMFtEnyoD9XwGLb416daruxW4nF3fkPQb71Bjwx4Y6YRXgxJF0jGa269Fk3kpw5biYkJVyU6Oe/y+weiuGoVprYy1KyH9ZgnFXfVlwN49kFBVCMExdKi6Llv89ej37UbiuaMJrlbcW4ujxK/uMwXtcDPx85ldEbtUFY9vIy5roQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 724493858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jv5RgigY
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-aaedd529ba1so444725666b.1;
        Sun, 16 Feb 2025 14:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739745269; x=1740350069; darn=cygwin.com;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OE7FKs14CdFn5P6Ygv4wk3ZtncmMHYECIqIA4CjaXlM=;
        b=jv5RgigY6QLrXlpV76y+4jgkI8Q2QtcxR/1iCxCdVyw46Y+La7WCY4bI/L0qHZ+gM9
         om+UBOBJwgj5wkxWBH45ydUumj/orMUUvYY6Mm/26wfzDA6YllDfZmoZeeigKz4PA95x
         MblfmDTZfeo0+uphwSP0KKLaPfUrpmGqA3lXfHYYqwXjYnFpCY7K6r714zo5qOj7PoOX
         RSMAMoZhM/ZY0V4rmM9TBB/bN6he11ab0vEOL6fulw22RJcNO0ZJqV91QNM7BvetEZfV
         d2jtAQoYtrxuMXQ4/Wva9Fp1eAItrkWhiG2xecuE5C7/eSP8zBcFSXWPlsJFCtYMuY84
         +Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739745269; x=1740350069;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OE7FKs14CdFn5P6Ygv4wk3ZtncmMHYECIqIA4CjaXlM=;
        b=L0Jq+oz39Qsznn3fFJrBECQqFGtmKEUg3RNwfFY8+a3TRIT9u6+jhID9bPdPz4wUeN
         JISlP6Y1Hze7JGJNfbxDpokQHas4uoAbTL+5KzAdtPsd5fDkAEoO4h3vg+PBP7L+jyTt
         anmcj3qocB65Q7/rIRX+H1iaQE94DkJfwQ2Oq4KLh6iHB06+OyA5+6HnHBa8g7l38rLF
         jCmZK8/uEgIatxPTL2LAbAa/S2GTAW/52A1SMG9miNHrbQc7wglFaOBvqt9M3IDvi5dy
         Qbh8QHR/ra2XE8UlQeeNm2802GVjWwOLW6p0fv2tEP0nnoBh6oOgvy2evywWTLb7nETC
         PtOg==
X-Forwarded-Encrypted: i=1; AJvYcCVg8fRB2teuAc0fTr3+pERRBUjnu0sMxJQr3Fe/1vgvbe+zupYEPe6v+NQ/9PAHJlfdzqDb1bo=@cygwin.com
X-Gm-Message-State: AOJu0YxQXOdwvYmz7UzfpfaoIrW8qau0JdYs4UM55r3YE8cA+1SN9oyI
	S01XDjrn3og7ydjnn618dVU10JbFEKqVSUElDMtDy6170/aJnwiEjd9kSxH8ziG7BE6mAv87z1b
	AZTdj34reZ719mbtM99bzAAkKHw4+le+LJlE=
X-Gm-Gg: ASbGncuzfckUAa+02gFRJsb1xkDtX66etW1k2otymDmhtvAABzA+BgrLrigrET1NR78
	0ZXwl3UMr7bTPpomdslC2TZNa9MWdixzyhUwpZ4r21DTaIRe6I4HijAdq0gAQHave2ZSh2h04/w
	==
X-Google-Smtp-Source: AGHT+IHNqdxWtv7fSxfnwv3dHuMcAmK+Td/C9uloIKAuvy7tF948VOxJ/n9fFSyvLls1I536IhvMX6053TmhcD5m3aE=
X-Received: by 2002:a05:6402:510b:b0:5dc:a44e:7644 with SMTP id
 4fb4d7f45d1cf-5e035ff9cacmr18605863a12.2.1739745268611; Sun, 16 Feb 2025
 14:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20250216214657.2303-1-mark@maxrnd.com>
In-Reply-To: <20250216214657.2303-1-mark@maxrnd.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Sun, 16 Feb 2025 23:33:52 +0100
X-Gm-Features: AWEUYZnh1iFeXnNfZvz2Md6hGwKwIa21f6nGqTvkIa9gEbCQTqEx_pUtlCta_eU
Message-ID: <CAPJSo4VH0MufLhpgPiD1GV1gFsbTLdtOKrP82eaA_Yv_DHPXEQ@mail.gmail.com>
Subject: WinAPI spawn() not used by Cygwin posix_spawn()? Re: [PATCH] Cygwin:
 Add spawn family of functions to docs
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 16 Feb 2025 at 22:47, Mark Geisert <mark@maxrnd.com> wrote:
>
> In the doc tree, change the title of section "Other UNIX system
> interfaces..." to "Other system interfaces...".  Add the spawn family of
> functions noting their origin as Windows.

re spawn() family: Cygwin posix_spawn() seems to rely on the rather
inefficient vfork(), while Opengroup intended it to be an API to
Windows spawn().

Is there a technical limitation why Cygwin posix_spawn() cannot use
WinAPI spawn() directly?

Lionel

>
> The title change seems warranted as neither the spawn family of
> functions nor the listed clock_setres() function originated from UNIX
> systems.
>
> ---
>  winsup/doc/posix.xml | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index 26d4fcfa4..3d2dac086 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -1559,7 +1559,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>
>  </sect1>
>
> -<sect1 id="std-deprec"><title>Other UNIX system interfaces, not in POSIX.1-2008 or deprecated:</title>
> +<sect1 id="std-deprec"><title>Other system interfaces, not in POSIX.1-2008 or deprecated:</title>
>
>  <screen>
>      bcmp                       (POSIX.1-2001, SUSv3)
> @@ -1568,6 +1568,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>      chroot                     (SUSv2)         (see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>      clock_setres               (QNX, VxWorks)  (see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>      cuserid                    (POSIX.1-1988, SUSv2)
> +    cwait                      (Windows)
>      ecvt                       (SUSv3)
>      endutent                   (XPG2)
>      fcvt                       (SUSv3)
> @@ -1602,6 +1603,14 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>      scalb                      (SUSv3)
>      setcontext                 (SUSv3)
>      setutent                   (XPG2)
> +    spawnl                     (Windows)
> +    spawnle                    (Windows)
> +    spawnlp                    (Windows)
> +    spawnlpe                   (Windows)
> +    spawnv                     (Windows)
> +    spawnve                    (Windows)
> +    spawnvp                    (Windows)
> +    spawnvpe                   (Windows)
>      stime                      (SVID)
>      swapcontext                        (SUSv3)
>      sys_errlist                        (BSD)
> --
> 2.45.1
>


-- 
Lionel
