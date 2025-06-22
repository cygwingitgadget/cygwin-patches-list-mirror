Return-Path: <SRS0=eX1P=ZF=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by sourceware.org (Postfix) with ESMTPS id 378443951840
	for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 08:20:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 378443951840
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 378443951840
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b2c
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750580437; cv=none;
	b=kCJVYuUqJlNrdCFM4Wcy49++9Nx/0K+1nhf5IKT5G0V43osyWhyCGuOq2WqwWRzDSWdESqy9HlsRTnJVoRdImcFqvgfCVaBskKAufbjEC8zWPPKmOhdpylAE+Kg+1618DprWEBtZwISb62tViGqcFNNMTvZ0hWhDi8k08OwD+sc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750580437; c=relaxed/simple;
	bh=By0xvIhNFb0odYhlplIu5TlK/wWrMyAuL7CK1/40oeg=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=xSDH6K9rBRwPul2v3caWNbEUW9SzfPRXFW3kKoqK7mA4q/u5i0peemi+HCnzFG1M40HFswMPNcwjFKoi2vb5aSLA/uwS2GIOIdBgi00L0Ajt+gZ1yUkWTFmP9bxNNP69TEc8xpq4sYDQqaVnRdmZwq5DT4Mmqx4AzzXuRfCN/bc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-e818a572828so2272953276.1
        for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750580436; x=1751185236; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F043rz9UtMD0y8RMjQv8uvYPC3AfphqBRAGkJPo5p80=;
        b=cMKVEIe9VZH6SG/Jnr0EfhpI5lOepnVPc86ZSeHo5YmYTpYWomS0ru6SM/RyG+ie29
         jxNu2XSKkcNVvaoO9do3+YK8dZN+83VHDeexOqKeGxMN1+1oP1t+3c1WluDv/wiPcOjK
         HAzpI+kK0QnVL+slMvFkbg43NkzsbNqDCd3QOCozmWy67p81zy1itij63gWCwq673BTd
         raBSD0D/jWc/XMnpnS9uZMSrwEjaPpkgx4VyGqFgKtwZ40edUgTJ41bldECL1g0PbGyD
         3tZzuKqqSC992zJ1u61MvOQMWbjLZC13zZwx7FSDJoUURBVxm5xsZShokTVEm49TFsIp
         LSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750580436; x=1751185236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F043rz9UtMD0y8RMjQv8uvYPC3AfphqBRAGkJPo5p80=;
        b=pwCPmWKoAekrYf+a4NGd8YplM2rPyZefHnezH5NOQQTQN8DokV1nR75yAUCzrH/Jm2
         PcraYkRkEP8Us8lrkWr+LpICAW+9tZ4bMRCiiMG8RZpMNU9NM6apCMlYA+ze0v6xJEgE
         PAFrfzdGw6weyfQn5Y3YfGyvcwdnH9gxxIgTuFxG5/Q7KvhD+qQmymq8y1mVfuUetcAO
         5ROxpgRWuSLofaQs/B+XcTllj0eT47ytpelBmmugwyCfL+lusBi5zQDq3c9ZReMpGCkQ
         mq2uwB3dD4kXA2u5X0O2RvGiZlPt9Mcla+s3hK2mAgj4YF7ltSOCdv/OlpEPaxY4FJAD
         AgUw==
X-Gm-Message-State: AOJu0YwonDHqh8mUYCANagwulmLXHxd1NhRm41ftVHkGhB6Gy0fzhLWZ
	yV6CoNzLQmxC4Gw0y1kxsW6gRSEZBOCN4fK0FJegSJGVQeLGfPKEEaUgoapOVA==
X-Gm-Gg: ASbGncsCmTn5OExzUJ0HwCw0brroG/gv5QQj+4Z2iApHt8cIrmXRV2jcUUrybr826wK
	mn52UoIgSza6fcZH/mkBCMWvztPQ1ri/6XgyNX/ikFnARtIwjqA76THeK/XjsfiFJwovxaZQZZw
	eQ+3/J9Mx74Ore+KQP1/hSiXiyrDDiMQcZRfWpaaIGYNH2CBFQ49kBuLBjNqJDsFKpju+m2JAIH
	j7kg4T2AGCGCehg18mJOrRwfSqBEQIAQk10puevWJ4QjrfpQQoNuz1CBovLe8QK8N3nzP9uIbQ7
	KXrVIoviy7QrKWr1Qb152+fSqynZbvcLw1q1T4+8Ohtctc7j/dUQpkT/WfNPCv54gDSBYJ0Vp1g
	vwoRL0Ir1dUTqdT9EckmW+3w1omf7LriRL4UQ1F6kP9g+xD/nrq0LnF3j34o=
