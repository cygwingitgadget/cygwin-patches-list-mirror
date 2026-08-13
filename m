Return-Path: <SRS0=p1vJ=GG=gmail.com=chenlijon@sourceware.org>
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by sourceware.org (Postfix) with ESMTPS id D33C04BA23F3
	for <cygwin-patches@cygwin.com>; Thu, 13 Aug 2026 00:50:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D33C04BA23F3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D33C04BA23F3
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2607:f8b0:4864:20::22f
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1786582230; cv=pass;
	b=lIwScUIqZcmkfdY2CY+QTJHPB4ZgZ+plvDGlALwGiSzSKKieD2T+ZM8YM5+1SEDmT8aTfS7mmgv7hRH8XYO+qWs1MIp4cNFeVBr3Rfpn+kTFaM90eWl8YQR9Xnp1Xi49PYlToxxhQwEizgrq472gFaNspOPprZsyKpS7u4QvEik=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786582230; c=relaxed/simple;
	bh=0j86FmHbm7IedKFE7QgFrp8tJxxdycGRE8d+7Hqm+0w=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=F5+ZsnJwLxH3oGTvNZJVRLxX0SzTpjL7ZCWCOtblEiaN1cU2sbxn3jL7G2uGLrvprI02/e1gNbJPKLwH9q4h/2geLAG7F/t29AH0MtkScRTAi37zELuo1xwu0SsFhPWJcQ0z48KMQTQI2VmImxqFxmQzwrcC4MXZwt/PtLH8A/0=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O9FsqS4o
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D33C04BA23F3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O9FsqS4o
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-497deab2d66so430970b6e.0
        for <cygwin-patches@cygwin.com>; Wed, 12 Aug 2026 17:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786582228; cv=none;
        d=google.com; s=arc-20260327;
        b=oYjiKQTcxz9EB7d3WYt+7/I9/sfG5RpdceKhlBeBBbHDeSXR2D3Kqbsjn7+Uq/SuTs
         aLdT9R1QuZLZ/fyuAbRIwkm4ivEQogWUmOrI3NkRsSQiAIyjod2TCkrdScOhi4q+xdoh
         lsvC68n8UYPD3Ddt6EQ8DhUGztaSlu3sP69sw3XfndP5NtIgJSnD/DfcIFZCfRFezDFJ
         WfG8M7Cp0fykeGnf35TnfXmcpY/J32lCudWyQ2cxfgLNlnGza+1xqdrpbWn6BV5i9Ep5
         VsW7kOrdp1lwof4ShrgVw2/kP1m2GSiykss9rNowAyZSjhwwmowqyEKncoZ9Cz84/nGV
         hpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LTglf7Rv04jCisEelK/MObItEW6xipRdAyIVFBkSsWc=;
        fh=YLobnwiB6mlxg8mZw4jwzI5+9rNrzFWI954radGPi+I=;
        b=dlee7TpQ2+sQPjMEiqj0vbpwY7Vgtr2B1+8670GyvLtgerMJWqYxpquiUdt2vt5PFj
         OgRbO5Ulsc420TZ1t7jEVpqTYW7ZYxcfguQgY49EDP4SqNr/KW43qlu5l+H7kLY561+W
         bEYAqOckHLybQf82QdzJ/evizo/USwjFDFr1A/gLQLEp81AHDS3go1DZVeOtStFBhgay
         PGfQNOTPReEA1HA4tpQeXq56Szy84yygQWdjBWg7oQNqosfKotgXI27JvozaNuEi+kTy
         fT81jgDDVEXVZ0h3yD5YxQUMVEqG4X7C04EuhuR4RzT1NUstAymfc/HPcuQ1BaRxEAvf
         ErzQ==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786582228; x=1787187028; darn=cygwin.com;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LTglf7Rv04jCisEelK/MObItEW6xipRdAyIVFBkSsWc=;
        b=O9FsqS4o93oGuF8wXFMRzQHeaJnyXIQERmbShXJ/DlCzDbe0VH7Z/oyX26R3kBju9G
         r2AbaVdoimtXj/KX5rkbphLzXjpL9OxaQYeCdwdYxLjstmWmJbkZsI43hkr/RRroypCd
         k22BfI+hi28v0Y9ZJCJ+l10aA6P3PaxUBktrApNdXV3sgffn71aMx+vtMFcESHQcpEnr
         XNy4yK5m4ToqnWhRUc7+FWzbARNvs7CAR+7LtCNVhNlNeyufB7HBY+Jy0ISQ3LO9Wt51
         JF1ptIgOoFWflc/aDoaaFoDqQ2KM0GkZManDnPTiC2L53kygXtzfdOLn4nQKNL5veX4j
         sjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786582228; x=1787187028;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTglf7Rv04jCisEelK/MObItEW6xipRdAyIVFBkSsWc=;
        b=Cdwd6t8cx/2lmjWfmLe5ViBqBfYQhMadPP/6dh9cTg8ICUomiV2ccnvsnmAKyM0H99
         4aEFsZKYHNygNMWE2AtZYAwtvqlZl6ACjXOLGzT0MglQ8Ze0IBAzXyYyACsaP5U0pfKo
         RNi1WxB+0LHFRsLT8CyyplDMHxs/lXCkZUyKRUEwp4tWEVS34C34x542mFHQfoBZ61KF
         fUtJGgqIhKyrTgH3p0X+iVYynkp6yMy5Xn4gLUoS9Oxanxai/U2wKKM6pn7FdaXxtPJE
         Xh9JOI8Z/ofH0Zshj9yEfHmel/8Stk0oiQxZfKQter3OAqRAI4H514+G9P414ISjsZTa
         eOQQ==
