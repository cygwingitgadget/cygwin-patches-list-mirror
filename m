Return-Path: <SRS0=55nn=ZN=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by sourceware.org (Postfix) with ESMTPS id 4C264385802C
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 21:32:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4C264385802C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4C264385802C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b2e
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751319141; cv=none;
	b=sKa5noMm8KImPYnz4NixBV+opP0RCaEjzlJj7M/hOVyEtq02PneE2AVR4wi09wnmvPjaijVO9wZA1HZK+cKYVcUSBD7PqQPsgPc/vBZLSkCQqn3LvOhJ/mC8juVLTkm4qOKBCTqQkgfnT4fejGR38ZcB0t6i9CUG/JrBuZKeBTs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751319141; c=relaxed/simple;
	bh=cYXPfx+NHFc9g+N7eXcFwmjxRSEnJm6MWsVQt4pEydE=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Yhb3KfXj9MSjeEYSlbTOyy5dqloT3HWVIwx3yhCgp5B4Uoq1gnQJtEO1U1U1GtXL9CyawZMejfJKSNpEv6r9Od4iABwVHW3E77IRSxh4n/HQeNRMjdFLQa4/F5OuLU67NOlyEPLpQqOtpmnXLQucXNrylx3QPn1+jlPIRMg8Mt8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4C264385802C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YjEcIHjA
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso2253080276.2
        for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751319140; x=1751923940; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5M2ELf52e6auvQ9zrzt0MJH8csBlDgNKPqDk9mwJOw=;
        b=YjEcIHjAE4GdGgqFd+F/55yC3uAoMmZNSCu6D2bWBLd+k+7ncHrO2gv4ywJli71XSV
         VzIhZidso7LYM60pEtEl9Yh0ZzKg2/fCG9XkGzwobu/rQDdnars8FdSmW5uKEXb1qmU7
         bqjoH9IVSZEraBiaHiMef9UN6pNxhz1NEeYYNRlnqYjyNpVyCVpH/LpUW7kXRUiiZ3/X
         ywUkMmUMHwKSB21ZiqfB6OIpg4L3nNaBSKoUO+IvaiIDZTd9XNbQ/5PCpnL2j6aQR6so
         rNWDDcF7NqL69Qjl231GWie8pROVvRqRNQOaZf8BWCTcfzG5QP8bTw6yI8s+ZTI84Wfp
         r24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751319140; x=1751923940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5M2ELf52e6auvQ9zrzt0MJH8csBlDgNKPqDk9mwJOw=;
        b=X2CkwxlqPjCvTe41TBt022lUtrt2N1XGXbsFSzLCEqZJw8DTgbT4E7C1zvYCe+ygs4
         Rk+ypvZQExWize/HwcBnM71qXY30Qob7DbotibvXEp0juUcmBYaSnrNeAKIOfSu/ndhI
         CKgtnceaJ3dcjdbRUIX3nQDnVAfvOyqgdfyIKtAsqAaPai87Gy9cDa0qLCJYSHohPtNH
         CNhB7jwcEoYxyk0aBB1NTmFsokXeqUjKK5IAbJvLJztQTUqux+BmFe5qUtMtyOYXgJAh
         PXxLRiOMWwHH8Y1rxWumOwzvn8dI8uLlZqb55j4f+1aZ1q0d+vH00wVJMQl92qWuyJl2
         5gqA==
X-Gm-Message-State: AOJu0YwJStnVPzI9zh10EMkL0OqBCeRleHJhBB0gItsQiQ1RuVNboCVX
	gf7h/iRM0VTHH4ZDWaK5AhQw8SIHnrbG70ITiG4zlBspkA3Kw6rPxy7xNg80pg==
