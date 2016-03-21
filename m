Return-Path: <cygwin-patches-return-8443-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30981 invoked by alias); 21 Mar 2016 14:20:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30960 invoked by uid 89); 21 Mar 2016 14:19:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1447, understandable, earth, HTo:U*cygwin-patches
X-HELO: mail-oi0-f67.google.com
Received: from mail-oi0-f67.google.com (HELO mail-oi0-f67.google.com) (209.85.218.67) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 14:19:49 +0000
Received: by mail-oi0-f67.google.com with SMTP id e22so8565848oib.0        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 07:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to:content-transfer-encoding;        bh=J92/6M5UAcxZR3xq4qCvel+fZeKzRUwjHL2oWUczJNU=;        b=OPQI/tQhW0hyybjo/lVD8xdNNCjckDC6iaVhB632DtylZv/Da+9bAdvHEVDvHAQHBf         Zg7kp677nriV9j/h2XdI8GL5MgZICaJro6xK9iIfnu4jx/mXL58+g4rKZXkEos5XKdo/         dFFYGGD+3Qwh/zJQMrP/1s0ToheB5xVxA/TzihPCrAEDaCOloaA0RJMtwz+hQusiHjiE         2Mu1MNmHhLcz6LgcO08xSCz65QGo/AcENcxadNyFCcrQSsvTJpchYJDtqnBBfVnoKV3J         d012qsHGncR6WG1G+cVVIuFTl7aIaBhFaIhABpXba/Mh1MEFvohMsuDjh/KtDOHQZ6I1         mmfw==
X-Gm-Message-State: AD7BkJLivRjynnuUu6SAfim6DqnEJ6DevFSmNRPS6GLEbZE4i3Qveez7mXF2DYer7hZZAIMQK00wKed9ipM7hQ==
X-Received: by 10.202.197.85 with SMTP id v82mr12170279oif.13.1458569987699; Mon, 21 Mar 2016 07:19:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 07:19:28 -0700 (PDT)
In-Reply-To: <20160320111558.GG25241@calimero.vinschen.de>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-5-git-send-email-pefoley2@pefoley.com> <20160320111558.GG25241@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 14:20:00 -0000
Message-ID: <CAOFdcFPN1q8L6qmbORVogvxs5rsETjSs9_9_QnAfFm3YT++6Mw@mail.gmail.com>
Subject: Re: [PATCH 05/11] A pointer to a pointer is nonnull.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00149.txt.bz2

On Sun, Mar 20, 2016 at 7:15 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Eh, what?!?  How on earth can gcc assert memptr is always non-NULL?
> An application can call posix_memalign(NULL, 4096, 4096) just fine,
> can't it?  If so, *memptr =3D res crashes.
>

So, it looks like what's happening is that gcc special-cases
posix_memalign as a builtin function.

See https://github.com/gcc-mirror/gcc/blob/master/gcc/builtins.def#L831

This causes the below warning to be outputted for my testcase:

a.cc:9:25: warning: null argument where non-null required (argument 1)
[-Wnonnull]
     posix_memalign(0,1,1);
                         ^
a.cc: In function =E2=80=98int posix_memalign(void**, long unsigned int, lo=
ng
unsigned int)=E2=80=99:
a.cc:3:3: warning: nonnull argument =E2=80=98memptr=E2=80=99 compared to NU=
LL
[-Wnonnull-compare]
   if (memptr)
   ^~

Testcase:

extern "C" posix_memalign(void **memptr, unsigned long, unsigned long) {
  void *a =3D 0;
  if (memptr)
    *memptr =3D a;
  return 0;
}

int main() {
    posix_memalign(0,1,1);
}

(Note that passing -fno-builtin causes the warning to go away, as
posix_memalign is no-longer special-cased)

In addition, both newlib and glibc appear to assume the memptr arg is nonnu=
ll.
https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dmalloc/malloc.c#l5008
https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dblob;f=3Dnewlib/libc/=
sys/linux/malloc.c#l4938

Hope that makes this more understandable.

Thanks,

Peter
