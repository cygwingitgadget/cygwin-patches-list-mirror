Return-Path: <SRS0=55nn=ZN=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by sourceware.org (Postfix) with ESMTPS id 8157C385772F
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 21:32:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8157C385772F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8157C385772F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1130
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751319142; cv=none;
	b=pNnHk/ANw3GHm9tUXaePdPjWFv6bAwQGND1JJvZdhaHjjySvr+7tnLnF/ROkJfq5Zbo2uHv84AYnRiBrljb1TqTwO0pFFC+Z6Ur+6vBJqJ4h74bLZQZu7arQDqHeUSpQ1W1pZeFAjX68qUUuJjzdOu9chQrsuCdkobZE4jhlBdQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751319142; c=relaxed/simple;
	bh=n6EPLSzJ1preNJzzcsLGrOoVP/PAkwi1c+90W49R+c4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=AeK8XI46jY0/hFLXWksKhyrt+rxucJ1FzvIoZwhKe0QQ2CgbkUtewrfpnYuXeaWvE4CzGDDQK3yKAEFEZZhgZPycIi4yfDyEsAPdHa5FG22J96WU8o51QRsDcPdPbZh+icYT5RQV0Bd8WFAR/EbtVfTciKxzpZ2ScyZIooI+j18=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8157C385772F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HkenOeHf
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-7115e32802bso26360517b3.1
        for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 14:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751319141; x=1751923941; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJQKOise0WF7Xh0YdYjDXE9HGUByWpV08VI+zAPARbk=;
        b=HkenOeHfYg6n5ZzM8n3B4JZqwhNNNvg06Xnaa/mylov7+W5zY8eGjX5qY+mbaUULBO
         uR/YYNsMdOXv/p7gAXblg+tMHtuBARe4b8WUbLVvNiJiaxB/IY+Vflu9sAEe1lYQJwEo
         /OnFfLtAWBzpwXTwZ2Y17dRC513PllaInUSKfujx9ME1oW80MMN7/V/KzZYVdt2Y0Mr+
         KsI7MmqIk1cGTMGXpFq2ONwqmfIbFkhnjCMSrlj10XRNksJWRlQRfAJsPXF641/PWOTh
         i0v8Kz7oJsiqt8xxaCpFSgAMvpwNDk6g09Dkca8Pfv3bm67oo+61hX+SpKPkNB0rQUnr
         1bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751319141; x=1751923941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJQKOise0WF7Xh0YdYjDXE9HGUByWpV08VI+zAPARbk=;
        b=SIoKHufcHaylYjuHDZBjCMv7lEr04XoWcQ4786OAitlO7XounTDvj/yj6XXTzlSRT+
         IKorH6WkLDxzKqetbWUr/owCuGEoenU0jN7oXLf6b3s8GWmoc+hdAHWXuE+mB0lQ4al5
         xgzgvQ9Roe/U6W/w9ufMe/mS6nB7380nl1BiIPq8Z3nH2pjNvT18qF4c2GhFpDxKb91N
         gtW1mhkX+aNR76ZDwE82uwOByBihcMbUIIpsCSoqdjLugjRfp/2VAB31Qf7mlOFCWENI
         FK2H2MqmBVrLx10KRDb5APC8LI3aDpvJwALItRXWbeyM87DIkvOFJi95bIhoaGQJmEya
         DeuA==
X-Gm-Message-State: AOJu0YxSwDnrs6RR3sYzvG84EAusMpzPCcUaCQEYZO2py8ads/Xir0KI
	TE7PAcjWaFN4ai+zPyzeGIkFXGv8BK6wykNyW7bUcOl52NlsjmOxEZED0FugqQ==