X-Gm-Message-State: AOJu0YzeIhf8onY24k1UVWSWTl0eZZZNFTpyJ9oe16MeHOznFGofYwkz
	YyCVuOSAHByJQRG/G/TW6rsMezdW8JY+07CUeveyuASCyey8UVdfw7z1K449i7Md6cWxuUAht+8
	BeBobAYp6GQe+Fp2CByTklZuNyU0r9LaECg==
X-Gm-Gg: AR+sD1244wh0q5SD5epClB3OGoiqFo9nDJEu1d/b9bos3fYIseimDDRkkOvPYTyBK+b
	DFY3RBo7xalOXXyz7DEo4+GnCK/w5XuzN3x0JaINom74y5r7DKLW85pp9CJesWeXgMNtM8+BQDk
	dD8erRI5m5JwXiebL2MIdRVL8cQjpx2cMQ/dhCc+1kUbB0HJ1pJJT1ejFfIK6d+8pKct2/KM8Aw
	bb6ZnUGl31LTwkCVy7UzXFSY7OFHxjk0iOyoOPjE9Te/S+WLNUT20R+wrXbGS9pGg+lpl6yg8NT
	pvmMYjMAUnPje+b1O2nwOEMoAbgcVqVXgmr52/g9vD2+iwYjRrTCYvbd7cNVBfKH7ByEnIWmNR9
	P
X-Received: by 2002:a05:6808:4fc7:b0:49a:7714:ed25 with SMTP id
 5614622812f47-4b227e66b2emr1904631b6e.3.1786582228462; Wed, 12 Aug 2026
 17:50:28 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?6aOb6aOb6aOb?= <chenlijon@gmail.com>
Date: Thu, 13 Aug 2026 08:50:17 +0800
X-Gm-Features: AUfX_myzmrsWxjuZvilLr8wSjJwEZ1aP3QsR5KBdgFDw71H9I4JaQ8xrV2uFnGw
Message-ID: <CAD8hRBMi6qaH8xP4Zw0j0VpTz0CFLRRU2cb--H4FCZcpQ=nhEA@mail.gmail.com>
Subject: [PATCH/RFC] console: avoid master-thread suspend request from
 non-master processes
To: cygwin-patches@cygwin.com
Content-Type: multipart/alternative; boundary="00000000000016f25b0658e31766"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--00000000000016f25b0658e31766
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I have been investigating a reproducible hang in highly parallel builds on
Windows 11, especially while building LibreOffice with multiple jobs.
The hang appears to involve fhandler_console::close() calling:

set_disable_master_thread (true, this);


even from processes that do not have a local console master thread.

set_disable_master_thread() updates the shared disable_master_thread state
and then waits for:

while (con.master_thread_suspended !=3D x)
  Sleep (1);

During testing I captured a case where one process published a suspend
request (true) and started waiting for

 master_thread_suspended =3D=3D true,

but another process later published false into the same shared state before
the first request had completed.

The first process was then left waiting indefinitely.
In the captured trace, both requesting processes had:

master_thread_started =3D 0

while the actual console owner/master-thread process was a different
process.
A minimal guard in
 fhandler_console::close() avoids this:

if (master_thread_started)
  set_disable_master_thread (true, this);

This prevents processes without a local master thread from entering the
master-thread suspend request/wait path.
The intent is not to change Windows process/thread scheduling. It only
restricts Cygwin's shared console master-thread control to a process which
actually has a local master thread.
This also avoids non-master processes entering a wait loop whose completion
condition may be invalidated by another process modifying the same shared
state.
Test results:

Windows 11
AMD Ryzen 7 9800X3D
Intel i7-13620
parallel LibreOffice builds

repeated high-parallelism testing
full LibreOffice build completed successfully with the guard applied
Without the guard, I was able to reproduce the hang and capture the request
overwrite described above.
With the guard restored, the full LibreOffice build completed successfully
with exit code 0.

One possible trade-off is that processes without a local master thread can
no longer request suspension of the console master thread through this
path. So this narrows some existing cross-process master-thread control
behavior.

So far I have not observed a functional regression from this restriction on
the tested Windows 11 systems.
My current understanding is that the important behavioral change is very
small: processes without master_thread_started no longer enter the
potentially unbounded set_disable_master_thread() wait path.
I would appreciate feedback on whether this ownership restriction is
consistent with the intended console master-thread design.
Thanks.




=F0=9F=AB=86Trace Process Log=F0=9F=AB=86

Process A:
  started=3D0
  publish disable=3D1
  wait for suspended=3D1

Process B:
  started=3D0
  publish disable=3D0
  completes immediately

Process A:
  never completes

--00000000000016f25b0658e31766--
