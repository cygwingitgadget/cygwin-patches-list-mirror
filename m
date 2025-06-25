Return-Path: <SRS0=FsbT=ZI=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by sourceware.org (Postfix) with ESMTPS id 6BCDA3857C67
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 01:39:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6BCDA3857C67
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6BCDA3857C67
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b2c
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750815569; cv=none;
	b=nqnCWs/tFKHsGTVch4v5SthBBOB92ILrZSBo5BWekAIURJrEyDskfDSKR4NQ6SRk4vQzFVQR6LNImifZmiOl764Ki/95mZ701b83Fdk27lyDWUE/QLN5UCQAOirS23kdEJ3wIxAaXBbM0XrqRMcgipfj0lod024vGUAFEtDfnaM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750815569; c=relaxed/simple;
	bh=KLcW08uczb/4BYr1E5A86Fa+iaNFCTN9Obf//jRVu6E=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Tcbruj91Aa40xjxH3ZTIs3ZNy16cf0wsrPiJglxJ/INF4fZQ2nbgI2BAHs3WCSisEVaMIq+yhhTJhlykCeMRLoB2knK56pUi1ZL66UKmKwlHSd+egTm4iHtBZ24V/sGrzdLc/JXVucOh5fjflkOggkmJbV3B4cRHn97jI8R6qA8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6BCDA3857C67
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GUZlI/SF
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-e812c817de0so4121608276.0
        for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 18:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750815568; x=1751420368; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLcW08uczb/4BYr1E5A86Fa+iaNFCTN9Obf//jRVu6E=;
        b=GUZlI/SFL5H2+ihoIURaY8xy6dMba65Zk1mSMo1wt7SW2xIvpTY1/EQOPxK0XTWDeW
         gNNVbKikZKP40S9rHRTg/UIb153O9/m0wC3ftxlx9VlLwPg6cJ4KhsZ0RkKmMBnXGP/f
         kVT1gK15cpcZF25zIBEmtZ884VeyiXkKqe1qj8y1tj1njmY7fLh6PmD8dC5CHd59tb8o
         0uylywbUnQ9ufjuCzwWyAfE2lzKuMFjase4eRoqAOAymv+vgPvlu1135Hxjd06jayUHT
         X96Q7t8AMnr47Cei57ypbwg31eeGN3lrEEYmG59vLELhOis51buzfmKQkNO8vAg1eklw
         wcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750815568; x=1751420368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLcW08uczb/4BYr1E5A86Fa+iaNFCTN9Obf//jRVu6E=;
        b=arcgwK6HYFr9yG3pUp7c2b4lJhdrfAEgFRICJJoQ3jAWKDu16S3qEZzWlGt/NaIQHo
         wDsY6aNcul8MAMjeevwLWcAkjsgP0HFhKlyXgUmZZyVOKQTHgNIiOsBIQt1G1GRwbZK7
         DCVWz38NvUr1LBwia9ke336H8oNx00yQUNcxe+J7/PKkYgCtqqN4JRmP8AgfQ475bTJb
         mD5hrgKIH9og+6N20rnr8tWwy1nLPuWRMzfb3NbojvigZkKbbAfjb/daVIqxwuW9vvTt
         vUY2rHXzn2S6vR0Bnwj53YE6ETs7t6HG27kv8g8tLY076JfmoBokvBsHaKsgF12fLK1s
         40yQ==
X-Gm-Message-State: AOJu0YyBmTO16zetwPSNc3xyMvqT9wNFj+Z1E+Vsb2d+pSyK2UbhxuWr
	zjN9B5aNJXQ8yZddu0bCWqbowiMuts8YlsenyVUoKiG1ftV30yKBQBrhYJEcfQ==