X-Gm-Gg: ASbGncuFvW+aGiIVjC3B5zk3q9IGJka2Mz9YUw5ApD8kWkK+LHv5et/f1Trn+hJcYaz
	cKVN0YnkHHAxU2vgc4Melp9Elok8OKxc8D+cvnQSxf3sCN4Yjj/mqgT7147/SzX3dQeJ1hyLkX8
	yd+PQF57glOmHIf8vvWGh+oDPjxrEQ/GijYwZj9c/nl2GPK5pdDtOM1iB7P7TrzzgX4+mTlpmy3
	nyHAuH/+zKzXOnKDic7zlO1Yso5Yc+IA/UYVwfxQ+KQABk2IW27BtLcWW4xe8/1JGC1p/DW+DhC
	e97CNhMkxkUWRxUDGloF/AZfBlS6Q63mGwkXHewnui4P72nM1clCzYJD6xShwl6km5j/xnoqofH
	o5svJDaHXZFF2NZDxs41IBcoD0szFfWP908qR0QxO2FLEQcJfC86FlOuwA+BHWvqhVZ5C
X-Google-Smtp-Source: AGHT+IE+0FkRSnuMCyQgHd+S4ToUizQhtl3UmS8GdfLT7wG+HLTa/yrSacWxWW9oEQxV2wzyGF378w==
X-Received: by 2002:a05:690c:1c:b0:70d:ed5d:b4b2 with SMTP id 00721157ae682-7151714e384mr243962417b3.13.1751319140042;
        Mon, 30 Jun 2025 14:32:20 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515bee26csm17046267b3.17.2025.06.30.14.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:32:19 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH v2 1/4] cygwin: faq-programming-6.21 add 5 required packages
Date: Mon, 30 Jun 2025 17:32:02 -0400
Message-ID: <20250630213205.988-2-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250630213205.988-1-johnhaugabook@gmail.com>
References: <20250630213205.988-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>=0D

Add 5 additional packages: =0D
for build: libtool; =0D
for dumper utility: libiconv, libiconv2; =0D
for documentation: perl-XML-SAX-Expat, docbook-utils. =0D
=0D
When building from a sandbox environment on Windows 11 using the packages c=
urrently listed =0D
in faq 6.21, I got the below error after calling "make":=0D
"""""""""""""""=0D
make[3]: Leaving directory '/home/WDAGUtilityAccount/build-newlib/x86_64-pc=
-cygwin/winsup/testsuite'=0D
Making all in doc=0D
make[3]: Entering directory '/home/WDAGUtilityAccount/build-newlib/x86_64-p=
c-cygwin/winsup/doc'=0D
  GEN      Makefile.dep=0D
  GEN      cygwin-ug-net/cygwin-ug-net.pdf=0D
  GEN      cygwin-api/cygwin-api.pdf=0D
  GEN      cygwin-api/cygwin-api.html=0D
  etc...=0D
  GEN      cygwin-api.info=0D
could not find ParserDetails.ini in /usr/share/perl5/vendor_perl/5.40/XML/S=
AX=0D
warning : xmlAddEntity: invalid redeclaration of predefined entity 'lt'=0D
sh: line 1: /usr/bin/iconv: No such file or directory=0D
-: warning: document without nodes=0D
  GEN      cygwin-ug-net.info=0D
could not find ParserDetails.ini in /usr/share/perl5/vendor_perl/5.40/XML/S=
AX=0D
warning : xmlAddEntity: invalid redeclaration of predefined entity 'lt'=0D
docbook2texi://refentry[@id=3D'proc']/refnamediv: section is too deep=0D
docbook2texi://refsect1[@id=3D'proc-desc']: section is too deep=0D
etc...=0D
sh: line 1: /usr/bin/iconv: No such file or directory=0D
-: warning: document without nodes=0D
make[3]: *** [Makefile:721: cygwin-ug-net.info] Error 141=0D
make[3]: Leaving directory '/home/WDAGUtilityAccount/build-newlib/x86_64-pc=
-cygwin/winsup/doc'=0D
make[2]: *** [Makefile:398: all-recursive] Error 1=0D
make[2]: Leaving directory '/home/WDAGUtilityAccount/build-newlib/x86_64-pc=
-cygwin/winsup'=0D
make[1]: *** [Makefile:9464: all-target-winsup] Error 2=0D
make[1]: Leaving directory '/home/WDAGUtilityAccount/build-newlib'=0D
make: *** [Makefile:883: all] Error 2=0D
"""""""""""""""=0D
=0D
Added the packages: libtool, libiconv, libiconv2, perl-XML-SAX-Expat, and d=
ocbook-utils. =0D
Ran "make" again, and the error was resolved, and the install completed. =0D
=0D
In the case that someone is using a similar OS (Windows 10 and 11), archite=
cture (x64-based PC), =0D
and/or verions of cygwin (3.6.3) for building cygwin from newlib-cygwin, th=
is commit may prevent =0D
those errors from occuring. =0D
=0D
Additionally sorting the packages makes it easier to go down the list when =
selecting from the =0D
"Select Packages" GUI window from setup-x86_64.exe, making sure all package=
s have been checked.=0D
=0D
Signed-off-by: John Haugabook <johnhaugabook@gmail.com>=0D
---=0D
 winsup/doc/faq-programming.xml | 24 +++++++++++++-----------=0D
 1 file changed, 13 insertions(+), 11 deletions(-)=0D
