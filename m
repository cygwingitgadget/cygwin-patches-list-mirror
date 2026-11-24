Return-Path: <SRS0=UvTC=JN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 66F0E4BA2E30
	for <cygwin-patches@cygwin.com>; Tue, 24 Nov 2026 03:30:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 66F0E4BA2E30
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 66F0E4BA2E30
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795491023; cv=none;
	b=jUnj0g3orHIyJ1UBd/23Hf17nspObljVVO8Nd9O77LrlvGLkZqXp/WF4DVTAIUR0kuqMRymqn1zmqcTPgrNNoF/jBi/3olvKRjmoXpfbRup7eySsCe1zKiAmNLRiOFYZGxaQgHb6gB3ogFIcnqd/bp/w5p7VkTADR7J9EQ+TE3s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795491023; c=relaxed/simple;
	bh=e1UhDNzaTO28nFG3+wH/8a92YsBqeXv8w7z0IdlhDHI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=uzcpUCWEvL0kWaSJoTY5IHAJYrA9tWfqm/WB5KYlSY8Oh9kamWLOtwhkrH0gK0WqkfLOuYi3AW0amw3SCQmz18FZOciptgGgvLPMSV2RhCA1VFR8QmT84keuUNM8gliGy3TgYNmWCDGbMPfkYr0re6FLj83lkkYHiA4VUH+sjJM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GkPc5g3h
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 66F0E4BA2E30
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GkPc5g3h
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20261124033018382.KWKC.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 24 Nov 2026 12:30:18 +0900
Date: Tue, 24 Nov 2026 12:30:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: pthread: Improve the performance of the
 destructor
