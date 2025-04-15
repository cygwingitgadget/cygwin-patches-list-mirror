Return-Path: <SRS0=/CNS=XB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id B0824385841C
	for <cygwin-patches@cygwin.com>; Tue, 15 Apr 2025 08:17:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B0824385841C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B0824385841C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744705049; cv=none;
	b=v2KMMSqboYUlS1M2TK8DptixR7FzStwQGJGi3PtxReB+s4J+A0Q5e03MfC06r/lQP9cnbXl0ItBM7lygnuIzLIjwHWqeY3ZwUxal4RqFvsXOBzZhsUIwTNMmxMcLLig4NwwD1ruktDfm8cmAICcRKAN5114uPs0S6/3OLSZ6Izw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744705049; c=relaxed/simple;
	bh=aiumF7LqlQ8Bte92qRCoOpYP00KOp6Yz5w9iRJ69HpY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=V+uCQI1o7oyqXSlmy6CHl8mB9C7pbhk1v8UULDIOEW83Py6zFAFJYhHiF0SReyR7C0r2mWqSuuNDXklaQhFnPjqT3zUTiFDJeVp1coUNNxzep+l9w+tDXPNnOwKOay2hoJJNr/PRcmCidBXu3zoZVreeqt0rIegADO/wx5cUdQg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B0824385841C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=EZn9occY
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20250415081726776.BHOS.61558.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 15 Apr 2025 17:17:26 +0900
Date: Tue, 15 Apr 2025 17:17:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: kill(1): fix parsing of negative pid
Message-Id: <20250415171724.7f1ebf0945848879b418605b@nifty.ne.jp>
In-Reply-To: <98fb7b3b-362e-4ccc-b25d-ab68e000627c@t-online.de>
References: <98fb7b3b-362e-4ccc-b25d-ab68e000627c@t-online.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1744705046;
 bh=fgmmNHxGN9rFl+sxP6eyVKAFktEmSxwzhpuRuyp8Eoo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=EZn9occYLjazbzJ2c4E7lLTFM2T9So3oxJLbXjegJZMu0SMdPlgRclfJkfr479xctQOKchkm
 OQS1mGWSVkj1Z9P2D+CvPSG0c5VsPdALjAS4ArmYXHwkka9BL6M9tLyU5DlMK0C0hcITvYu/sj
 AWJbkGYlDM5XSIoornYmuLxSkZ0FGQplHeGJ/1obbpbJLRYkRUMgs8AuC08V9xnaIPOpYnMM1C
 LIFbWdeQ27UPo+/4mP233dyjkU1LnvNB/M4FwrY67gd++fl5cMRmU5HABkAXVuq7DEXyD/NsKo
 IxPAAJ+my4FdKF3B2bItV1u12aWpI3ASl+HkNRXmwT3H1wcQ==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 12 Apr 2025 16:03:53 +0200
Christian Franke wrote:
> Found during testing of:
> https://sourceware.org/pipermail/cygwin-patches/2025q2/013651.html
> 
> Examples using nonexistent PIDs:
> 
> $ /bin/kill -9 -8 # OK, same as /bin/kill -9 -- -8
> kill: -8: No such process
> 
> $ /bin/kill -SIGKILL -11 # bogus message
> kill: illegal pid: -SIGKILL
> kill: -11: No such process
> 
> $ /bin/kill -9 -11 # BAD, same as /bin/kill -9 -- -9 -11
> kill: -9: No such process
> kill: -11: No such process
> 
> The above works as expected with the bash builtin and with /usr/bin/kill 
> from Debian 12.

Thanks for the patch. LGTM.
Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