X-Gm-Gg: ASbGncsMB+4hdVrZFJXqQD9gpTAm56IOeXRbOU3PA4M03rFjkiylbmZCyy5TTDRwaCL
	FCArsijO2s0PdP/uKIP94T5Ya1u8jl9sg2X5GN2bvsMPIOyYIT3+gBpjO+E3sAEa/Glj/u1/ImY
	O3t6eCp3SGKcE4ufm0ANvWNPe71zMis6WC5sSHD68TkZI2iU/YQXYVHKqZHRfR8/aoIyXW8yP8Y
	UnO++hbCxy3Y/rBzpZGz3nfu135QFX/Y1sI+656pAlgHdTf9XtGfltXWoXCcQdgCNm1ge8I1ER9
	8KsDn2kSARrE2w1pvSi0eI7car+hpq1k0II2nxYVtqbE8if02eWTaAiC3SK4DCnoHB/sqambE2w
	ggNoqUxs5G1PlZiGpswJBTSMxyGS9pNqG7fzr4WSFP2RH7mBLH5YzGAWNyLjNfvBUexsb
X-Google-Smtp-Source: AGHT+IGkd/txEi9efbX7HjnZOa+S3OWHT4YTtytT7ixJ/MPuksR9A2Ub8VMD+yfssAbn74JOM2/kmw==
X-Received: by 2002:a05:690c:319:b0:712:d824:9202 with SMTP id 00721157ae682-715171471femr184999067b3.9.1751319141380;
        Mon, 30 Jun 2025 14:32:21 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515bee26csm17046267b3.17.2025.06.30.14.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:32:20 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH v2 2/4] cygwin: faq-programming-6.21 ready-made download commands
Date: Mon, 30 Jun 2025 17:32:03 -0400
Message-ID: <20250630213205.988-3-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250630213205.988-1-johnhaugabook@gmail.com>
References: <20250630213205.988-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>=0D

Running setup-x86_64.exe and performing an individual search for each packa=
ge, =0D
is a pain in the neck. And the user running "setup-x86_64.exe -q -P package=
Name"=0D
may have a typo and the package would not be installed.=0D
=0D
So by copying and pasting these commands into the terminal setup-x86_64.exe=
 runs =0D
a preliminary search, so when they reach the "Select Packages" window these=
 packages=0D
will be amongst the packages ready to be downloaded. Additionally sorting t=
hem makes it =0D
easier to go down the list, and make sure all packages are listed.=0D
=0D
Putting separate commands allows the user to pick which packages to downloa=
d in the =0D
case they want to run config, where those packages are not needed i.e. --wi=
thout-cross-bootstrap.=0D
=0D
Signed-off-by: John Haugabook <johnhaugabook@gmail.com>=0D
---=0D
 winsup/doc/faq-programming.xml | 12 ++++++++++++=0D
 1 file changed, 12 insertions(+)=0D
=0D
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xm=
l=0D
index 4daeb7079..b9269187c 100644=0D
--- a/winsup/doc/faq-programming.xml=0D
+++ b/winsup/doc/faq-programming.xml=0D
@@ -710,6 +710,18 @@ packages. Building the documentation can be disabled w=
ith the=0D
 <literal>--disable-doc</literal> option to <literal>configure</literal>.=0D
 </para>=0D
 =0D
+<para>=0D
+Below are ready-made commands to download the required =0D
+packages. When you reach the <emphasis>Select Packages</emphasis> screen, =
=0D
+these packages should be amongst the search results.=0D
+</para>=0D
+<screen>=0D
+$ setup-x86_64.exe -P autoconf,automake,cocom,gcc-g++,git,libtool,make,pat=
ch,perl                           # download build tool packages=0D
+$ setup-x86_64.exe -P gettext-devel,libiconv,libiconv-devel,libiconv2,libz=
std-devel,zlib-devel              # download dumper packages=0D
+$ setup-x86_64.exe -P mingw64-x86_64-gcc-g++,mingw64-x86_64-zlib          =
                                  # download utility packages=0D
+$ setup-x86_64.exe -P dblatex,docbook-utils,docbook-xml45,docbook-xsl,docb=
ook2X,perl-XML-SAX-Expat,xmlto    # download documentation packages=0D
+</screen>=0D
+=0D
 <para>Next, check out the Cygwin sources from the=0D
 <ulink url=3D"https://cygwin.com/git.html">Cygwin GIT source repository</u=
link>).=0D
 This is the <emphasis>preferred method</emphasis> for acquiring the source=
s.=0D
-- =0D
2.49.0.windows.1=0D
=0D
