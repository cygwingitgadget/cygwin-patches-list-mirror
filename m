Return-Path: <cygwin-patches-return-8899-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64178 invoked by alias); 3 Nov 2017 09:21:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63788 invoked by uid 89); 3 Nov 2017 09:20:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-3.1 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=Hx-languages-length:326, corinna-cygwin@cygwin.com, corinnacygwincygwincom, HX-Gm-Message-State:AJaThX6
X-HELO: mail-io0-f180.google.com
Received: from mail-io0-f180.google.com (HELO mail-io0-f180.google.com) (209.85.223.180) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Nov 2017 09:20:56 +0000
Received: by mail-io0-f180.google.com with SMTP id m81so4813068ioi.13        for <cygwin-patches@cygwin.com>; Fri, 03 Nov 2017 02:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=welUMIkIfY50/ImFhWa6m4qvtCy2pbF4RewPynkQtiE=;        b=OWdd07+iYLuYpa+/hWRic2NAn9cRO1Ahp97KgdCr8tyWTYX7fhBOg+fqwqYPKEx7NF         UAjeNUawmSq4nIq9Zto4hk5nGRpHhv578+rCsHffLCkYwrzR0w3Y3mHG9xEa0xuPPFNY         uYA/6ck0m3iyJMqH3/sjZaLK0ppu9vAJVuctgQtCeTptHPX771sCO1pVuJgsR34y1H72         mbioTVMclujvJ/vj9xfHLFznl235QmHJZT/Wb8XSutK/bIClQuTeICrzhsmzlXydNHJl         hTA3XM0ba9fT5aIEJgKiktULffGcOgNkjZzLAwVXNB2YXz2OEcTnUOKyaaBEMoB3d9XO         47rw==
X-Gm-Message-State: AJaThX6+Caa4fXrGTFLZtZAPZADfHm8ZgcyZCRDBpcy4YZ0rGZRHmEOi	LjYG1BSkOV9pDd1hW/jORTyUsZ4rY44kCwJHRbRzsQ==
X-Google-Smtp-Source: ABhQp+TGXZ1vN6AThaqLDJCodNv0jXt4/w3FqrfGEGvf3NRSfrja/h97o0eWtgLKSRA2VQahXFsVU4ProP48IzYBJLg=
X-Received: by 10.107.63.67 with SMTP id m64mr8217104ioa.272.1509700854583; Fri, 03 Nov 2017 02:20:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.105.151 with HTTP; Fri, 3 Nov 2017 02:20:54 -0700 (PDT)
In-Reply-To: <20171102171046.GB31634@calimero.vinschen.de>
References: <20171102154535.12176-1-erik.m.bray@gmail.com> <20171102171046.GB31634@calimero.vinschen.de>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Fri, 03 Nov 2017 09:21:00 -0000
Message-ID: <CAOTD34a8GFqVScZhXkQWc8Jo2r-gVDXQh=e2bXa71sMj-kkXAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] posix_fadvise() *returns* error codes but does not set errno
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00029.txt.bz2

On Thu, Nov 2, 2017 at 6:10 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> On Nov  2 16:45, Erik M. Bray wrote:
>> Also updates the fhandler_*::fadvise implementations to adhere to the same
>> semantics.
>
> Both patches pushed.

Thanks!
