Return-Path: <SRS0=3P/8=VK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id D26FE3858D20
	for <cygwin-patches@cygwin.com>; Wed, 19 Feb 2025 01:49:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D26FE3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D26FE3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739929740; cv=none;
	b=OZS3mmI/OXzxKuslEU4He81A3I0OvBssYOu3WY4wKQ7dLguCZD5KO6zf+1eMoZ4KA8wFU0lFN2jRUaYNNtbbJ1W8f27TphIyMLpHOwzErksS8SgIgnEVlKFGLmrrbPewHRJKLfwhN56QS2Ok3WVVtUH0sW8N8mQAnzdMl6rOtp4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739929740; c=relaxed/simple;
	bh=j+0OJtkuBZ7vlw+XNWuc70+draain9PLBnTlYQgfvXE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=gcVv61DgLXJyPE+yfLPjnkm4+qluoHxWNebBrSBqNve369GXYY6LXeGaRuZI315na7Hv8wxrMg/aa6lTQrgI0TQPe5QM0l1fQivoe5NTf27i4TMAuextWzgamLz5FgsFGNtzCL0PU7GU3AeUIwkkG+PdA5QyOI71FZpj5htlCnM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D26FE3858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=PfXcgCNF
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 7CB6745C30
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 20:49:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=cOKjVw652MpBEh5o28k4z785UcQ=; b=PfXcg
	CNFiVOCq0pUBYiOHXQ22bdpZmpvNzM5YCIPBrjfT0DZXYUYX3oVVjgLDgWn0sVPA
	SmGADWV6xTEep9rOhV615g3RDhAKCoPHuDwhuZpa8glLIouRAOaAGLQ3U0dwPln4
	zu72ZRfm2jXFy1jdii+RgqJj5G8A3J8HiSy+7o=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 7721C45BF6
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 20:49:00 -0500 (EST)
Date: Tue, 18 Feb 2025 17:48:59 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: skip floppy drives in cygdrive_getmntent.
In-Reply-To: <28f826f8-e78f-4329-f031-08c78eb5c40a@jdrake.com>
Message-ID: <32b78a88-78cb-8f54-205f-be6bb8b4a2e4@jdrake.com>
References: <df854454-c96e-8fe0-ead7-c70c566ec1d3@jdrake.com> <Z7TsohGAWwR9nOhX@calimero.vinschen.de> <e2c71487-2b97-e74d-0683-962f41decab6@jdrake.com> <Z7T4-niDlDcaaf9E@calimero.vinschen.de> <Z7T5qE7rp3WpZH4D@calimero.vinschen.de>
 <28f826f8-e78f-4329-f031-08c78eb5c40a@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 18 Feb 2025, Jeremy Drake via Cygwin-patches wrote:

> On Tue, 18 Feb 2025, Corinna Vinschen wrote:
>
> > Alternatively... calling the constructor with a parameter
> > `bool with_floppies'?
>
> I can buy that.  I'll wait for your review of the patch I just sent before
> sending a patch on top of that to implement this.

I lied... new patches incoming.
