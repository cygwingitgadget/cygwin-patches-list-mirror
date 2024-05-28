Return-Path: <SRS0=tiif=M7=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id DAAD73845140
	for <cygwin-patches@cygwin.com>; Tue, 28 May 2024 17:49:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DAAD73845140
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DAAD73845140
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1716918586; cv=none;
	b=od1BzY3LZQtTkCkSuYnuIzH8aJIf38Rmzmhoh5YoX6inCik3+/BCL3O7GtaWL7R5ViZPZU6GxQXKS5/FMoUGabqYqRoNzoS32FWGTNoqN/oZhoVbuLAIQcv3frSXF+knidadgj51k9AJqdwzOO8b70YrQNA8jkbtrvpvPeZT7Ck=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1716918586; c=relaxed/simple;
	bh=twoPFVF9NImSSkqOWK3EHI91xw3rX3yIfU+srSX1cRM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=OGjut8Nk+N6MCBgbV9ch+T6xiCbuWX5GMd9reOkqxlvx/1fBQ7qls9gmIACWwX6tC1mEERIyAlzXBBjizvNRvxR6EcjS7a1b0lNXSvjY3d3lHzad0EY7l97Za90b/AINVO1uFFu/HNlKSFUV8R59n4L7zxZj8q9hNyajjrLkfyg=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id AEC2545B20
	for <cygwin-patches@cygwin.com>; Tue, 28 May 2024 13:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=23I6RWm2keO/M+1VsRLsecwYnTs=; b=rgHLN
	RoTBwzGI6udpRnw10SUxf36GGT6CP2UWnD1fUQRgpkd1w9AcphDz8TKQt0VoMnaP
	V91Lw9ZmqSvOmtd072nUYjV4MJ/Bp+Nxay9cRbsIKbZ6bpOAhDdlvStn+tE1M6ev
	e6bYi2Ofh1JyNiuZ3dG5j1ybEUhXGxAvGpzscE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id A897245B1E
	for <cygwin-patches@cygwin.com>; Tue, 28 May 2024 13:49:44 -0400 (EDT)
Date: Tue, 28 May 2024 10:49:44 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v1] Cygwin: disable high-entropy VA for ldh
In-Reply-To: <651f7e9a-8f59-7874-75ff-be82153e9dd8@jdrake.com>
Message-ID: <b342b03c-7fea-46e6-1813-dd37923d10cc@jdrake.com>
References: <651f7e9a-8f59-7874-75ff-be82153e9dd8@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 28 May 2024, Jeremy Drake via Cygwin-patches wrote:

> @@ -53,6 +53,7 @@ cygcheck_LDADD = -lz -lwininet -lshlwapi -lpsapi -lntdll

Oops, I accidentally generated this patch against msys2-3.5.3 branch,
rather than cygwin master like the last one.  The only difference is the
line numbers above, and it does apply cleanly to cygwin master, so I won't
send another version unless I'm requested to.
