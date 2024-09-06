Return-Path: <SRS0=8gjk=QE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id C3DC5384A49A
	for <cygwin-patches@cygwin.com>; Fri,  6 Sep 2024 09:01:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C3DC5384A49A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C3DC5384A49A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725613292; cv=none;
	b=FyEl0HB05ZeDUEjm5nE+dkwU9SSfARpwaLKJBpcD2leFU4JHs6WNdCXo44rXkPCyWDsQZ5LosTJWThLd6Lr86k3qJr1xKO+G3dnMi2teufdX/I+N+waqkbDDzXB/Qrws39Niz1mgrlN6WjHgJWT4E+w1LwLz84IS9o3mm3r7nNU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725613292; c=relaxed/simple;
	bh=s0SLLZJ5b8oA2yP2bcdUYQRxJNSeAmGjWE1OVX52XKE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=qWyj7iA+C5ex9064wmf5BQfnOPmmHjmCwbPwTjVbRKeiwBg0CZsa/3cZEDWnEP5Uz0qWRsWtxeoaWjMMkaRcewmZhgaREextKWPOi2GTiLoT6F/aO9XReif6lKRnDIg6A3Z7npk4uOKHxcF6r04gi9Bg4hziMZCckxchviH8pQk=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e06.mail.nifty.com with ESMTP
          id <20240906090128819.GBOH.102422.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 6 Sep 2024 18:01:28 +0900
Date: Fri, 6 Sep 2024 18:01:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
Message-Id: <20240906180127.15335289a2810d2334e52212@nifty.ne.jp>
In-Reply-To: <ZtnQY6Cxf_6Bbo6Q@calimero.vinschen.de>
References: <20240830141553.12128-1-takashi.yano@nifty.ne.jp>
	<ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
	<a2800cf1-6a69-75ee-5494-a14b1a10a1f1@gmx.de>
	<20240902225045.21e496d3af5b70b0a8c47c7d@nifty.ne.jp>
	<20240902233313.171fb48cc8243cd095d7280f@nifty.ne.jp>
	<20240905221841.002f3f6fa53baa468b0cd136@nifty.ne.jp>
	<ZtnQY6Cxf_6Bbo6Q@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725613288;
 bh=mJnsEss6Ql/A4QtEHPC0NuBiS2tU7I3rjd+is/FQscs=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=snAQ0NofDw8Y6yM/2OK0nUxVa1RmkucyBjSVC7p+VyZg2WhuN4OlmkVfbuHnwif7wIA//l11
 czVGbzQqJxJ3ppDyQUGBJRZqSHlEFFNxRmvOvyxcpOZtKZ5Bt/EchdPURg39NnfZwtylbvpcXl
 n7jBwe5U6gCmzMUJXV4JuHpFvcOmuaVNl7TYGntLulIneM+a+2qLjutz6IfozXHR4poIC0ovX5
 lKzwTbFhQc5ETh4d8ZklN3MvHR3C4wUDuZ91/irj3UiNR1iPuM+I2AhuQloEixluBGmldJxUMZ
 4t9lCv2ry1URfHYIaRuOX9FbF+45hzVYIUkWSTR5nIalaNdQ==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 5 Sep 2024 17:38:11 +0200
Corinna Vinschen wrote:
> I think you should push your original patch to the 3.5 branch for now,
> and we test the big change in the main branch first.

Sounds reasonable. I'll submit a v2 patch for 3.5 branch:
[PATCH v2] Cygwin: pipe: Restore blocking mode of read pipe on close()
and v2 patch for 3.6 branch:
[PATCH v2] Cygwin: pipe: Switch pipe mode to blocking mode by defaut

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
