Return-Path: <SRS0=dcB5=ZK=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by sourceware.org (Postfix) with ESMTPS id 109753858408
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 18:42:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 109753858408
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 109753858408
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::534
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751049750; cv=none;
	b=F7ACMGI21KdY5n28soiJabdTNFAM15xdMGMWxhT87yKhoWVZ9qJMlJ5TzEZ0FwYtkvzqo+GlpgwHA3omsby7fWtL3MhuCHdXR4QaYJZlrnZ++Y+ahrPooT7stFzhyT23W4CA1Fz17Mo27SB9P4nfG0tGgerqxkb0l79q6DIadbo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751049750; c=relaxed/simple;
	bh=YBQ8uI4KhtG/cfZaVymH7z+DMABNy8mHdq1ykB+VVyg=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=OLK1IgKNkKw6MDJJSl+4G2H2gNemRBp2dBEUtEovN+Dz3Bys6JnKxsKlWn5d/UdGFYz8XbJcBsESFCbfQRaVbkkeZBXSzl8Kv+WxVgnp2Bf8OIJV6uTfIVONWkWoetjJoHi5a6NOYGuG/+12PjEESkPIwLo0kMbUs5WyCgHiF50=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 109753858408
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DdhwFZT0
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso229845a12.1
        for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 11:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751049748; x=1751654548; darn=cygwin.com;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YBQ8uI4KhtG/cfZaVymH7z+DMABNy8mHdq1ykB+VVyg=;
        b=DdhwFZT06ZFLqx6RpNO0TKYP+i2cvvnZhItIx4bo0rOVclMYITtYqpeCM7cDU0mV63
         EIi5+H0BuG0hxVPEmCYLXqoEmdvJtnAuyiqmA75MQ87kQM6N4m9svvya23/4z/p+HXCc
         T4b//gMq0LXPrwKc/MS/jw4o2ie4DJtk7bIJXVldEm2eE6rL/uT/CCr2B2oZP/pITf/y
         VJoH9LFL3YYGtlscQY3FsLdpCBtUpqQhpRwQMB08PZcQQ7NUI3DyQx1rmAULHfcJ0sak
         /z8EyQ21m9QaxF3Q1NUaX7u4ruvzjSXo1ayvK9wsC5r1R81CZC7EXMXCF6YDxEnslJYu
         cBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751049748; x=1751654548;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBQ8uI4KhtG/cfZaVymH7z+DMABNy8mHdq1ykB+VVyg=;
        b=BuApy5MOH/E3j9/MzJz4zesltFRqnCHvw55OjWeW8XmW5ojktO8jpOjEZWDJ8GLj89
         W2y42f6Hu6GQpDH18fda8qTK+ES3sU2s0Cj8qAPvYuBiojOtkqdEIbF/M/+oocACceoq
         T8/DE9at+UcaGQXVnMg2I44osld2wRWQ1Sv/DZPkCsAZ6nwS0o+KriL/RprAf1s5FSOc
         DliSp2u+8c1/pE4a8Kjb5DKbYmU2xI4IPGIGfdKaFxARfJe1RWrmaIxuWqWMDTAuHmSj
         6lHKqypbbgIP+ze0Xee/ZR+HQpZydFDm7ST3oLFL2T/8e4gOn1jM23wkDf1VPx8fRBke
         mYVw==
X-Gm-Message-State: AOJu0Yyyg0VTJZv1l8ry8s0jgDT0l/a1V4SQvrf+iJaKCsJUMXua/H8R
	X6ZPdJN2xFLuzwtOfY+k5/M2Xg1+0nrDBMYPyVFRsnYy9UHMQqZTxX9Z6US833WNMLtjpk/B1qz
	9CwVzXeXhSkK6B42NTIp77J/5aDkLQlXd0xRm
X-Gm-Gg: ASbGncvdXYVM+S/vorMmXWN6mzovR6ZuEiOwz39KLtunHpPQJddWAwd5yjMUBiQlc6x
	PKYVJNDSWtsZduTfWp99Gk3jlfBaCxJzWExFLjpIdD1WPb5N9yEaKAsMPq2JCJD9lABMvFN6OAO
	WHaKx0WUYNqC5K3HCXaylfM18cpBLWFqUx1iGtzRWW0kVJ4Q==
X-Google-Smtp-Source: AGHT+IEyHkj9gV/8X8Yp/KdWjke9khEBDxufIsNOD7/y5ciQd0CLJXxs/VaIPE5gtgy6De6DwYAIzFKTXysnLMOOQfE=
X-Received: by 2002:a05:6402:440a:b0:605:c057:729 with SMTP id
 4fb4d7f45d1cf-60c88ee711emr3624491a12.34.1751049747892; Fri, 27 Jun 2025
 11:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250625013908.628-1-johnhaugabook@gmail.com> <20250625013908.628-5-johnhaugabook@gmail.com>
 <aFuoBviRzyYIHLbU@calimero.vinschen.de> <CAKrZaUu6EvGiCwD3-RrfVrFrZ39r5_5c-JSmaa3TCWsEWeHwzw@mail.gmail.com>
 <aF5ZDMBwxl6NWUWv@calimero.vinschen.de>
In-Reply-To: <aF5ZDMBwxl6NWUWv@calimero.vinschen.de>
From: John Haugabook <johnhaugabook@gmail.com>
Date: Fri, 27 Jun 2025 14:41:50 -0400
X-Gm-Features: Ac12FXxOku3BIHznt7XasA-IZxEqG5hrVmJ_ogof-5KuazBiiR_ORNhAxVm710A
Message-ID: <CAKrZaUvLoZ+Tr7JtaVTpssXF90JWTsonraKuz0wp9YJNsXRBZA@mail.gmail.com>
Subject: Re: [PATCH 4/5] cygwin: faq-programming-6.21 install tips
To: cygwin-patches@cygwin.com, John Haugabook <johnhaugabook@gmail.com>, 
	Achim Gratz <Stromeko@nexgo.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Take Care,

John Haugabook


> So do I understand you right that the manual ParserDetails.ini
> generation isn't really required for the doc build to run through?

I wasn't sure about this one, so thought it could be put in as a tip. I ran
another sandbox, installing perl-XML-SAX-Expat from src. The terminal
threw the "missing ParserDetails.ini message", but it did not end the
install with an error code. All files built, and make install - good.

> If so, we shouldn't really care to document it as a requirement.

Getting no error code now with both cygwin and src install, then yes -
leave out.
