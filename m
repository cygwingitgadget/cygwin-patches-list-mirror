Return-Path: <SRS0=9ylK=SD=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 1BB0B3858D21
	for <cygwin-patches@cygwin.com>; Fri,  8 Nov 2024 06:26:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1BB0B3858D21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1BB0B3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731047170; cv=none;
	b=qXL6o/6UWLlOURiCouwlHWWOFP+WgjBUBZ/JNhMeXE0ldU1qJgy+GOqLWGLzV04meUBbx33UHANSe3YAxE9uISeiOKbZ1sChjaLnID13+Oaj1HE8cecojI+vOHfbEmx0y+YNTf1zMHbmKm+jQvlmr8q6YxLvQUigB1h5zjkgxmY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731047170; c=relaxed/simple;
	bh=ir33ugWcTXYAB1C3eCcJXhsVd8ZzmzvJ+7xlpeVDUME=;
	h=Date:From:To:Subject:Message-ID:MIME-Version; b=LntVBPK/YMJNZDaYqIPU6/4fYmr36DaIXJyfAWyjNSlO66p1jTi6I7b2tTDgURxvzfdD3jPzLY1VtaBwiPuM6ke4QpFUMkcyqiyKOc9WEJiWoZtrgBJed9JSlRSDft4Pofavcx1GcHRVpYDRLbRiYj0GAWAf1H/JalZdKxTB58E=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost (mark@localhost)
	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id 4A86TFVf018249
	for <cygwin-patches@cygwin.com>; Thu, 7 Nov 2024 22:29:15 -0800 (PST)
	(envelope-from mark@maxrnd.com)
X-Authentication-Warning: m0.truegem.net: mark owned process doing -bs
Date: Thu, 7 Nov 2024 22:29:15 -0800 (PST)
From: Mark Geisert <mark@maxrnd.com>
X-X-Sender: mark@m0.truegem.net
To: cygwin-patches@cygwin.com
Subject: When submitting a bugfix patch *initially*
Message-ID: <Pine.BSF.4.63.2411072217390.16767@m0.truegem.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

..to the main branch, which release version file gets the bugfix 
description?  Assuming current branches...
version/3.6.0 because the patch is initially going to master, or
version/3.5.5 on the main branch because bugfixes get backported?

If version/3.6.0 initially, then when the bugfix gets backported does the 
bugfix description move from version/3.6.0 to version/3.5.5 or does it 
exist in both version files?
Thanks much,

..mark
