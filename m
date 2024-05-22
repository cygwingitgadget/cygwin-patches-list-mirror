Return-Path: <SRS0=moaP=MZ=scientia.org=calestyo@sourceware.org>
Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	by sourceware.org (Postfix) with ESMTPS id 85C093858D3C
	for <cygwin-patches@cygwin.com>; Wed, 22 May 2024 00:36:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 85C093858D3C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=scientia.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 85C093858D3C
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=23.83.218.254
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1716338199; cv=pass;
	b=nzwhHBLqev+49ErpR8eCK6IKXHZ9JBhIz3/7+qg1iTnS6tV82z03z89Qu316yVt4tDoQuBHE+0CrrBJW7XwEcAEFfiZ66GVopEi+OrC+i+eaIka/so4Go2uJhR3zeVlM9pOrGUBePenWZZuC9Zqhl91fJX9wpgRwf0LlJEVRQ1Q=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1716338199; c=relaxed/simple;
	bh=M0MwzdegnXejaKty9AI/FGuJBgU6nZOLmutNfkxouvY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Lh4P+ATKugRc1e80o+FSoq9NmhHQlZAOeXItcCNuJb/GEieukFtQY8SreQlQYY456mDEoydBrfQD8Tm8ylHJqK83BnNk1eFvSSG3zQ/fR4EOvmaPe0eVFfJWT/1xn2fXJl34cQxMfvn9pUv8mcasABOZwsajwMdsmK6E1T2UG6A=
ARC-Authentication-Results: i=2; server2.sourceware.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 88C772C1EAE
	for <cygwin-patches@cygwin.com>; Wed, 22 May 2024 00:36:36 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id E1AC72C2B84
	for <cygwin-patches@cygwin.com>; Wed, 22 May 2024 00:36:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1716338196; a=rsa-sha256;
	cv=none;
	b=ELgwyaVv/hAbZI/1pond5+lCM8zO68wZXvbkhoH8jIAUY/IlGTZ4aMxSXHK++vldBk475n
	ProUUx23eD0rnQSHy8RC4j3GKxxZT4Xp9WZ3iqzVBB2kWabsrYyO22CgxKFu29gzcDUEAD
	cTYF4mb28Ir5P9u+Sa/zIWcq4mrGa9LPsGfSJ2iMVXiY3Fg8Vz3aKyKx3UKz7WR54zZh24
	onqX0ti93dmZsKj/vtvwfjeAJvfsuL5wzpyX8GapixppsDCU9dEpY9t5++0sWhpql9bfHC
	L8+bx3pTJnTdZgg4wecvbwgbMdsLgO7P3W9utFEIEO1byQTZEHevq9ndY1HIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1716338196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M0MwzdegnXejaKty9AI/FGuJBgU6nZOLmutNfkxouvY=;
	b=lZQf3hW5jbn48zgUizQHAsnFKQhE4WlDZeZSHPMTWXlqkWf2Hb504pUGNANojOXIgry891
	3MqQXn4LulhIxdwkaN6eG0FgGmTjFG/NAw6ey40O+5udH5QQqcU0jWkiqTt4w+UcqXYk8t
	LR+bgW6yr5uam7E1kCIPJ3HVGE2p0wgzxA9axHzahSoXPaWYFkybUei8PJNZKcefWaLwqm
	7Ze8QUqYG4rLFD8MdHIXoe7zATmo7mdfFKWbo9dSNtweUaQPgK+MjojglOzNewHSjA4ivY
	eZefeALudjTVU1TSFzd4mMlb61/7afO3yerFgK991LSP2XZPTJWdrCjzHNN2Jw==
ARC-Authentication-Results: i=1;
	rspamd-68bbddc7f5-s49w5;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-White-Language: 5aec1f8846aba24c_1716338196445_241276196
X-MC-Loop-Signature: 1716338196445:2079739951
X-MC-Ingress-Time: 1716338196445
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.38.57 (trex/6.9.2);
	Wed, 22 May 2024 00:36:36 +0000
Received: from p5090f664.dip0.t-ipconnect.de ([80.144.246.100]:55650 helo=heisenberg.scientia.org)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1s9Zy4-00000008Ph6-2OOb
	for cygwin-patches@cygwin.com;
	Wed, 22 May 2024 00:36:34 +0000
Received: by heisenberg.scientia.org (Postfix, from userid 1000)
	id F029F20C7596; Wed, 22 May 2024 02:36:29 +0200 (CEST)
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/1] make `cygcheck --find-package` output parseable
Date: Wed, 22 May 2024 02:35:37 +0200
Message-ID: <20240522003627.486983-1-calestyo@scientia.org>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hey.

Just a simple patch that should make the output of
`cygcheck --find-package` parseable.

It would however be a backwards incompatible change, OTOH it cannot
really see how much can be done with the current output format properly
in a machine-readable way – and humans probably won’t care about the
changed separator.

Cheers,
Chris.


