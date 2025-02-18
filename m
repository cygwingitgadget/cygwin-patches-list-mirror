Return-Path: <SRS0=Z4hW=VJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 1A4143858D20
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 21:10:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1A4143858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1A4143858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739913028; cv=none;
	b=KoJ9VD4I28aOa+By3YI9ipSQMxhJvM0VHUOn9J6cMu5hYlkf1MloP7ZErI2tbmHU28f3RllM4NfLBMOO8SgGwsUeps8pg9XkhtuPDUXvr6rYrx43t4cTEdAXb9JAd3U1R4Px2rlqqRVdhIgVNSE+7BC5VZHjhQ5SPp4oc4XK/+E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739913028; c=relaxed/simple;
	bh=mn9omRHJ6rS1dUR2V+5TLEbEOeU54OGYoNwAop1KUoc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=L7Ogdjxa4s6a4t8KcX16ertpi20/2WokSiosxmI5asHDX/P76hhy/Sv44ijoymWLOnkYgbcWn9Xf1kPMProSCbcqJAV7yu5DzmPbijcI0dHFqvp9az4ifGmebGfTEDjEPWLtkoAHdX70IpvVs2VLnGvOyFaXC92UrwTHTg+/GAM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1A4143858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=j+P0XD67
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id D1F5245C30
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 16:10:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=HzuPpnHUcPdIEy3ymF+14E4j0UI=; b=j+P0X
	D67dCLAHLJplwSCyyukD2iJi4rTqexXymW8A1IswpMJtCsd53L+WX1/FjKB4a44Q
	26/+XoVHgpw25JlCtJ+WGVBcCsegnW77u4MjLHDGmtbEt9I/sk+cEp36VVZg/RAL
	mbr5aZ8fwv3j+IcMNtfi8eAoKYLSY5fxshTZN0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id CBB4E45BF6
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 16:10:27 -0500 (EST)
Date: Tue, 18 Feb 2025 13:10:27 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: skip floppy drives in cygdrive_getmntent.
In-Reply-To: <Z7TsohGAWwR9nOhX@calimero.vinschen.de>
Message-ID: <e2c71487-2b97-e74d-0683-962f41decab6@jdrake.com>
References: <df854454-c96e-8fe0-ead7-c70c566ec1d3@jdrake.com> <Z7TsohGAWwR9nOhX@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 18 Feb 2025, Corinna Vinschen wrote:

> Actually, given that we can't do without GetLogicalDrives anyway,
> this could be folded into the mapping list creation within
> dos_drive_mappings::dos_drive_mappings.

I don't agree.  That would affect the other user(s) of dos_drive_mappings.
What if somebody had a mapped file on a file on a floppy drive and looked
in /proc/<PID>/maps?
