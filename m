Return-Path: <SRS0=SYvf=UH=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id F2CA338515E6
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 19:43:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F2CA338515E6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F2CA338515E6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736970211; cv=none;
	b=HrPQdtEB1N69TWn9UPBQV23FoC4QEIAV4pJ5GYOGf3oFio30uxJKPLMAyopihM4pQWaxNndnuTYkRybk9jUAT2yyrRFk41MgUFQh1obLgBKIpCNVOFtLMAjiwH4hq4Lqf9A49PUu2g64Di+TLYyocRjZ+X2qBl8Uk4YgyRPD+cI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736970211; c=relaxed/simple;
	bh=p9ksI3/ED/OmD0IyzqQ43MVkezmesmomaQRSA0t5/zA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=g+ih66KDqE0+Spe2Utt4z5XbLfbhqkGieSaF4nhp8JErQuvmNJKOJqWrOQrn0FTaEs80mt/2GlukZomNLCyi4yFsATrJ+HWyhy9l56A42/UukQEKddmsQYNHOfqFCwi3kuH08xSdxwG6Zd7pCagNVaCqaQ7xYNW+cXmC0RohnPI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F2CA338515E6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=aLqlpSKY
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 87844C0183;
	Wed, 15 Jan 2025 19:43:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id 2020D2002C;
	Wed, 15 Jan 2025 19:43:29 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH v6 3/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 not implemented new additions
Date: Wed, 15 Jan 2025 12:39:20 -0700
Message-ID: <a216df577267a5e8b61b220969da57691f6a341f.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2020D2002C
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: qq5gozrq4rg5dcy1iaq98o3e9hbdpezg
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18F1kLl1T47dM9vC9RVYdI9qsURbYJeRbs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=he; bh=pt4Crt3hA+3oRDQ9Grb+YK9LttakiO9UjIIIh31ZOHk=; b=aLqlpSKYYYU4TrYxXGSQnXNFEKudIyk3emgt1Q8ifN1H7eV4NyZ6g3Q4mS1mKOkMvlHFW3/ZtKDLRgaj4sZeO1+yMjNVOjJs3E7tMDi3x9ZNqYMqN4booNZ8/mgtDQdhjwv+oBVl/wt5Iptp4auIieTCX6k7T6qumtUWZhAoGy01SLkt7Hs3m5whVRdlvnx56ppb4+OACHfnFLtRRHm/IJN5pDCLffsKwuc7pFbNtkS/TQNuc5or91YqvknAKptqcZI+QHdtL9zMYqwNdsRiRnUqX3Uq55WRBXaNZhl1ufckEegVgX+7TOXAyWsP2aGyuZZnxGPGD7S1ry7oiWAXwQ==
X-HE-Tag: 1736970209-431720
X-HE-Meta: U2FsdGVkX198c2nXBrtuS3Z3CJnmCaMSMFTCnjGPYUvFlujdsyJsqFVEsnQqMdDhSQL5ki7mfOCIo2rTQ77edRbveCx5QMAnZKnOFQfHQ/AdMJBohaP1ilwQ+yycJQPAicMkrNVEr9z1Brwn1pWxxv0yW/+RUaIlK0qAB5qu1hM8rRV/G0NGxZpNqIHtRs2jbYqSTUMjmGWk9caewHY0dVk9F9/EOA4UlbNAqVLzTaEvH0aKDyyFkVPYJBsgZXRIWeBWzmQ7y9DAs8LLCDM2YtGbDTM4P6iyXUht5yCEGouoz1W0+EYjaC4V7yh/FbRURDKGR6p1gqOv1dYxsHt1IGoIdBIX9Lau1sSqVPQBLk2iph4lZXtogK2fIcjHk7I474DUVuXljVNbNn2a2mpYnA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add unavailable POSIX additions to Not Implemented section,
with mentions of headers and packages where they are expected.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 0b23a2251028..89728e050bef 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1681,9 +1681,14 @@ ISO/IEC DIS 9945 Information technology
 
 </sect1>
 
-<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single Unix Specification, Volume 7:</title>
+<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single UNIX® Specification Version 5:</title>
 
 <screen>
+    _Fork			(not available in "(sys/)unistd.h" header)
+    dcgettext_l			(not available in external gettext "libintl" library)
+    dcngettext_l		(not available in external gettext "libintl" library)
+    dgettext_l			(not available in external gettext "libintl" library)
+    dngettext_l			(not available in external gettext "libintl" library)
     endnetent
     fattach
     fmtmsg
@@ -1695,17 +1700,28 @@ ISO/IEC DIS 9945 Information technology
     getnetbyname
     getnetent
     getpmsg
+    getresgid			(not available in "(sys/)unistd.h" header)
+    getresuid			(not available in "(sys/)unistd.h" header)
+    gettext_l			(not available in external gettext "libintl" library)
     isastream
     mlockall
     munlockall
+    ngettext_l			(not available in external gettext "libintl" library)
+    posix_close			(not available in "(sys/)unistd.h" header)
+    posix_devctl		(prototyped in cygwin-devel "devctl.h" header)
     posix_mem_offset
     posix_trace[...]
-    posix_typed_[...]
+    posix_typed_mem_get_info	(not available in "(sys/)mman.h" header)
+    posix_typed_mem_open	(not available in "(sys/)mman.h" header)
     pthread_mutexattr_getrobust
     pthread_mutexattr_setrobust
     pthread_mutex_consistent
     putmsg
     setnetent
+    setresgid			(not available in "(sys/)unistd.h" header)
+    setresuid			(not available in "(sys/)unistd.h" header)
+    tcgetwinsize		(not available in "(sys/)termios.h" header)
+    tcsetwinsize		(not available in "(sys/)termios.h" header)
     ulimit
     waitid
 </screen>
-- 
2.45.1

