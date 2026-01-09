Return-Path: <SRS0=Giq6=7O=xs4all.nl=dhr-incognito@sourceware.org>
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	by sourceware.org (Postfix) with ESMTPS id 69E374BA2E06
	for <cygwin-patches@cygwin.com>; Fri,  9 Jan 2026 19:04:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 69E374BA2E06
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=xs4all.nl
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 69E374BA2E06
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=195.121.94.170
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767985457; cv=none;
	b=UQCuxq7MExwR4e70QESwXOO3m7u9YRiyNtxvLsjdKXfSFQ+TRmUHxwRoCocG16xNIZHC8ltZD4BbTSFVUf4FL46akI8OWp9dmaxhhAkM2G2JcMFDm5CSWve71fWk2t0RvYhzkcLOIUX/E9nu40BHEiQ0nsuyQ8rHbymYU7gFeWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767985457; c=relaxed/simple;
	bh=rV4XZW1M+ickhV89eDxmpou1uT6SJ3O12YtSMXrYhEM=;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version; b=f558xWKDHr+YidY3E9SEi2QLmFEiUFnRluW71lYF8czHMBL2lQqwY2wUrNlgdyfGkKa/zUJyeT/GDPFIBtIp8y0WVhTaj7e4DRhYmWU8LcYFWK9OZuX+Mn/5rZ1xqQKF//lpgRIw9rXQqLSL4fU+qv8S/sdfLf3By1FKuNVJrrk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 69E374BA2E06
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=lmSlEimi
X-KPN-MessageId: ffa4638c-ed8d-11f0-8a94-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ffa4638c-ed8d-11f0-8a94-005056ab378f;
	Fri, 09 Jan 2026 20:04:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=rnTDMKkx0r3Yer4k3Agf1q7XUk+CwN2oHeZZe7REVco=;
	b=lmSlEimicsgAW72s4pvzAmLXDEHaejZGhjyJIICOcqWGMTqSy32eYZxKRypd0ZNf/UerrM4r/TXpb
	 u9H7jUpR/BBUK30JrVouaijjS6fgr6FZXFn2Bgz8BdNO9v2W6ue1GHQFf1Jc06w44eEnQGEHZMsMBK
	 TrY9LQRlvMX4+7uISYs3InGZXOISZ90rdmOlNGwW5ajeBkhBhd6lU5/1HTNW/YfOpHL+Lo/9ESKDma
	 ucRMaPWUatKddq7qXV2E8jW4t4nZcO9PwPE1vSQ861ioIikN/t9WmDnNXUrPb9fSuUw3OZVafwRG1Y
	 CTMAgIu8C45yhcd+vyGtz2zDchQznEA==
X-KPN-MID: 33|wLDZObAS5QWnpXGR/aFXbnXQMlrXtg5Yig9vPYbWn5bpOo6DOtvI4qXVlIb//In
 QGK19OlTtiqpxW6HQTrsZaWCg08ViiKEO+wdxw3OtNXE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|kZNRJQ2flsDbrOkGKZpSuLk3Ie1meOWvx83XfrqGIWDNUtQyWx3WxqG04FmU9iw
 7lxn424oaaK537y9TFrf+GA==
X-Originating-IP: 77.173.35.122
Received: from frodo.. (77-173-35-122.fixed.kpn.net [77.173.35.122])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id fde7077f-ed8d-11f0-800f-005056ab7447;
	Fri, 09 Jan 2026 20:04:15 +0100 (CET)
From: "J.H. vd Water" <dhr-incognito@xs4all.nl>
To: cygwin-patches@cygwin.com
Cc: "J.H. vd Water" <dhr-incognito@xs4all.nl>
Subject: [PATCH 0/1] Rename cross_bootstrap back to mingw_progs to avoid confusion.
Date: Fri,  9 Jan 2026 20:04:14 +0100
Message-Id: <20260109190415.25785-1-dhr-incognito@xs4all.nl>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon,

As requested. Patches verified (build). (Last submission, I hope)

Regards Henri

J.H. vd Water (1):
  Rename cross_bootstrap back to mingw_progs to avoid confusion.

 winsup/configure.ac            | 10 +++++++---
 winsup/doc/faq-programming.xml |  4 ++--
 winsup/testsuite/Makefile.am   |  2 +-
 winsup/utils/Makefile.am       |  2 +-
 4 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.38.1

