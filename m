Return-Path: <SRS0=x/14=ZJ=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by sourceware.org (Postfix) with ESMTPS id 136C0385703B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 02:12:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 136C0385703B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 136C0385703B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::531
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750903949; cv=none;
	b=h3tIwKy7wTyxLR5r4W1V3nXJHECPLCtJa6HENizQdnaCKSOIMhQ9fOJ1Ga7069os6wJtO6rrAmrUYeXpMIQMblWBKEzotVkDmXJeObxflH0k9Rd5sCP0cthA7cDO2Rd6Q/aRXLsShkfv80iuHD2vWGH+Ozn2KESHmKV/2MKiFLg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750903949; c=relaxed/simple;
	bh=YRbUsxDGBDNaz5mWFe6AB+36kVCwcB35aL5Edy48qbw=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=pUwDoiJ8FfMp1SsHf41VOCGi/FPEKy6RBiFfnAk2uZND06h+mR8MwAdalIQUDfjCPzAYBx16tpGvaYOad/ml82QqNOB+BqrRfb6mQdhxKSVo2fyHWWgCaD0GwvX07+271JkTPg9pV6JW3IfrNyGvT+s9DWuCcWIZmbjgC+V2HVo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 136C0385703B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ON5RuGwn
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso918023a12.1
        for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 19:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750903947; x=1751508747; darn=cygwin.com;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaX4MeFWY7Zaa8jQTPYawH4RIIBl3U36yqOZ8fLQ8Vw=;
        b=ON5RuGwnAQ88MMpTg5rzrhgEc2LAZGW6rckFS9ugi2O9wsTVbMaclHpn0fN9+pVwAq
         Far0L86UoP0VJJXQtcnlGpMHLAY6MAw9K3x9W0lfZpzTOmv0FYMwk/ddwG+dfwFporlT
         SmE5th9BeyG/VuFF2DUePCTN2XUs2XLB6zErDzTnjeHUp2dMPxvRENKUuzRbpMlTLezq
         deLyJF5Ama617S6oEo919Rqvg0uY1/y7tHfoSgP0Rv2f/a77uvLSpQ0Gv1OTN6yJeKh0
         cM71/XyMgeGIeFH72oHUPT7M/ruSzehKfy8R9JDk6b6siZvQVZS8tPTLNKXzSZenMh5T
         FFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750903947; x=1751508747;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TaX4MeFWY7Zaa8jQTPYawH4RIIBl3U36yqOZ8fLQ8Vw=;
        b=U9+rocEEW14P3Emebsqfwo6hppr1mmUqjDh/OUBGDA+wmwox+d3kcIhkuiSFqCtQi4
         YZYarP/GAjqNHeeiVkvpjuSG4Sduy5cPOi5imEx8xApMk0kiH7tFVLgahQI88IZx5ebo
         SxdnEfCisRkpyN0UQl/suGwi+tewY0Pn+1ra65cFdecl2rwTZIqKW5XPjtEm0Ct+/nxQ
         9dYYoboLcIIOujfviuq1WTNcNqzhFf63NwqvywdJohP3ceBBfkRGRABI4mA5zgSzwVD0
         NKYnEWPl2BfS3RvWtQ/yYE41Y9i4NgcXuDVi6VQ64f2A7ufVGfT9+vw8WiBqI2Z7IWwK
         YvmA==
X-Gm-Message-State: AOJu0Yz/0oszJSPv8NKK7SAPnFag79Ci+i5t1LlclALlKFeZYgTDryxz
	Aswj74yEkJTWKm1B4l+TbZ5JqsLS5edn3fS3hO5oqEfxqyshErtM+uluQCZDkiLMmLiCqvl6jk1
	LgocRILAkQEJUdDHaphhQQ2mwrfu63iCbrcJX
