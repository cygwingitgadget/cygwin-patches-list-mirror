Return-Path: <SRS0=Qr2z=ID=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id A42A74BA23DA
	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 16:48:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A42A74BA23DA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A42A74BA23DA
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791910098; cv=none;
	b=mqtgXt+BNvsDy/3HxDdbH9FQgacsYQLZcSAZ4xJNDU82QZ+ofE6hBk/HmF0HQPmmYPeUHiot6WMbpQouU42jxcPQIfj6ry9GWZUEe34rfHoptqVDGMyVbzc6VDkK9xaHl0dRhAU+Ky5ub5exiqF7oPbpI8aS9vXYOFlVjq8V7D4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791910098; c=relaxed/simple;
	bh=36qSpWqRwgriipJ9EMRseEZMBwE36PZlq1CP/FQA+kc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:DKIM-Signature; b=M1vviaok8pfOVlRVD6oemo4V2qqRz7+UYbTlaCs1O4/RutC9XufKL65zHKnZcM9LTAs0UQAqgQt6FuNtQJmsWrIHNyGnEn/7NvimGSD9PnlJnIIAN6ve++fxFtfddVezSeT22eCsOb5GdOgPcNXC8u5BQVjLogGgpdzMrWa16EU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=HjJy7Gg2
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A42A74BA23DA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=HjJy7Gg2
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 677CCC0CF1
	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 16:48:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf20.hostedemail.com (Postfix) with ESMTPA id E3EE22002B
	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 16:48:05 +0000 (UTC)
Message-ID: <c9f12c06-5609-4034-8fd7-5fc9ec433197@SystematicSW.ab.ca>
Date: Tue, 13 Oct 2026 10:48:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: IC*Cygwin* tzset: ICU 79/CLDR 49 Western Canadian time zones changes
 different from TZ DB
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: E3EE22002B
X-Stat-Signature: uo9az9xrge6q3afapstihk8zh5wnsw3i
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+rkv1vXbZQNZb0qQNdvUQIlwG3G41pV+s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:reply-to:to:from:subject:content-type:content-transfer-encoding; s=he; bh=VGnGH0wC+wrVpZ03dQtemwqD+S4oSKclYazRdyB22A8=; b=HjJy7Gg20VERIxjWZ9bjrMUoXRyIR4IBoFhaRQvpG96vjnxnZXZBBxQVoUlvvPBJBpAC8qOa04f9ly4wq88QQvHD6wiiniOKkyak8gyJ3MFNnRf4qOdFUJ8k5XltURmKFlnLlS/EKqBg1Vhfs5JiYEugC9OSMRMOx80U0rCzuu1ZEBJCmqB6toXHoFtumILhj6EttCXli9/GYVcVwlndJPBA20t79AGJxG8VLs9uW27hLx3tqiIUeRsgenMp5B6JQFZBUEKi+lREM+8ClVg+v0FF+LugR/BTaToGeDxpbjZDnhnxmaKq2FleU2Z4SZZQTt2YnzO1TLeVps55tKS58w==
X-HE-Tag: 1791910085-339538
X-HE-Meta: U2FsdGVkX1947FxL2PuAp9AYVSI1l6LYyewmZ5+t/uYRXh1QgEgJ83yj47BBKLtiq9Rb2n+W+aElFqHagnKqLpWwm6m0S/BKuC4cwwozpfGRNfcRXQOPrekgAOAmvm0Ayn2A5RQuXOgyVago68SjSYt7NlJrdn38Zlydqf94q2vjuTarkkWSpemikM3B5h9ETQvSMoqTM6FcDm9Yp9l9aQSmhBKpbbUdCPsnsFmpmJWJpj+Msa+OCMN9/moe16Pzthu2WIKdePOK4uSpnuYUN68a119B+XZ39Np/hR6t7+6nYPEN08+6GeD4YUcN8CEs6UDooikvxx0YskonURbZ4NoJXp6ionM3BQtMsVEgK0BTkHUlsvneq5obgKgcONjeqT1Bl+tEHto=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi folks,

The latest word about the ICU 79/CLDR 49 support of Western Canadian time zones 
changes is that they will be maintaining the DST fiction year round from 
release, starting 2026-11-01: using PDT, MDT, CDT for BC, AB, MB, year round, 
rather than TZ DB's use of normal STD times using MST, CST, EST year round; 
presumably YT stays on MST and SK on CST even under CLDR, so they will appear to 
be on different time zones, and NT(/NWT) will follow AB, although NU regions 
still appear undecided but likely to follow other adjacent regions.

Do some tweaks need made to accommodate the changes coming in a few weeks, just 
before the TZ and TZ DB change already updated?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

