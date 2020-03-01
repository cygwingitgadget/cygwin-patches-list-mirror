Return-Path: <cygwin-patches-return-10149-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80203 invoked by alias); 1 Mar 2020 06:33:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80194 invoked by uid 89); 1 Mar 2020 06:33:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Attached, H*c:HHHH
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 01 Mar 2020 06:33:48 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id 0216XaOj023179	for <cygwin-patches@cygwin.com>; Sun, 1 Mar 2020 15:33:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 0216XaOj023179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1583044416;	bh=RIBhYsKyqw1Wh1NqOXx0lzL+E4mKDE++YIqPbBtVCG0=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=wjeWx+n8QC9G8gccs3amicth6H/GNn6UqxzUeLeyABvFQdjgQOhTYEb9kzn1lYSZ3	 Qxrjkfqkym66vUUiOS8OsqqXjQ3UMnsvi7gMd49ElvIRQA3E7X5SO7OVXTyuSZu+1m	 sHP+kjr7MkFiDCAxUHzGLpi33cVs20T8K9s7RvofqQHZogMEveAG5K1F+a/LtdoZMW	 Gg/IUCLTmdRiKsiIE0BCJwXo3EadK/UPxena7/L6EcrdDm6EBH46Llwr/dZNk7b5XK	 M4x388OQUafJeqy1BokRIEpTAhbH6wEjKBHNAQnhDhcPUP2FAfx9anls/ppHc7AqDv	 E9uVmVGJUxWRg==
Date: Sun, 01 Mar 2020 06:33:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Message-Id: <20200301153342.cbc54c2b14687b71679f993a@nifty.ne.jp>
In-Reply-To: <cc657f02-e3a4-1880-34a2-dcf04d6e902a@t-online.de>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp>	<20200226153302.584-2-takashi.yano@nifty.ne.jp>	<05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk>	<20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp>	<20200228133122.GG4045@calimero.vinschen.de>	<cc657f02-e3a4-1880-34a2-dcf04d6e902a@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart=_Sun__1_Mar_2020_15_33_42_+0900_11gDhYQUffOYwyu_"
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00255.txt

This is a multi-part message in MIME format.

--Multipart=_Sun__1_Mar_2020_15_33_42_+0900_11gDhYQUffOYwyu_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-length: 1051

On Fri, 28 Feb 2020 22:00:40 +0100
Hans-Bernhard Bröker wrote:
> // simple helper class to accumulate output in a buffer
> // and send that to the console on request:
> static class
> {
> private:
>    unsigned char buf[WPBUF_LEN];
>    int ixput;
> 
> public:
>    inline void put(unsigned char x)
>    {
>      if (ixput < WPBUF_LEN)
>        {
>          buf[ixput++] = x;
>        }
>    };
>    inline void empty() { ixput = 0; };
>    inline void sendOut(HANDLE &handle, DWORD *wn) {
>      WriteConsoleA (handle, buf, ixput, wn, 0);
>    };
> } wpbuf;

I agree your solution is more C++-like and smart.
However, from the view point of performance, just inline
static function is better. Attached code measures the
performance of access speed for wpbuf.
I compiled it by g++ 7.4.0 with -O2 option.

The result is as follows.

Total1: 2.315627 second
Total2: 1.588511 second
Total3: 1.571572 second

Class implementation is slow 40% than inline or macro.
So, IMHO, inline static function is the best.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Sun__1_Mar_2020_15_33_42_+0900_11gDhYQUffOYwyu_
Content-Type: text/x-c++src;
 name="wpbuf-bench.cc"
Content-Disposition: attachment;
 filename="wpbuf-bench.cc"
Content-Transfer-Encoding: 7bit
Content-length: 1474

#include <time.h>
#include <stdio.h>

#define WPBUF_LEN 256

class {
private:
	unsigned char buf[WPBUF_LEN];
	int ixput;

public:
	inline void put(unsigned char x)
	{
		if (ixput < WPBUF_LEN) buf[ixput++] = x;
	}
	inline void empty() { ixput = 0; };
} wpbuf;

unsigned char wpbuf2[WPBUF_LEN];
int ixput;
inline void wpbuf2_put(unsigned char x)
{
	if (ixput < WPBUF_LEN) wpbuf2[ixput++] = x;
}

#define wpbuf3_put(x) \
{ \
	if (ixput < WPBUF_LEN) wpbuf2[ixput++] = x; \
}

void bench1()
{
	for (int i=0; i<10000000; i++) {
		wpbuf.empty();
		for (int j=0; j<WPBUF_LEN; j++) {
			wpbuf.put('A');
		}
	}
}

void bench2()
{
	for (int i=0; i<10000000; i++) {
		ixput = 0;
		for (int j=0; j<WPBUF_LEN; j++) {
			wpbuf2_put('A');
		}
	}
}

void bench3()
{
	for (int i=0; i<10000000; i++) {
		ixput = 0;
		for (int j=0; j<WPBUF_LEN; j++) {
			wpbuf3_put('A');
		}
	}
}

int main()
{
	struct timespec tv0, tv1;
	
	clock_gettime(CLOCK_MONOTONIC, &tv0);
	bench1();
	clock_gettime(CLOCK_MONOTONIC, &tv1);
	printf("Total1: %f second\n",
		(tv1.tv_sec - tv0.tv_sec) + (tv1.tv_nsec - tv0.tv_nsec)*1e-9);

	clock_gettime(CLOCK_MONOTONIC, &tv0);
	bench2();
	clock_gettime(CLOCK_MONOTONIC, &tv1);
	printf("Total2: %f second\n",
		(tv1.tv_sec - tv0.tv_sec) + (tv1.tv_nsec - tv0.tv_nsec)*1e-9);

	clock_gettime(CLOCK_MONOTONIC, &tv0);
	bench3();
	clock_gettime(CLOCK_MONOTONIC, &tv1);
	printf("Total3: %f second\n",
		(tv1.tv_sec - tv0.tv_sec) + (tv1.tv_nsec - tv0.tv_nsec)*1e-9);
	return 0;
}

--Multipart=_Sun__1_Mar_2020_15_33_42_+0900_11gDhYQUffOYwyu_--