X-Gm-Gg: ASbGncvTHXipS0GIMBhwq1E9KFxwda0ri70T/0dgO9W13ThZmChFU37IoG6As0D7fEB
	hYmViQ2QFI9X3HE/ZzbyTIYSIGZ1ApMtUBeKgfiWDb8oQwOtgwCrVhN2W9w750PIDOAxLGqgkqg
	7HVI1ebRXVogMIQqcSw/6kdxGEDYn25BkUI9IVqQ6pRbgf8Q==
X-Google-Smtp-Source: AGHT+IEQtq5e7aJb/B+/8+QvxuVqo1DX5aI2cOE6jcXxLfFdB6Vz2CxvVZFxwB8ctM0uMbpNC5vma+2g9AfcqtcfHlc=
X-Received: by 2002:a05:6402:3507:b0:607:5af9:19b6 with SMTP id
 4fb4d7f45d1cf-60c4d3d6179mr4702012a12.15.1750903947148; Wed, 25 Jun 2025
 19:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250625013908.628-1-johnhaugabook@gmail.com> <20250625013908.628-5-johnhaugabook@gmail.com>
 <aFuoBviRzyYIHLbU@calimero.vinschen.de>
In-Reply-To: <aFuoBviRzyYIHLbU@calimero.vinschen.de>
From: John Haugabook <johnhaugabook@gmail.com>
Date: Wed, 25 Jun 2025 22:11:50 -0400
X-Gm-Features: Ac12FXx2oFBM6THW_2E9jtsGsQtVoIbVulxzf3EDqTUeYVYq7Rts7c16LrwUHG0
Message-ID: <CAKrZaUu6EvGiCwD3-RrfVrFrZ39r5_5c-JSmaa3TCWsEWeHwzw@mail.gmail.com>
Subject: Re: [PATCH 4/5] cygwin: faq-programming-6.21 install tips
To: cygwin-patches@cygwin.com, Achim Gratz <Stromeko@nexgo.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna and Achim,

> This shouldn't be necessary.  On Fedora the ParserDetails.ini file is
> part of the perl-XML-SAX package but apparently it isn't in the
> Cygwin package.  Is there a reason for that?  The user shouldn't
> have to create the file manually...

Two things:
1. The error appears on both builds, but is slightly different in the
cygwin install
2. Sorry, but out of ignorance I didn't mention that the error was
from the "src" install
(hoping this makes for good new user feedback regarding build section).

The error output (with context before and after) from the cygwin install was:
"""""""""""""""
make[3]: Entering directory
'/oss/src/newlib-cygwin/build/x86_64-pc-cygwin/winsup/doc'
  GEN      Makefile.dep
  GEN      cygwin-ug-net/cygwin-ug-net.pdf
  GEN      cygwin-api/cygwin-api.pdf
  GEN      cygwin-api/cygwin-api.html
  GEN      cygwin-ug-net/cygwin-ug-net.html
  GEN      faq/faq.html
Element listitem in namespace '' encountered in answer, but no template matches.
  GEN      faq/faq.body
  GEN      cygwin-ug-net/cygwin-ug-net-nochunks.html.gz
  GEN      api2man.stamp
  GEN      intro2man.stamp
  GEN      utils2man.stamp
  GEN      charmap
  GEN      cygwin-api.info
#HERE
could not find ParserDetails.ini in /usr/share/perl5/vendor_perl/5.40/XML/SAX
warning : xmlAddEntity: invalid redeclaration of predefined entity 'lt'
  GEN      cygwin-ug-net.info
# HERE
could not find ParserDetails.ini in /usr/share/perl5/vendor_perl/5.40/XML/SAX
warning : xmlAddEntity: invalid redeclaration of predefined entity 'lt'
docbook2texi://refentry[@id='proc']/refnamediv: section is too deep
docbook2texi://refsect1[@id='proc-desc']: section is too deep
# ect....
"""""""""""""""
The remaining install did not end with an error code (2 usually)
though, and completed successfully.

Take Care,

John Haugabook