X-Gm-Gg: ASbGncvxzRc6XoF/w4471Bmq2DIp9c8xXSw080iDRKloQBxxER8VapjvKk8ba93Wzlf
	rTafp7HgD8Uz/TpmdUbomF2GJbUavEF7EKCkVVMSUqu3/hzgF0Parvc9EgjAA2QwL8QpRcc7sIU
	m2gmQqwBapuZW/NhqXenls1sAZ84AtgQcpZOLTiNQc8Z8q9JSexVTwaHOXcvWIe95ZuUYBOiEof
	r28TTt7jyVL8NWuH1J/LolrYm9E8GqzKEftSWErW9wffg8MmZaoq0ijsKmSShQuENyf+IJ78wPX
	CDEUXV7otgaw8YGeRspImwFMO6VSQ/jAyCTU9oSgbogBfd/4OSCY5cLiTCsrZST9EfyOjOPPqlI
	MWo5llVBLhrerxmoJfRZ/mPZxpYWHAU/Kib/f3nVMRWdwV50A7rWk/hbb3sBVFJwJ+o4q
X-Google-Smtp-Source: AGHT+IFVL7gWudWi9TEDJCJqwP6nViNt0iP5PbvLO4izW9rq+JIIYPN0jqJQbP2JNn3BZT0UZVsm/g==
X-Received: by 2002:a05:6902:2b90:b0:e7d:c9f4:ed81 with SMTP id 3f1490d57ef6-e86018cf84bmr1443787276.34.1750815568200;
        Tue, 24 Jun 2025 18:39:28 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb1fadsm3327676276.50.2025.06.24.18.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 18:39:27 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 4/5] cygwin: faq-programming-6.21 install tips
Date: Tue, 24 Jun 2025 21:39:07 -0400
Message-ID: <20250625013908.628-5-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250625013908.628-1-johnhaugabook@gmail.com>
References: <20250625013908.628-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>=0D

One of the tips was mentioned in "[PATCH 1/4] cygwin: faq-programming-6.21 =
add 5 required packages", which is the error:=0D
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
and running:=0D
> perl -MXML::SAX -e 'XML::SAX-&gt;add_parser(q(XML::SAX::Expat)); XML::SAX=
-&gt;save_parsers()'=0D
=0D
will resolve this error. But note - out of the several times I've gone thro=
ugh the installation, I have had to run this command twice. All all but one=
 of the installs it did not throw the error for some reason.=0D
=0D
In the case that someone is using a similar OS (Windows 10 and 11), archite=
cture (x64-based PC), and/or version of cygwin (3.6.3) for building cygwin =
from newlib-cygwin, this commit may prevent those errors from occurring.=0D
=0D
Signed-off-by: John Haugabook <johnhaugabook@gmail.com>=0D
---=0D
 winsup/doc/faq-programming.xml | 12 ++++++++++++=0D
 1 file changed, 12 insertions(+)=0D
=0D
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xm=
l=0D
index fa3f097a9..093d05940 100644=0D
--- a/winsup/doc/faq-programming.xml=0D
+++ b/winsup/doc/faq-programming.xml=0D
@@ -736,6 +736,18 @@ Otherwise, if you are trying to duplicate a cygwin rel=
ease then you should=0D
 download the corresponding source package=0D
 (<literal>cygwin-x.y.z-n-src.tar.bz2</literal>). </para> =0D
 =0D
+<para>=0D
+<emphasis role=3D'bold'>Tip:</emphasis> ensure Perl's XML::SAX module know=
s =0D
+about installed parsers by running:=0D
+</para>=0D
+<screen>perl -MXML::SAX -e 'XML::SAX-&gt;add_parser(q(XML::SAX::Expat)); X=
ML::SAX-&gt;save_parsers()'</screen>=0D
+=0D
+<para>=0D
+in the cygwin terminal. If an error appears, stating: =0D
+<code>could not find ParserDetails.ini ...</code>, then running the comman=
d =0D
+once more should resolve this.=0D
+</para>=0D
+=0D
 <para>You <emphasis>must</emphasis> build cygwin in a separate directory f=
rom=0D
 the source, so create something like a <literal>build/</literal> directory=
.=0D
 Assuming you checked out the source to=0D
-- =0D
2.49.0.windows.1=0D
=0D