=0D
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xm=
l=0D
index a83429859..4daeb7079 100644=0D
--- a/winsup/doc/faq-programming.xml=0D
+++ b/winsup/doc/faq-programming.xml=0D
@@ -676,17 +676,18 @@ rewriting the runtime library in question from specs.=
..=0D
 <answer>=0D
 =0D
 <para>First, you need to make sure you have the necessary build tools=0D
-installed; you at least need <literal>gcc-g++</literal>,=0D
-<literal>make</literal>, <literal>automake</literal>,=0D
-<literal>autoconf</literal>, <literal>git</literal>, <literal>perl</litera=
l>,=0D
-<literal>cocom</literal> and <literal>patch</literal>.=0D
+installed; you at least need <literal>autoconf</literal>,=0D
+<literal>automake</literal>, <literal>cocom</literal>,=0D
+<literal>gcc-g++</literal>, <literal>git</literal>,=0D
+<literal>libtool</literal>, <literal>make</literal>,=0D
+<literal>patch</literal>, and <literal>perl</literal>.=0D
 </para>=0D
 =0D
 <para>=0D
 Additionally, building the <code>dumper</code> utility requires=0D
-<literal>gettext-devel</literal>, <literal>libiconv-devel</literal>, <lite=
ral>libzstd-devel</literal> and=0D
-<literal>zlib-devel</literal>.  Building this program can be disabled with=
 the=0D
-<literal>--disable-dumper</literal> option to <literal>configure</literal>=
.=0D
+<literal>gettext-devel</literal>, <literal>libiconv</literal>,=0D
+<literal>libiconv-devel</literal>, <literal>libiconv2</literal>,=0D
+<literal>libzstd-devel</literal>, and <literal>zlib-devel</literal>.=0D
 </para>=0D
 =0D
 <para>=0D
@@ -702,10 +703,11 @@ option to <literal>configure</literal>.=0D
 =0D
 <para>=0D
 Building the documentation also requires the <literal>dblatex</literal>,=0D
-<literal>docbook2X</literal>, <literal>docbook-xml45</literal>,=0D
-<literal>docbook-xsl</literal>, and <literal>xmlto</literal> packages.  Bu=
ilding=0D
-the documentation can be disabled with the <literal>--disable-doc</literal=
>=0D
-option to <literal>configure</literal>.=0D
+<literal>docbook-utils</literal>, <literal>docbook-xml45</literal>,=0D
+<literal>docbook-xsl</literal>, <literal>docbook2X</literal>,=0D
+<literal>perl-XML-SAX-Expat</literal>, and <literal>xmlto</literal>=0D
+packages. Building the documentation can be disabled with the =0D
+<literal>--disable-doc</literal> option to <literal>configure</literal>.=0D
 </para>=0D
 =0D
 <para>Next, check out the Cygwin sources from the=0D
-- =0D
2.49.0.windows.1=0D
=0D
