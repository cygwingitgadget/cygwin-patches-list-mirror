Return-Path: <cygwin-patches-return-8533-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75034 invoked by alias); 1 Apr 2016 13:34:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75006 invoked by uid 89); 1 Apr 2016 13:34:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=yselkowitzcygwincom, U*yselkowitz, yselkowitz@cygwin.com, sk:yselkow
X-HELO: mail-oi0-f48.google.com
Received: from mail-oi0-f48.google.com (HELO mail-oi0-f48.google.com) (209.85.218.48) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 01 Apr 2016 13:34:21 +0000
Received: by mail-oi0-f48.google.com with SMTP id r187so105198506oih.3        for <cygwin-patches@cygwin.com>; Fri, 01 Apr 2016 06:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=VNymPgDUqeuaCs1XfplqHZzOoV5K1dTFteO+aPHyFa4=;        b=eqOkx2YwGjakVgRy1BS1xUtN6bsdmwKYj405Tw8uA/TQVS94VI7b4KuU/+GJwaJst7         7x4PqqWyHvsSRQM/E9WRx2LWzqDfPNFn80xhlM9icYfHGrdQEuftbKhk9GyxQT/yX2Gy         pED/nhwXdmigUidpusf6gtxoyFE+p16nHq0yoybteUX4fWeQElxTLcx7KIJ6c20RLi5e         Rg4SUnI5Hgpt1E+P2r9abyrpppqB7qeCF7XlMu7N47kr2TYNOOhsL1F+jGZRWJ8up4t0         O0xJPtJ10toHZWOLAA0AyqMNujstZjZUr2gp2ydydFaEFY7chQFpJqbAqMWy8NmY0Lgf         3/wg==
X-Gm-Message-State: AD7BkJK4Eya3vXxf+aJ0XHGtMe5KA1T99t+NWTf6ksbf7z2iyVwR1C/Vw1ZVc3PEId/rSFlLRbYSybnrALLydQ==
X-Received: by 10.157.13.20 with SMTP id 20mr2858612oti.35.1459517659594; Fri, 01 Apr 2016 06:34:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.157.136 with HTTP; Fri, 1 Apr 2016 06:34:00 -0700 (PDT)
In-Reply-To: <56FE73D7.8030306@cygwin.com>
References: <1459441102-19941-1-git-send-email-pefoley2@pefoley.com> <20160401121318.GA16660@calimero.vinschen.de> <56FE73D7.8030306@cygwin.com>
From: Peter Foley <pefoley2@pefoley.com>
Date: Fri, 01 Apr 2016 13:34:00 -0000
Message-ID: <CAOFdcFN0+eH76u6A0Z=gsyE8iEtzQFUTjyheQYzRk5Hfst_s=Q@mail.gmail.com>
Subject: Re: [PATCH v2] Refactor to avoid nonnull checks on "this" pointer.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00008.txt.bz2

On Fri, Apr 1, 2016 at 9:12 AM, Yaakov Selkowitz <yselkowitz@cygwin.com> wrote:
> See https://gcc.gnu.org/gcc-6/porting_to.html, section named "Optimizations
> remove null pointer checks for this".

If there's an better way to do this, I'm all ears.
However, it seems to come down to either making these methods static
or passing -fno-delete-null-pointer-checks unconditionally once gcc
6.0 becomes stable.

Thanks,

Peter