X-Google-Smtp-Source: AGHT+IHlMDTJWRZI7iRXGPwx+TtddvlRVnCnGm5VBOp3T9fhu3R9Log7EjiDBxd4SwCq6piT5qhKpQ==
X-Received: by 2002:a05:6902:1008:b0:e7d:ce24:636e with SMTP id 3f1490d57ef6-e842bcf2cfdmr11159420276.31.1750580435874;
        Sun, 22 Jun 2025 01:20:35 -0700 (PDT)
Received: from localhost.localdomain (h209.207.88.75.dynamic.ip.windstream.net. [75.88.207.209])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb932fsm1746692276.55.2025.06.22.01.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 01:20:34 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: jhauga <johnhaugabook@gmail.com>
Subject: [PATCH 4/4] faq.html: add 3.4 run cloned site locally
Date: Sun, 22 Jun 2025 04:20:02 -0400
Message-ID: <20250622082003.1685-5-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250622082003.1685-1-johnhaugabook@gmail.com>
References: <20250622082003.1685-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: jhauga <johnhaugabook@gmail.com>

---
 faq/faq.html | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/faq/faq.html b/faq/faq.html
index 6be1e54e..8b847da9 100644
--- a/faq/faq.html
+++ b/faq/faq.html
@@ -1,5 +1,5 @@
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
-<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charse=
t=3DUTF-8"><title>Cygwin FAQ</title><link rel=3D"stylesheet" type=3D"text/c=
ss" href=3D"docbook.css"><meta name=3D"generator" content=3D"DocBook XSL St=
ylesheets Vsnapshot"><link rel=3D"home" href=3D"faq.html" title=3D"Cygwin F=
AQ"></head><body bgcolor=3D"white" text=3D"black" link=3D"#0000FF" vlink=3D=
"#840084" alink=3D"#0000FF"><div class=3D"navheader"><table width=3D"100%" =
summary=3D"Navigation header"><tr><th colspan=3D"3" align=3D"center">Cygwin=
 FAQ</th></tr></table><hr></div><div lang=3D"en" class=3D"article"><div cla=
ss=3D"titlepage"><div><div><h2 class=3D"title"><a name=3D"faq"></a>Cygwin F=
AQ</h2></div></div><hr></div><div class=3D"qandaset"><a name=3D"id1337"></a=
><dl><dt>1.  <a href=3D"faq.html#faq.about">About Cygwin</a></dt><dd><dl><d=
t>1.1. <a href=3D"faq.html#faq.what.what">What is it?</a></dt><dt>1.2. <a h=
ref=3D"faq.html#faq.what.supported">What versions of Windows are supported?=
</a></dt><dt>1.3. <a href=3D"faq.html#faq.what.where">Where can I get it?</=
a></dt><dt>1.4. <a href=3D"faq.html#faq.what.free">Is it free software?</a>=
</dt><dt>1.5. <a href=3D"faq.html#faq.what.version">What version of Cygwin =
is this, anyway?</a></dt><dt>1.6. <a href=3D"faq.html#faq.what.who">Who's b=
ehind the project?</a></dt></dl></dd><dt>2.  <a href=3D"faq.html#faq.setup"=
>Setting up Cygwin</a></dt><dd><dl><dt>2.1. <a href=3D"faq.html#faq.setup.s=
etup">What is the recommended installation procedure?</a></dt><dt>2.2. <a h=
ref=3D"faq.html#faq.setup.automated">What about an automated Cygwin install=
ation?</a></dt><dt>2.3. <a href=3D"faq.html#faq.setup.cli">Does the Cygwin =
Setup program accept command-line arguments?</a></dt><dt>2.4. <a href=3D"fa=
q.html#faq.setup.noroot">Can I install Cygwin without administrator rights?=
</a></dt><dt>2.5. <a href=3D"faq.html#faq.setup.c">Why not install in C:\?<=
/a></dt><dt>2.6. <a href=3D"faq.html#faq.setup.old-versions">Can I use the =
Cygwin Setup program to get old versions of packages (like gcc-2.95)?</a></=
dt><dt>2.7. <a href=3D"faq.html#faq.setup.install-security">How does Cygwin=
 secure the installation and update process?</a></dt><dt>2.8. <a href=3D"fa=
q.html#faq.setup.increase-install-security">What else can I do to ensure th=
at my installation and updates are secure?</a></dt><dt>2.9. <a href=3D"faq.=
html#faq.setup.virus">Is the Cygwin Setup program, or one of the packages, =
infected with a virus?</a></dt><dt>2.10. <a href=3D"faq.html#faq.setup.hang=
">My computer hangs when I run Cygwin Setup!</a></dt><dt>2.11. <a href=3D"f=
aq.html#faq.setup.what-packages">What packages should I download? Where are=
 'make', 'gcc', 'vi', etc?  </a></dt><dt>2.12. <a href=3D"faq.html#faq.setu=
