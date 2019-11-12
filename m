Return-Path: <cygwin-patches-return-9834-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89293 invoked by alias); 12 Nov 2019 18:04:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89280 invoked by uid 89); 12 Nov 2019 18:04:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:619, H*f:sk:554c30d, H*i:sk:554c30d, H*MI:sk:554c30d
X-HELO: conssluserg-05.nifty.com
Received: from conssluserg-05.nifty.com (HELO conssluserg-05.nifty.com) (210.131.2.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 12 Nov 2019 18:03:59 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-05.nifty.com with ESMTP id xACI3rfl007596	for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2019 03:03:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xACI3rfl007596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573581833;	bh=8USU2NJ7k8ynqtZf6/fNW6GEqTMLfwGqGE9+Mabcgdw=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=AiCXBs7MgYPeCKe7WvCJDn8iPK9g4jiOvY/Ny7Mt+8KyapH/D7oayoxRkIVzfFFP+	 Z3hlrCqH1W/9LOh+ODlWYoCKs0pNuI1d3D4ul450XggdSqf3y78b5IpVTpm7cwYl1M	 +uPGaVu/Ojb0GrhPxa6TiXuFOuSoV2I0UVYDi4OEKC5IQyZB0YmiCqWFWBBZwrWqAs	 COPmK1B0+unlAhSqbF9yMIBwqU4Pwd7fso4Tu4k54WdbwBaThvTUvyEdHC18hRLa/x	 E3jm5PDIhVDKEkg+V4sGWcZtKdvENbSXBqwMF3n6bBlKexrCZESvYCTFY5v2X743uS	 fSkDKyaQTiL5g==
Date: Tue, 12 Nov 2019 18:04:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console, pty: Prevent error in legacy console mode.
Message-Id: <20191113030404.3fbcc49caa10de3686fbb856@nifty.ne.jp>
In-Reply-To: <554c30df-d61b-22fa-e758-2c4d43186180@cornell.edu>
References: <20191106162929.739-1-takashi.yano@nifty.ne.jp>	<20218a47-2077-878c-4d9c-e23f6b0d4add@cornell.edu>	<20191112115535.90777ac110e6f72c76a99753@nifty.ne.jp>	<554c30df-d61b-22fa-e758-2c4d43186180@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00105.txt.bz2

On Tue, 12 Nov 2019 13:46:04 +0000
Ken Brown wrote:
> On 11/11/2019 9:55 PM, Takashi Yano wrote:
> > Hi Ken,
> > 
> > On Mon, 11 Nov 2019 19:39:46 +0000
> > Ken Brown wrote:
> >> After this commit, the XWin Server Start Menu shortcut no longer works.  I think
> >> it's /usr/bin/xwin-xdg-menu.exe that fails, but I haven't checked this carefully.
> > 
> > Could you please check whether the attached patch solves the issue?
> 
> Yes, that fixes it.  Thanks.

Thanks for testing. I will submit the patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
