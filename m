Return-Path: <SRS0=FsbT=ZI=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by sourceware.org (Postfix) with ESMTPS id CE2303858416
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 01:39:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CE2303858416
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CE2303858416
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b2f
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750815565; cv=none;
	b=t8VQgpHKXDJFjSZuOiduUZI2KE6SNwFqdXcn9eAJZex+ct0Wzi+nf8UT3Bc7yX+PPqGSmA8DnQlARqSCScDeyS0Kqm/j1eaGGGAESLGd9bVGUthzi8yQT//ca4hpka0gYcT4mqfrui83eG0pmvqzIaHAUz2FAS+0ofWj362sDTM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750815565; c=relaxed/simple;
	bh=oagZJf66yJ/FBXtSBJUhebf+l+RHg7IWpAPWtpE1n8s=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=g6ow00stEuTPBOQmbEonPU2/uDapXMlvrgfxEeLwcPor7nadNBeU46hu4AD/YS2C2qizu37D+IsvMUOsaqpiurpaATuKi5ivkmXN1ih8eS/7EM+DGF5oS9VtxiOE9ameeuiNTKoH3aRyW6Gy1TaXHnNQpS0Zfpeo36e1vDTOtv8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CE2303858416
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XS8LZy9B
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-e819ebc3144so992503276.0
        for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 18:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750815565; x=1751420365; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrHODnuwv4yTsYtUNJM6rQjKVg3LJluIoeaRmupibYI=;
        b=XS8LZy9Bv6WPc6HZNkKzDOXwVtDc1izXZ+VUQzjyBhaljHqV6EkCtSC+3xQXcaxQYP
         y5eZRqSAVULwd0dF86zKhNnu+cYmwrRLlMsqC3v3muByS6Y1+0PdfmzTXwUUxX7YtMfm
         kl8RtqzWy7L7HsGYow7iCjZu0jDJMOQ/xmkof4NChSc1Ns5hHUvrkqSRW1/sypZhUZRd
         GPhp/M/Y8JOiSrJZmu2qmnAejip+XQiijMPH/PF/Sji+7KBj5K6r+NC8QZXZjrH6RdEn
         yLog9OpyMjbyddTb7Fx+mTHZaxYpu+4T3vyIjcwrmjVN5MQiZtZR4D0HrbnsDbDuGMUF
         wZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750815565; x=1751420365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrHODnuwv4yTsYtUNJM6rQjKVg3LJluIoeaRmupibYI=;
        b=mDgdBHU5DMT+SLZGYr8ogZxcGp0F2vyZYXwK6/aX8+xeLgVMNlYX3eeRGfhCoHeCZI
         0oI3CiLMG0pNBQhZ4Y52IvQetLAcsjrrdzhnHoIEecu91/ONTgqS1mZg6hAAzMVK3ba3
         p/eEoFMqMnMTCWgxLRXuB4asd8fl/9ojaH8+8kqjJ6Budkq4ZinoGrpNI1kSjZAZeISb
         NM69xOEFpsKy1Ei58oAllQucdN7TL3uytsYFmegPDbQjRnCtiX4LB9DNZEkhgLqHWVsf
         1HGp4+0q94NSzGf2ZWs60caZefrEfW7wA+wNjOWd9yDmx3dk02EtHlzapOnoBrQb26hk
         1KGg==
X-Gm-Message-State: AOJu0Yx6JawE6RauJVSVis9yPBq2Ycb/YtrTVMzeAalZdHR1l3Dhm/x4
	5VNrM3LwZX+tQe6pAIzWn+E04O22qwgD5fSEkU6u0/BgsoWbDNI94H9TsN1TPQ==
X-Gm-Gg: ASbGncu4RG9/7xheVrMVF75WKWyhX8hMFUlUU28TFW5+tdZdDLprQJRHW+7QQ99TUQK
	uaEHOkIiaF7zAM1fRP4kiYRacO51qaWdV034/zDDnHCGyE+59cIvLYoLm8jd2z99RkEUe3Kd8MO
	GKsPMc4OG+eg2WsxmMYUhA2foPtOl9Sqpm6EGUTXPqmXBVro1prxjHFEi0SvAcO7r6GXjhubSgy
	jAh+dj2Zl8fuf1hC6/SFZ6rf5Ji/Ee9B4hU8RNXY2H2QDFVvm2S5xJwJcnmf+f+0moEi7Stc4n+
	ltGk2WtCNJZhKkQH1bJpNfxlDP4Z7gEdVdPoWgOZajPLJlALFITVM/6uaOwAoPwFZ7r51p7ynOO
	HpgLgu1PTBpJ1O1s+qRFRso03j/s9hmjH0dePS6PviO22+oL+ekmU+TZ6YAFrbkM8s1cN
X-Google-Smtp-Source: AGHT+IFXN06s3m0h85IU8usExj/o/EVi0YV9pwIxkk+iy026AiVInrfAJs47B4uMYUE5JItKTVptNw==
X-Received: by 2002:a05:6902:2d08:b0:e84:46f2:8233 with SMTP id 3f1490d57ef6-e86018dace5mr1386643276.45.1750815564623;
        Tue, 24 Jun 2025 18:39:24 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb1fadsm3327676276.50.2025.06.24.18.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 18:39:23 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 1/5] cygwin: faq-programming-6.21 add 5 required packages
Date: Tue, 24 Jun 2025 21:39:04 -0400
Message-ID: <20250625013908.628-2-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250625013908.628-1-johnhaugabook@gmail.com>
References: <20250625013908.628-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>=0D

Add 5 additional packages; for build: libtool; for dumper utility: libiconv=
, libiconv2; for documentation: perl-XML-SAX-Expat, docbook-utils. When bui=
lding from a sandbox environment on Windows 11 using the packages currently=
 listed in faq 6.21, I got the below error after calling "make":=0D
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
ocbook-utils. Ran "make" again, and got another error: =0D
"""""""""""""""=0D
could not find ParserDetails.ini in /usr/share/perl5/vendor_perl/5.40/XML/S=
AX=0D
Can't locate XML/SAX/Expat.pm in @INC (you may need to install the XML::SAX=
::Expat module) (@INC entries checked: /usr/local/lib/perl5/site_perl/5.40/=
x86_64-cygwin-threads /usr/local/share/perl5/site_perl/5.40 /usr/lib/perl5/=
vendor_perl/5.40/x86_64-cygwin-threads /usr/share/perl5/vendor_perl/5.40 /u=
sr/lib/perl5/5.40/x86_64-cygwin-threads /usr/share/perl5/5.40) at /usr/shar=
e/perl5/vendor_perl/5.40/XML/SAX.pm line 147.=0D
"""""""""""""""=0D
=0D
which "[PATCH 3/4] cygwin: faq-programming-6.21 install tips" addresses, bu=
t after running command:=0D
> perl -MXML::SAX -e 'XML::SAX-&gt;add_parser(q(XML::SAX::Expat)); XML::SAX=
-&gt;save_parsers()'=0D
=0D
the error was resolved, and the install completed. But note - out of the se=
veral times I've gone through the installation, I have had to run this comm=
and twice; all but one of the installs failed for some reason.=0D
=0D
In the case that someone is using a similar OS (Windows 10 and 11), archite=
cture (x64-based PC), and/or verions of cygwin (3.6.3) for building cygwin =
from newlib-cygwin, this commit may prevent those errors from occuring. Add=
itionally sorting the packages makes it easier to go down the list when sel=
ecting from the "Select Packages" GUI window from setup-x86_64.exe, making =
sure all packages have been checked.=0D
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