p.everything">How do I just get everything?</a></dt><dt>2.13. <a href=3D"fa=
q.html#faq.setup.disk-space">How much disk space does Cygwin require?</a></=
dt><dt>2.14. <a href=3D"faq.html#faq.setup.what-upgraded">How do I know whi=
ch version I upgraded from?</a></dt><dt>2.15. <a href=3D"faq.html#faq.setup=
.setup-fails">What if the Cygwin Setup program fails?</a></dt><dt>2.16. <a =
href=3D"faq.html#faq.setup.name-with-space">My Windows logon name has a spa=
ce in it, will this cause problems?</a></dt><dt>2.17. <a href=3D"faq.html#f=
aq.setup.home">My HOME environment variable is not what I want.</a></dt><dt=
>2.18. <a href=3D"faq.html#faq.setup.uninstall-packages">How do I uninstall=
 individual packages?</a></dt><dt>2.19. <a href=3D"faq.html#faq.setup.unins=
tall-service">How do I uninstall a Cygwin service?</a></dt><dt>2.20. <a hre=
f=3D"faq.html#faq.setup.uninstall-all">How do I uninstall all of Cygwin?</a=
></dt><dt>2.21. <a href=3D"faq.html#faq.setup.testrels">How do I install Cy=
gwin test releases?</a></dt><dt>2.22. <a href=3D"faq.html#faq.setup.mirror"=
>Can the Cygwin Setup program maintain a ``mirror''?</a></dt><dt>2.23. <a h=
ref=3D"faq.html#faq.setup.cd">How can I make my own portable Cygwin on CD?<=
/a></dt><dt>2.24. <a href=3D"faq.html#faq.setup.registry">How do I save, re=
store, delete, or modify the Cygwin information stored in the registry?</a>=
</dt></dl></dd><dt>3.  <a href=3D"faq.html#faq.resources">Further Resources=
</a></dt><dd><dl><dt>3.1. <a href=3D"faq.html#faq.resources.documentation">=
Where's the documentation?</a></dt><dt>3.2. <a href=3D"faq.html#faq.resourc=
es.mailing-lists">What Cygwin mailing lists can I join?</a></dt><dt>3.3. <a=
 href=3D"faq.html#faq.resources.problems">What if I have a problem? (Or: Wh=
y won't you/the mailing list answer my questions?)</a></dt></dl></dd><dt>4.=
  <a href=3D"faq.html#faq.using">Using Cygwin</a></dt><dd><dl><dt>4.1. <a h=
ref=3D"faq.html#faq.using.missing-dlls">Why can't my application locate cyg=
ncurses-8.dll?  or cygintl-3.dll?  or cygreadline6.dll?  or ...?</a></dt><d=
t>4.2. <a href=3D"faq.html#faq.using.startup-slow">Starting a new terminal =
window is slow. What's going on?</a></dt><dt>4.3. <a href=3D"faq.html#faq.u=
sing.slow">Why is Cygwin suddenly so slow?</a></dt><dt>4.4. <a href=3D"faq.=
html#faq.using.shares">Why can't my services access network shares?</a></dt=
><dt>4.5. <a href=3D"faq.html#faq.using.path">How should I set my PATH?</a>=
</dt><dt>4.6. <a href=3D"faq.html#faq.using.not-found">Bash (or another she=
ll) says "command not found", but it's right there!</a></dt><dt>4.7. <a hre=
f=3D"faq.html#faq.using.converting-paths">How do I convert between Windows =
and UNIX paths?</a></dt><dt>4.8. <a href=3D"faq.html#faq.using.bashrc">Why =
doesn't bash read my .bashrc file on startup?</a></dt><dt>4.9. <a href=3D"f=
aq.html#faq.using.bash-insensitive">How can I get bash filename completion =
to be case insensitive?</a></dt><dt>4.10. <a href=3D"faq.html#faq.using.fil=
ename-spaces">Can I use paths/filenames containing spaces in them?</a></dt>=
<dt>4.11. <a href=3D"faq.html#faq.using.shortcuts">Why can't I cd into a sh=
ortcut to a directory?</a></dt><dt>4.12. <a href=3D"faq.html#faq.using.find=
">I'm having basic problems with find.  Why?</a></dt><dt>4.13. <a href=3D"f=
aq.html#faq.using.su">Why doesn't su work?</a></dt><dt>4.14. <a href=3D"faq=
.html#faq.using.man">Why doesn't man -k,
+<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charse=
t=3DUTF-8"><title>Cygwin FAQ</title><link rel=3D"stylesheet" type=3D"text/c=
ss" href=3D"docbook.css"><meta name=3D"generator" content=3D"DocBook XSL St=
ylesheets Vsnapshot"><link rel=3D"home" href=3D"faq.html" title=3D"Cygwin F=
AQ"></head><body bgcolor=3D"white" text=3D"black" link=3D"#0000FF" vlink=3D=
"#840084" alink=3D"#0000FF"><div class=3D"navheader"><table width=3D"100%" =
summary=3D"Navigation header"><tr><th colspan=3D"3" align=3D"center">Cygwin=
 FAQ</th></tr></table><hr></div><div lang=3D"en" class=3D"article"><div cla=
ss=3D"titlepage"><div><div><h2 class=3D"title"><a name=3D"faq"></a>Cygwin F=
AQ</h2></div></div><hr></div><div class=3D"qandaset"><a name=3D"id1337"></a=
><dl><dt>1.  <a href=3D"faq.html#faq.about">About Cygwin</a></dt><dd><dl><d=
t>1.1. <a href=3D"faq.html#faq.what.what">What is it?</a></dt><dt>1.2. <a h=
ref=3D"faq.html#faq.what.supported">What versions of Windows are supported?=
</a></dt><dt>1.3. <a href=3D"faq.html#faq.what.where">Where can I get it?</=
a></dt><dt>1.4. <a href=3D"faq.html#faq.what.free">Is it free software?</a>=
</dt><dt>1.5. <a href=3D"faq.html#faq.what.version">What version of Cygwin =
is this, anyway?</a></dt><dt>1.6. <a href=3D"faq.html#faq.what.who">Who's b=
ehind the project?</a></dt></dl></dd><dt>2.  <a href=3D"faq.html#faq.setup"=
>Setting up Cygwin</a></dt><dd><dl><dt>2.1. <a href=3D"faq.html#faq.setup.s=
etup">What is the recommended installation procedure?</a></dt><dt>2.2. <a h=
ref=3D"faq.html#faq.setup.automated">What about an automated Cygwin install=
ation?</a></dt><dt>2.3. <a href=3D"faq.html#faq.setup.cli">Does the Cygwin =
Setup program accept command-line arguments?</a></dt><dt>2.4. <a href=3D"fa=
q.html#faq.setup.noroot">Can I install Cygwin without administrator rights?=
</a></dt><dt>2.5. <a href=3D"faq.html#faq.setup.c">Why not install in C:\?<=
/a></dt><dt>2.6. <a href=3D"faq.html#faq.setup.old-versions">Can I use the =
Cygwin Setup program to get old versions of packages (like gcc-2.95)?</a></=
dt><dt>2.7. <a href=3D"faq.html#faq.setup.install-security">How does Cygwin=
 secure the installation and update process?</a></dt><dt>2.8. <a href=3D"fa=
q.html#faq.setup.increase-install-security">What else can I do to ensure th=
at my installation and updates are secure?</a></dt><dt>2.9. <a href=3D"faq.=
html#faq.setup.virus">Is the Cygwin Setup program, or one of the packages, =
infected with a virus?</a></dt><dt>2.10. <a href=3D"faq.html#faq.setup.hang=
">My computer hangs when I run Cygwin Setup!</a></dt><dt>2.11. <a href=3D"f=
aq.html#faq.setup.what-packages">What packages should I download? Where are=
 'make', 'gcc', 'vi', etc?  </a></dt><dt>2.12. <a href=3D"faq.html#faq.setu=
p.everything">How do I just get everything?</a></dt><dt>2.13. <a href=3D"fa=
q.html#faq.setup.disk-space">How much disk space does Cygwin require?</a></=
dt><dt>2.14. <a href=3D"faq.html#faq.setup.what-upgraded">How do I know whi=
ch version I upgraded from?</a></dt><dt>2.15. <a href=3D"faq.html#faq.setup=
.setup-fails">What if the Cygwin Setup program fails?</a></dt><dt>2.16. <a =
href=3D"faq.html#faq.setup.name-with-space">My Windows logon name has a spa=
ce in it, will this cause problems?</a></dt><dt>2.17. <a href=3D"faq.html#f=
aq.setup.home">My HOME environment variable is not what I want.</a></dt><dt=
>2.18. <a href=3D"faq.html#faq.setup.uninstall-packages">How do I uninstall=
 individual packages?</a></dt><dt>2.19. <a href=3D"faq.html#faq.setup.unins=
tall-service">How do I uninstall a Cygwin service?</a></dt><dt>2.20. <a hre=
f=3D"faq.html#faq.setup.uninstall-all">How do I uninstall all of Cygwin?</a=
></dt><dt>2.21. <a href=3D"faq.html#faq.setup.testrels">How do I install Cy=
gwin test releases?</a></dt><dt>2.22. <a href=3D"faq.html#faq.setup.mirror"=
>Can the Cygwin Setup program maintain a ``mirror''?</a></dt><dt>2.23. <a h=
ref=3D"faq.html#faq.setup.cd">How can I make my own portable Cygwin on CD?<=
/a></dt><dt>2.24. <a href=3D"faq.html#faq.setup.registry">How do I save, re=
store, delete, or modify the Cygwin information stored in the registry?</a>=
</dt></dl></dd><dt>3.  <a href=3D"faq.html#faq.resources">Further Resources=
</a></dt><dd><dl><dt>3.1. <a href=3D"faq.html#faq.resources.documentation">=
Where's the documentation?</a></dt><dt>3.2. <a href=3D"faq.html#faq.resourc=
es.mailing-lists">What Cygwin mailing lists can I join?</a></dt><dt>3.3. <a=
 href=3D"faq.html#faq.resources.problems">What if I have a problem? (Or: Wh=
y won't you/the mailing list answer my questions?)</a></dt><dt>3.4. <a href=
=3D"faq.html#faq.run.local.website">How do I clone and run a local version =
of the cygwin website?</a></dt></dl></dd><dt>4.  <a href=3D"faq.html#faq.us=
ing">Using Cygwin</a></dt><dd><dl><dt>4.1. <a href=3D"faq.html#faq.using.mi=
ssing-dlls">Why can't my application locate cygncurses-8.dll?  or cygintl-3=
.dll?  or cygreadline6.dll?  or ...?</a></dt><dt>4.2. <a href=3D"faq.html#f=
aq.using.startup-slow">Starting a new terminal window is slow. What's going=
 on?</a></dt><dt>4.3. <a href=3D"faq.html#faq.using.slow">Why is Cygwin sud=
denly so slow?</a></dt><dt>4.4. <a href=3D"faq.html#faq.using.shares">Why c=
an't my services access network shares?</a></dt><dt>4.5. <a href=3D"faq.htm=
l#faq.using.path">How should I set my PATH?</a></dt><dt>4.6. <a href=3D"faq=
.html#faq.using.not-found">Bash (or another shell) says "command not found"=
, but it's right there!</a></dt><dt>4.7. <a href=3D"faq.html#faq.using.conv=
erting-paths">How do I convert between Windows and UNIX paths?</a></dt><dt>=
4.8. <a href=3D"faq.html#faq.using.bashrc">Why doesn't bash read my .bashrc=
 file on startup?</a></dt><dt>4.9. <a href=3D"faq.html#faq.using.bash-insen=
sitive">How can I get bash filename completion to be case insensitive?</a><=
/dt><dt>4.10. <a href=3D"faq.html#faq.using.filename-spaces">Can I use path=
s/filenames containing spaces in them?</a></dt><dt>4.11. <a href=3D"faq.htm=
l#faq.using.shortcuts">Why can't I cd into a shortcut to a directory?</a></=
dt><dt>4.12. <a href=3D"faq.html#faq.using.find">I'm having basic problems =
with find.  Why?</a></dt><dt>4.13. <a href=3D"faq.html#faq.using.su">Why do=
esn't su work?</a></dt><dt>4.14. <a href=3D"faq.html#faq.using.man">Why doe=
sn't man -k,
 apropos or whatis work?</a></dt><dt>4.15. <a href=3D"faq.html#faq.using.ch=
mod">Why doesn't chmod work?</a></dt><dt>4.16. <a href=3D"faq.html#faq.usin=
g.shell-scripts">Why doesn't my shell script work?</a></dt><dt>4.17. <a hre=
f=3D"faq.html#faq.using.printing">How do I print under Cygwin?</a></dt><dt>=
4.18. <a href=3D"faq.html#faq.using.unicode">Why don't international (Unico=
de) characters work?</a></dt><dt>4.19. <a href=3D"faq.html#faq.using.weirdc=
hars">My application prints international characters but I only
 see gray boxes</a></dt><dt>4.20. <a href=3D"faq.html#faq.using.multiple-co=
pies">Is it OK to have multiple copies of the DLL?</a></dt><dt>4.21. <a hre=
f=3D"faq.html#faq.using.third-party.multiple-copies">
 I read the above but I want to bundle Cygwin with a product, and ship it
@@ -543,7 +543,7 @@ somewhat different setup of a Cygwin 1.5.x release.  As=
 soon as somebody set
 this up for recent Cygwin releases, we might add this information here.
 </p></td></tr><tr class=3D"question"><td align=3D"left" valign=3D"top"><a =
name=3D"faq.setup.registry"></a><a name=3D"id1369"></a><p><b>2.24.</b></p><=
/td><td align=3D"left" valign=3D"top"><p>How do I save, restore, delete, or=
 modify the Cygwin information stored in the registry?</p></td></tr><tr cla=
ss=3D"answer"><td align=3D"left" valign=3D"top"></td><td align=3D"left" val=
ign=3D"top"><p>Cygwin doesn't store anything important in the registry anym=
ore for
 quite some time.  There's no reason to save, restore or delete it.
-</p></td></tr><tr class=3D"qandadiv"><td align=3D"left" valign=3D"top" col=
span=3D"2"><h3 class=3D"title"><a name=3D"faq.resources"></a>3. Further Res=
ources</h3></td></tr><tr class=3D"toc"><td align=3D"left" valign=3D"top" co=
lspan=3D"2"><dl><dt>3.1. <a href=3D"faq.html#faq.resources.documentation">W=
here's the documentation?</a></dt><dt>3.2. <a href=3D"faq.html#faq.resource=
s.mailing-lists">What Cygwin mailing lists can I join?</a></dt><dt>3.3. <a =
href=3D"faq.html#faq.resources.problems">What if I have a problem? (Or: Why=
 won't you/the mailing list answer my questions?)</a></dt></dl></td></tr><t=
r class=3D"question"><td align=3D"left" valign=3D"top"><a name=3D"faq.resou=
rces.documentation"></a><a name=3D"id1371"></a><p><b>3.1.</b></p></td><td a=
lign=3D"left" valign=3D"top"><p>Where's the documentation?</p></td></tr><tr=
 class=3D"answer"><td align=3D"left" valign=3D"top"></td><td align=3D"left"=
 valign=3D"top"><p>If you have installed Cygwin, you can find lots of docum=
entation in
+</p></td></tr><tr class=3D"qandadiv"><td align=3D"left" valign=3D"top" col=
span=3D"2"><h3 class=3D"title"><a name=3D"faq.resources"></a>3. Further Res=
ources</h3></td></tr><tr class=3D"toc"><td align=3D"left" valign=3D"top" co=
lspan=3D"2"><dl><dt>3.1. <a href=3D"faq.html#faq.resources.documentation">W=
here's the documentation?</a></dt><dt>3.2. <a href=3D"faq.html#faq.resource=
s.mailing-lists">What Cygwin mailing lists can I join?</a></dt><dt>3.3. <a =
href=3D"faq.html#faq.resources.problems">What if I have a problem? (Or: Why=
 won't you/the mailing list answer my questions?)</a></dt><dt>3.4. <a href=
=3D"faq.run.local.website">How do I clone and run a local version of the cy=
gwin website?</a></dt></dl></td></tr><tr class=3D"question"><td align=3D"le=
ft" valign=3D"top"><a name=3D"faq.resources.documentation"></a><a name=3D"i=
d1371"></a><p><b>3.1.</b></p></td><td align=3D"left" valign=3D"top"><p>Wher=
e's the documentation?</p></td></tr><tr class=3D"answer"><td align=3D"left"=
 valign=3D"top"></td><td align=3D"left" valign=3D"top"><p>If you have insta=
lled Cygwin, you can find lots of documentation in
 <code class=3D"literal">/usr/share/doc/</code>.  Some packages have Cygwin=
 specific
 instructions in a file
 <code class=3D"literal">/usr/share/doc/Cygwin/<em class=3D"replaceable"><c=
ode>package_name</code></em>.README</code>.
@@ -567,8 +567,42 @@ and an API Reference at
 <a class=3D"ulink" href=3D"http://www.gnu.org/manual/" target=3D"_top">htt=
p://www.gnu.org/manual/</a>.
 </p></td></tr><tr class=3D"question"><td align=3D"left" valign=3D"top"><a =
name=3D"faq.resources.mailing-lists"></a><a name=3D"id1372"></a><p><b>3.2.<=
/b></p></td><td align=3D"left" valign=3D"top"><p>What Cygwin mailing lists =
can I join?</p></td></tr><tr class=3D"answer"><td align=3D"left" valign=3D"=
top"></td><td align=3D"left" valign=3D"top"><p>Comprehensive information ab=
out the Cygwin mailing lists can be found at
 <a class=3D"ulink" href=3D"https://cygwin.com/lists.html" target=3D"_top">=
https://cygwin.com/lists.html</a>.
-</p></td></tr><tr class=3D"question"><td align=3D"left" valign=3D"top"><a =
name=3D"faq.resources.problems"></a><a name=3D"id1373"></a><p><b>3.3.</b></=
p></td><td align=3D"left" valign=3D"top"><p>What if I have a problem? (Or: =
Why won't you/the mailing list answer my questions?)</p></td></tr><tr class=
=3D"answer"><td align=3D"left" valign=3D"top"></td><td align=3D"left" valig=
n=3D"top"><p>Comprehensive information about reporting problems with Cygwin=
 can be found at <a class=3D"ulink" href=3D"https://cygwin.com/problems.htm=
l" target=3D"_top">https://cygwin.com/problems.html</a>.
-</p></td></tr><tr class=3D"qandadiv"><td align=3D"left" valign=3D"top" col=
span=3D"2"><h3 class=3D"title"><a name=3D"faq.using"></a>4. Using Cygwin</h=
3></td></tr><tr class=3D"toc"><td align=3D"left" valign=3D"top" colspan=3D"=
2"><dl><dt>4.1. <a href=3D"faq.html#faq.using.missing-dlls">Why can't my ap=
plication locate cygncurses-8.dll?  or cygintl-3.dll?  or cygreadline6.dll?=
  or ...?</a></dt><dt>4.2. <a href=3D"faq.html#faq.using.startup-slow">Star=
ting a new terminal window is slow. What's going on?</a></dt><dt>4.3. <a hr=
ef=3D"faq.html#faq.using.slow">Why is Cygwin suddenly so slow?</a></dt><dt>=
4.4. <a href=3D"faq.html#faq.using.shares">Why can't my services access net=
work shares?</a></dt><dt>4.5. <a href=3D"faq.html#faq.using.path">How shoul=
d I set my PATH?</a></dt><dt>4.6. <a href=3D"faq.html#faq.using.not-found">=
Bash (or another shell) says "command not found", but it's right there!</a>=
</dt><dt>4.7. <a href=3D"faq.html#faq.using.converting-paths">How do I conv=
ert between Windows and UNIX paths?</a></dt><dt>4.8. <a href=3D"faq.html#fa=
q.using.bashrc">Why doesn't bash read my .bashrc file on startup?</a></dt><=
dt>4.9. <a href=3D"faq.html#faq.using.bash-insensitive">How can I get bash =
filename completion to be case insensitive?</a></dt><dt>4.10. <a href=3D"fa=
q.html#faq.using.filename-spaces">Can I use paths/filenames containing spac=
es in them?</a></dt><dt>4.11. <a href=3D"faq.html#faq.using.shortcuts">Why =
can't I cd into a shortcut to a directory?</a></dt><dt>4.12. <a href=3D"faq=
.html#faq.using.find">I'm having basic problems with find.  Why?</a></dt><d=
t>4.13. <a href=3D"faq.html#faq.using.su">Why doesn't su work?</a></dt><dt>=
4.14. <a href=3D"faq.html#faq.using.man">Why doesn't man -k,
+</p></td></tr><tr class=3D"question"><td align=3D"left" valign=3D"top"><a =
name=3D"faq.resources.problems"></a><a name=3D"id1373"></a><p><b>3.3.</b></=
p></td><td align=3D"left" valign=3D"top"><p>What if I have a problem? (Or: =
Why won't you/the mailing list answer my questions?)</p></td></tr><tr class=
=3D"answer"><td align=3D"left" valign=3D"top"></td><td align=3D"left" valig=
n=3D"top"><p>Comprehensive information about reporting problems with Cygwin=
 can be found at <a class=3D"ulink" href=3D"https://cygwin.com/problems.htm=
l" target=3D"_top">https://cygwin.com/problems.html</a>.</p></td></tr><tr c=
lass=3D"question"><td align=3D"left" valign=3D"top"><a name=3D"faq.run.loca=
l.website"></a><a name=3D"id1374"></a><p><b>3.4.</b></p></td><td align=3D"l=
eft" valign=3D"top"><p>How do I clone and run a local version of the cygwin=
 website?</p></td></tr><tr class=3D"answer"><td align=3D"left" valign=3D"to=
p"></td><td align=3D"left" valign=3D"top"><p>First, clone the website repos=
itory using <code class=3D"literal">git clone https://cygwin.com/git/cygwin=
-htdocs.git</code>. </p>
+<p>To retrieve the documentation files from the doc build, see <a href=3D"=
#faq.programming.building-cygwin">newlib-cygwin install</a> and follow the =
instructions there. After building <code>newlib-cygwin</code>, return to th=
e root of the cloned site and run <code class=3D"literal">mkdir doc/preview=
</code>. Then, from the <code>build</code> directory of <code>newlib-cygwin=
</code>, copy the <code>winsup/doc/cygwin-ug-net</code> folder into the <co=
de>doc/preview</code> directory in the site root.</p><p>
+Next, ensure you have a server program capable of creating a local host us=
ing a <code>httpd.conf</code> file e.g. <code>httpd</code>. If you're on Wi=
ndows, you can install <code>httpd</code> using <code class=3D"literal">win=
get install ApacheLounge.httpd</code>, which works well for this purpose.</=
p><p>After installing a server program such as <code>httpd</code>, create a=
 <code>httpd.conf</code> file in the site root. If you're using software li=
ke <code>XAMPP</code> or <code>AMPPS</code>, configure the <code>httpd.conf=
</code> using the example below as a guide. If you're using a command-line =
tool like <code>httpd</code>, you can also use the example below, just adju=
st the paths and other values as needed.</p>
+<p><b>Tip:</b> Use <code>which httpd</code> to locate <code>path/to/Apache=
24/bin</code>, adjusting <code>Apache24/modules</code> accordingly.</p><pre=
 class=3D"screen">
+# httpd.conf (in current folder)
+ServerRoot "c:/Users/NAME/path/to/Apache24/bin"
+Listen 8000
+ServerName localhost
+DocumentRoot "C:/Users/NAME/cygwin-htdocs"
+
+LoadModule rewrite_module "C:/Users/NAME/path/to/Apache24/modules/mod_rewr=
ite.so"
+LoadModule alias_module "C:/Users/NAME/path/to/Apache24/modules/mod_alias.=
so"
+LoadModule mime_module "C:/Users/NAME/path/to/Apache24/modules/mod_mime.so"
+LoadModule dir_module "C:/Users/NAME/path/to/Apache24/modules/mod_dir.so"
+LoadModule include_module "C:/Users/NAME/path/to/Apache24/modules/mod_incl=
ude.so"
+LoadModule authz_core_module "C:/Users/NAME/path/to/Apache24/modules/mod_a=
uthz_core.so"
+LoadModule log_config_module "C:/Users/NAME/path/to/Apache24/modules/mod_l=
og_config.so"
+
+&lt;Directory "C:/Users/NAME/cygwin-htdocs"&gt;
+    Options +Includes +Indexes
+    AllowOverride All
+    Require all granted
+&lt;/Directory&gt;
+
+AddType text/html .html
+AddOutputFilter INCLUDES .html
+Options +Includes
+
+DirectoryIndex index.html
+
+TypesConfig "C:/Users/NAME/path/to/Apache24/conf/mime.types"
+PidFile "C:/Users/NAME/cygwin-htdocs/httpd.pid"
+
+ErrorLog "C:/Users/NAME/cygwin-htdocs/error.log"
+CustomLog "C:/Users/NAME/cygwin-htdocs/access.log" common
+</pre><p>Make sure the <code>httpd.conf</code> file is in the root of the =
cloned site, then run <code class=3D"literal">httpd.exe -f "%cd%\httpd.conf=
" -DFOREGROUND</code> to start the server. Once it's running, open <code>ht=
tp://localhost:8000/</code> in your browser.</p></td></tr><tr class=3D"qand=
adiv"><td align=3D"left" valign=3D"top" colspan=3D"2"><h3 class=3D"title"><=
a name=3D"faq.using"></a>4. Using Cygwin</h3></td></tr><tr class=3D"toc"><t=
d align=3D"left" valign=3D"top" colspan=3D"2"><dl><dt>4.1. <a href=3D"faq.h=
tml#faq.using.missing-dlls">Why can't my application locate cygncurses-8.dl=
l?  or cygintl-3.dll?  or cygreadline6.dll?  or ...?</a></dt><dt>4.2. <a hr=
ef=3D"faq.html#faq.using.startup-slow">Starting a new terminal window is sl=
ow. What's going on?</a></dt><dt>4.3. <a href=3D"faq.html#faq.using.slow">W=
hy is Cygwin suddenly so slow?</a></dt><dt>4.4. <a href=3D"faq.html#faq.usi=
ng.shares">Why can't my services access network shares?</a></dt><dt>4.5. <a=
 href=3D"faq.html#faq.using.path">How should I set my PATH?</a></dt><dt>4.6=
. <a href=3D"faq.html#faq.using.not-found">Bash (or another shell) says "co=
mmand not found", but it's right there!</a></dt><dt>4.7. <a href=3D"faq.htm=
l#faq.using.converting-paths">How do I convert between Windows and UNIX pat=
hs?</a></dt><dt>4.8. <a href=3D"faq.html#faq.using.bashrc">Why doesn't bash=
 read my .bashrc file on startup?</a></dt><dt>4.9. <a href=3D"faq.html#faq.=
using.bash-insensitive">How can I get bash filename completion to be case i=
nsensitive?</a></dt><dt>4.10. <a href=3D"faq.html#faq.using.filename-spaces=
">Can I use paths/filenames containing spaces in them?</a></dt><dt>4.11. <a=
 href=3D"faq.html#faq.using.shortcuts">Why can't I cd into a shortcut to a =
directory?</a></dt><dt>4.12. <a href=3D"faq.html#faq.using.find">I'm having=
 basic problems with find.  Why?</a></dt><dt>4.13. <a href=3D"faq.html#faq.=
using.su">Why doesn't su work?</a></dt><dt>4.14. <a href=3D"faq.html#faq.us=
ing.man">Why doesn't man -k,
 apropos or whatis work?</a></dt><dt>4.15. <a href=3D"faq.html#faq.using.ch=
mod">Why doesn't chmod work?</a></dt><dt>4.16. <a href=3D"faq.html#faq.usin=
g.shell-scripts">Why doesn't my shell script work?</a></dt><dt>4.17. <a hre=
f=3D"faq.html#faq.using.printing">How do I print under Cygwin?</a></dt><dt>=
4.18. <a href=3D"faq.html#faq.using.unicode">Why don't international (Unico=
de) characters work?</a></dt><dt>4.19. <a href=3D"faq.html#faq.using.weirdc=
hars">My application prints international characters but I only
 see gray boxes</a></dt><dt>4.20. <a href=3D"faq.html#faq.using.multiple-co=
pies">Is it OK to have multiple copies of the DLL?</a></dt><dt>4.21. <a hre=
f=3D"faq.html#faq.using.third-party.multiple-copies">
 I read the above but I want to bundle Cygwin with a product, and ship it
--=20
2.46.0.windows.1

