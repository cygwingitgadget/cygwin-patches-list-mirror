Return-Path: <cygwin-patches-return-9985-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7293 invoked by alias); 23 Jan 2020 13:05:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7194 invoked by uid 89); 23 Jan 2020 13:05:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1093
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 13:05:35 +0000
Received: from Express5800-S70 (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id 00ND5HLX029806	for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2020 22:05:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 00ND5HLX029806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579784717;	bh=UfrlpxZxsAuCS0ZkoXX3Ss+piYSPBcpfAhr5mF52lis=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=gsXL8IDTtAkJvXYmc0fFv1iH1mW019MTy9k37HGbbv5/ZlGQFI+/ELcpMjj6OAfFU	 ThRXvkYDlKtFi8ek05X9PLQ5IInghZPgTS6Zow9E+QDXmS8OXeHxWM8QmHGb9TYgoj	 C514Ne9CobEhmAzJeiRphLNN5F/6VwH3GvD56ZPxTWDWVzWYIBdwtz+gtGL/18Osu8	 ZAR3dk4rUNr5MD+h3vxbOn1ZJXElPO2+sbGVX/8o8/EKYVyw8m3udAHXMu7Qii0I1q	 QZw1iMN9mvj0Zur+Jv5rSJvxhwbubfEbLNKDT3EdZ/+tXsYmP64JuKGZjgujz03dHj	 pe9RCqhmMOKhA==
Date: Thu, 23 Jan 2020 13:05:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add missing console API hooks.
Message-Id: <20200123220531.d6dcf35ce81f4fa17b0788a6@nifty.ne.jp>
In-Reply-To: <20200123124813.GC263143@calimero.vinschen.de>
References: <20200123043312.529-1-takashi.yano@nifty.ne.jp>	<20200123124813.GC263143@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00091.txt

On Thu, 23 Jan 2020 13:48:13 +0100
Corinna Vinschen wrote:
> On Jan 23 13:33, Takashi Yano wrote:
> > - Following console APIs are additionally hooked for cygwin programs
> >   which directly call them.
> >   * FillConsoleOutputAttribute()
> >   * FillConsoleOutputCharacterA()
> >   * FillConsoleOutputCharacterW()
> >   * ScrollConsoleScreenBufferA()
> >   * ScrollConsoleScreenBufferW()
> 
> Which Cygwin programs are doing that?  They wouldn't work correctly in
> ptys anyway, isn't it?  Does it really make sense to make them happy
> rather than requesting to change them?

Just a possibility. There is no specific example.
With this patch, the code below can work even if it is compiled as
cygwin binary.

#include <stdio.h>
#include <windows.h>

int main() {
        COORD dest = {0, 0};
        printf("\033[H\033[J\n");
        DWORD n;
        FillConsoleOutputCharacter (GetStdHandle(STD_OUTPUT_HANDLE),
                        'A', 80, dest, &n);
        FillConsoleOutputAttribute (GetStdHandle(STD_OUTPUT_HANDLE),
                        FOREGROUND_RED, 80, dest, &n);
        return 0;
}

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
