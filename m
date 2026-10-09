Return-Path: <SRS0=WnwU=H7=post.cz=anakonda89@sourceware.org>
Received: from mxe-1-a9e.seznam.cz (mxe-1-a9e.seznam.cz [IPv6:2a02:598:128:8a00::1000:a9e])
	by sourceware.org (Postfix) with ESMTPS id D573E4BA2E0D
	for <cygwin-patches@cygwin.com>; Fri,  9 Oct 2026 13:28:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D573E4BA2E0D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=post.cz
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=post.cz
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D573E4BA2E0D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2a02:598:128:8a00::1000:a9e
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791552519; cv=none;
	b=ZHA3drnRxbyMnPsMi+GTRQ8X5/hfvnPDhHTx+1M5Y19vAF/mPQL+ygXzvyROHNp7nJV0+U1XWpRL1cIX1oXAOK6rdGEp33UKxG03LuksaMd55Agf2sH8YTo70CkiJt+KKzay6qP9jBCwwi44sZCJ8mN/mMLBvkzPSw13gc6/EfU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791552519; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:Mime-Version; b=ubj1W5fJ/CiVaYT/Ian231RkTQoP3qlofNhglyXs7BHdYQiJw+BIE7lScoBOnnzd2lY/Ccdz7TayYC/2HKwNF7Fn1KNfeVRXYJg5JhiXiJqWT8bzbB75hjJMs+AFztpx2AmdoyqDSsdwM/4pz2TsStz0ymsOTeBNOCLs5E9zjXI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=post.cz header.i=@post.cz header.a=rsa-sha256 header.s=szn1 header.b=Avod16pt
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D573E4BA2E0D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=post.cz header.i=@post.cz header.a=rsa-sha256 header.s=szn1 header.b=Avod16pt
Received: from email.seznam.cz
	by smtpc-mxe-677f8b68dd-76npj
	(smtpc-mxe-677f8b68dd-76npj [2a02:598:128:8a00::1000:a9e])
	id 2382ed957458528a266f2f22;
	Fri, 09 Oct 2026 15:28:36 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=post.cz; s=szn1;
	t=1791552516; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-Id:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=Avod16pt2na4ek/dQ/zbwnpYcGOpk/J16YTNRcLHAEa6hcKrPUrusZDXUKKAi/zPz
	 jxPnEq2Sps6VpoGnyc0j/nvYXvuzApbgW7vMH2HhYChEI1yT/sSD6I4anirZO4zue9
	 GCqwaaaMDPFG6ia49aep5Os6v2sIbqcj8pqZHYYei9L1Qh80j/k6FZDwIIQx2AHCuK
	 X/nrx/sdbr1KDn/HrlCAESV5EEAUQjsXgus+AKL3S+BuGCPFHVPLcRJ2rSwctQ3ApH
	 j+Hhpb7VxG7Nb545rFbl1rgb5FShFmvu2fmcNaMLDirp3gZVhGgqgs7xSfTq9kWAhR
	 N8dzpPu6oBHaA==
Received: from unknown ([85.193.42.84])
	by email.seznam.cz (szn-email-ebox-5.1.27) with HTTP;
	Fri, 09 Oct 2026 15:28:31 +0200 (CEST)
From: <anakonda89@post.cz>
To: <cygwin-patches@cygwin.com>
Subject: 
Date: Fri, 09 Oct 2026 15:28:31 +0200 (CEST)
Message-Id: <1rn.5xHrb.3z4P0LUHb30.1goEl}@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.2.19)
X-Mailer: szn-email-ebox-5.1.27
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,JMQ_SPF_NEUTRAL,KAM_BLANKSUBJECT,PYZOR_CHECK,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

