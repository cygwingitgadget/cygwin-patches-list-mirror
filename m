Return-Path: <cygwin-patches-return-10167-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1447 invoked by alias); 3 Mar 2020 00:35:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1438 invoked by uid 89); 3 Mar 2020 00:35:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 03 Mar 2020 00:35:53 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id 0230ZXah006768	for <cygwin-patches@cygwin.com>; Tue, 3 Mar 2020 09:35:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0230ZXah006768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1583195733;	bh=006OHr2gbhMlhOYDQKz4mO92qA5U071bwG5QpMTZSpY=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=KKDRA7vRsykhJA/U42NN9s/Xw4r3bpVdca9/KFQz4qdnmUa/92vBVCEQY7KYH+afc	 pI6LHvBPYODRewVlSTt4C1vPnZEJyVK7YMpKAhwjDldBFQ8VAoAkONE+vxJg6CBi7S	 Q4u93P+UEabOhmwdysZtEzZmBslIPLXUdX+akztXAcOoSAFvEq5gsJwYW/m0+ChCvy	 zIqYIZm1b7ppqHaMcNb4ZcRHGLBScilYt69OTUBWdG9BM9049OXQKFpqmx0EuMoxd5	 3cyn1dg0cfEu9UTpHHsEggaV/Gg245ed1HJj24cGozqrEUph5H2tbtGf8T3a2rR3b7	 4T5vz4LEE6Vmg==
Date: Tue, 03 Mar 2020 00:35:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Collect handling of wpixput and wpbuf into a helper class.
Message-Id: <20200303093535.f27696d9250af844c0eaec52@nifty.ne.jp>
In-Reply-To: <877f246b-08c2-6ccd-faac-6c90661212e5@t-online.de>
References: <877f246b-08c2-6ccd-faac-6c90661212e5@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00273.txt

Hi Hans,

Thanks for the patch.

On Tue, 3 Mar 2020 00:07:25 +0100
Hans-Bernhard Bröker wrote:
> +  inline void sendOut(HANDLE &handle, DWORD *wn) { WriteConsoleA 
> (handle, buf, ixput, wn, 0); };

The second argument DWORD *wn of sendOut() is not used
outside sendOut(), so it can be covered up like:

inline void sendOut (HANDLE &handle)
{
  DWORD wn;
  WriteConsoleA (handle, buf, ixput, &wn, 0);
}

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