Message-Id: <20261124123017.1998d6e169819a09af0b7265@nifty.ne.jp>
In-Reply-To: <20261124031736.1926-1-takashi.yano@nifty.ne.jp>
References: <20261124031736.1926-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__24_Nov_2026_12_30_17_+0900_EEIpWG4qr2VV=sza"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1795491018;
 bh=yp0BTRAK9ZaDNW8aEjppmzx0gRvM3jvFT1ZG1CP3e7g=;
 h=Date:From:To:Subject:In-Reply-To;
 b=GkPc5g3hnvacgMK/NEIpF3dTBAM38Nqy22ukC5CDQBpJZIJv/VzU3V6Jwt8sgMfnyN+KIipV
 0sg1kgQRNtdCF03/DimG0zUN0d91UoMLynFG6mWDOvNHZvYvvBQn73x9r1wBWFSEqBZ06okb8J
 y+hcQhuJGD7naDYPm99RIrJp+AuGbc9nsp+gnPiqQy/tinqbOKD6XKgVAS3I+4pAd645KjeRll
 mERBO/ENJYJ7oUeowHJ/rYKAiqltmYa09d5gqahPqzOfPUJZ7AdwmLMAlu4tq2oFJMHhp/+d3f
 oVN11ndegl94bg3wkfrYRNDgUsXd2pYOrkbbj49fnQqPc2uA==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Tue__24_Nov_2026_12_30_17_+0900_EEIpWG4qr2VV=sza
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Nov 2026 12:17:25 +0900
Takashi Yano wrote:
> Deleting pthread-related objects, such as pthread_mutex, becomes very
> slow when the number of the objects is large. Currently, these objects
> are managed in a singly linked list, where deletion requires O(n) time.
> As a result, deleting all objects takes O(n^2) time overall. Due to
> this issue, freeing a decoder in libde265 can sometime take several
> tens of seconds, because libde265 uses around 100,000 pthread_mutex
> objects depending on the video being decoded.
> 
> This patch changes the list to a doubly linked, reducing the overall
> deletion comlexity from O(n^2) to O(n).
> 
> Fixes: 5c83f260b87b ("(pthread_key_destructor_list::Remove): New function.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/local_includes/thread.h | 45 +++++++++++++++++----------
>  winsup/cygwin/thread.cc               | 14 ++++++---
>  2 files changed, 38 insertions(+), 21 deletions(-)

This issue can be reproduced by the simple reproducer attached.
In cygwin 3.6.12, you can see the time to destroy pthread_mutex
is increased by O(n^2).

cygwin 3.6.12:
Num	Init	Destroy
2000	0.00105	0.00449
4000	0.00390	0.01606
6000	0.00286	0.03653
8000	0.00457	0.06469
10000	0.00510	0.10370
12000	0.00660	0.15064
14000	0.00780	0.20992
16000	0.00853	0.27032
18000	0.00981	0.34256
20000	0.01010	0.42384
22000	0.01195	0.50946
24000	0.01249	0.60148
26000	0.01361	0.71346
28000	0.01463	0.82026
30000	0.01713	0.94794
32000	0.01761	1.07168
34000	0.01882	1.20417
36000	0.01972	1.35318
38000	0.02078	1.51118
40000	0.02204	1.67321
42000	0.02351	1.83842
44000	0.02423	2.01601
46000	0.02475	2.20498
48000	0.02819	2.39564
50000	0.02788	2.60500
52000	0.02856	2.82041
54000	0.02959	3.05356
56000	0.03312	3.31252
58000	0.03371	3.55132
60000	0.03319	3.75833
62000	0.03609	3.99067
64000	0.03506	4.26610

With this patch:
Num	Init	Destroy
2000	0.00110	0.00065
4000	0.00198	0.00128
6000	0.00276	0.00193
8000	0.00351	0.00261
10000	0.00448	0.00322
12000	0.00539	0.00404
14000	0.00631	0.00494
16000	0.00737	0.00616
18000	0.00809	0.00593
20000	0.00857	0.00644
22000	0.00920	0.00702
24000	0.01047	0.00804
26000	0.01120	0.00893
28000	0.01245	0.01019
30000	0.01411	0.01104
32000	0.01527	0.01181
34000	0.01613	0.01233
36000	0.01728	0.01490
38000	0.01850	0.01451
40000	0.01927	0.01696
42000	0.02219	0.01812
44000	0.02292	0.01912
46000	0.02395	0.01991
48000	0.02448	0.02061
50000	0.02510	0.02117
52000	0.02681	0.02202
54000	0.02790	0.02300
56000	0.03098	0.02407
58000	0.02983	0.02423
60000	0.03090	0.02510
62000	0.03135	0.02591
64000	0.03263	0.02667

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Tue__24_Nov_2026_12_30_17_+0900_EEIpWG4qr2VV=sza
Content-Type: text/x-csrc;
 name="pthread_mutex_bench.c"
Content-Disposition: attachment;
 filename="pthread_mutex_bench.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <pthread.h>

void bench(int n)
{
	pthread_mutex_t m[n];
	struct timespec tv0, tv1;
	double time_to_init, time_to_destroy;

	clock_gettime(CLOCK_MONOTONIC, &tv0);
	for (int i=0; i<n; i++) {
		pthread_mutex_init (&m[i], NULL);
	}
	clock_gettime(CLOCK_MONOTONIC, &tv1);
	time_to_init =
		(tv1.tv_sec - tv0.tv_sec) + (tv1.tv_nsec - tv0.tv_nsec)*1e-9;

	clock_gettime(CLOCK_MONOTONIC, &tv0);
	for (int i=0; i<n; i++) {
		pthread_mutex_destroy (&m[i]);
	}
	clock_gettime(CLOCK_MONOTONIC, &tv1);
	time_to_destroy =
		(tv1.tv_sec - tv0.tv_sec) + (tv1.tv_nsec - tv0.tv_nsec)*1e-9;
	printf("%d\t%.5f\t%.5f\n", n, time_to_init, time_to_destroy);
}

int main()
{
	printf("Num\tInit\tDestroy\n");
	for (int n = 2000; n <= 64000; n+=2000) {
		bench(n);
	}
	return 0;
}

--Multipart=_Tue__24_Nov_2026_12_30_17_+0900_EEIpWG4qr2VV=sza--
