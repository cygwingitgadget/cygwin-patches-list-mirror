Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id 4ACA33858003
 for <cygwin-patches@cygwin.com>; Wed, 24 Nov 2021 03:41:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4ACA33858003
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 1AO3esq1010750
 for <cygwin-patches@cygwin.com>; Wed, 24 Nov 2021 12:40:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 1AO3esq1010750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637725254;
 bh=WKGQtTGZlCATNl/MSsrRE7PYrXty4ss/PRtykXwssN4=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=F/aEsWLUtSm8a5E+Bdpu3x3Ns1L7mGLEXo0oRVelSvwSDuXNhiGdRr+Ld/YU7eS+f
 B79keJ8frG2Z8fzLXLJYGHresOi8aemoX1LYPRLEKgUo2Fnwo6LujCBknRg7oNPwJ0
 pvvE0Hy0CCJPcR2ee+pVe3R9N3RAuJaeMAvCZM1h7quEUtf0eX/8pwzC3QAqzSIA27
 uHm5DDzkXtN01MrsH7SpqflHQzUQGxsXgIRnOET3s8SsbME5cpEI8mZAJrlEx3ZL1l
 G60DIwnNokcqCy9+YWOdl4tQDE/JCaRdf4TpWjA6GR9/dVaHbhjnaFkGedgU0qpNOP
 HsNZ4Lkpj7PYA==
X-Nifty-SrcIP: [110.4.221.123]
Date: Wed, 24 Nov 2021 12:41:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fhandler_pipe::raw_read: fix handle leak
Message-Id: <20211124124105.78e3f0c823fd44ba1ef68ebb@nifty.ne.jp>
In-Reply-To: <782a2928-cd87-70b2-f559-781fd92d921a@cornell.edu>
References: <782a2928-cd87-70b2-f559-781fd92d921a@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 24 Nov 2021 03:41:23 -0000

On Tue, 23 Nov 2021 11:22:25 -0500
Ken Brown wrote:
> Patch attached.

LGTM.

Thanks for fixing this.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
