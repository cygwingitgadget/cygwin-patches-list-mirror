Return-Path: <SRS0=MmMu=R3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.178])
	by sourceware.org (Postfix) with ESMTPS id EDF1D3858CDB
	for <cygwin-patches@cygwin.com>; Thu, 31 Oct 2024 16:25:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EDF1D3858CDB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EDF1D3858CDB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.178
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730391913; cv=none;
	b=kezg3ocKPWI298it5nxMsmafSj5rN0d+sVa6C+3uIXONR/d7GqrOomUinZNozJqdqbdU/tqeW15OKRrSVyqdyDilqVJ4LIOfIl0LpZbb1qAfj1koOTtS5ssd32OQYnHjJjltX4OrofwonsICkr2LgfHB3YqJWFyeomIK6R7+plo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730391913; c=relaxed/simple;
	bh=7K4AcAahelcGxWGIFeA2j6aIVcKYJS0HsuBR3xDt+/g=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=u3x0NF8UjqDv7mTht3OVCIxS6r5zBCAgxWVm5vGd2gMyHju5Qurl2gjrAaZ82UUCOuXusaM2DSpJIdm7nFcjnFbQObtionv6qW+SxoToL6UfNVvMN/TEs371p+2Gxn2IUVXeuBUCB0Qz98Qsfu1euTsGDSamQM71HuefhlJC2rM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20241031162507805.ARG.83552.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 1 Nov 2024 01:25:07 +0900
Date: Fri, 1 Nov 2024 01:25:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-Id: <20241101012506.e7279dbbace0480badd394b4@nifty.ne.jp>
In-Reply-To: <ZyNY36rwRtAVglBP@calimero.vinschen.de>
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
	<Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
	<20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
	<ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
	<20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
	<Zx9fk6yQ1etCVwek@calimero.vinschen.de>
	<20241028202301.7499a9f04335f362c72310db@nifty.ne.jp>
	<20241028202516.0dd4c86cb2efa9f7db8c856d@nifty.ne.jp>
	<Zx98ETE7E1DMGirF@calimero.vinschen.de>
	<20241031173642.34cf4980cea2276e7402c4d2@nifty.ne.jp>
	<ZyNY36rwRtAVglBP@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730391907;
 bh=E4e6WiKi3NtusQwK58o5UKR0W3zJqw0DWOGpSIiILi4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=LBn9rJncFRyNTUp6FiwsLyCxgZM5TUVRdImlphWWABrA95TJcvwiTdiAF+m0V2NIOO5boOxJ
 84doiSLbKhKFQEONKw+V9nRQwlwJTVGtyupt6ehrM6kX2uaxneoEQQb6DMjdEkKlJ8+QWe2Aot
 Rulo714pD4RSwnYDSV167ibwd96XIk4/v+dpT8n408n6ZPJpI436zn1VXhc8LFzep9OXU+WZeU
 7zXZSiZa68zRHSpsVzOQkXanlXahmUiq5AgmsYFYUobCT0tr+d6yJnstChVoa7ysaKF0pt//QW
 Zy1kP0C6l+S0qs7Kijgm5no+S+NFT71b9/nrzUuk7xE0JH1Q==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Thu, 31 Oct 2024 11:15:59 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Oct 31 17:36, Takashi Yano wrote:
> > Hi Corinna,
> > 
> > On Mon, 28 Oct 2024 12:57:05 +0100
> > Corinna Vinschen wrote:
> > > On Oct 28 20:25, Takashi Yano wrote:
> > > > Is the test case I used different from yours? Without the 2nd arg,
> > > > $ ./a.exe 40000
> > > > pipe capacity: 65536
> > > > write: writable 1, 40000 25536
> > > > write: writable 1, SIGALRM 24576 960
> > > > write: writable 0, SIGALRM -1 / Interrupted system call
> > > 
> > > This is the same testcase I pasted last week:
> > > 
> > >   $ ./x 40000
> > >   pipe capacity: 65536
> > >   write: writable 1, 40000 25536
> > >   write: writable 1, SIGALRM 24576 960
> > >   write: writable 0, SIGALRM 512 448
> > >   write: writable 0, SIGALRM 256 192
> > >   write: writable 0, SIGALRM 128 64
> > >   write: writable 0, SIGALRM 64 0
> > >   write: writable 0, SIGALRM -1 / Interrupted system call
> > > 
> > > So why does it not get into the last else case after calling
> > > pipe_data_available()?  Do you get a different return value
> > > from pipe_data_available()? If so, what and why?
> > 
> > I checked the behaviour in my environment.
> > __builtin_clzl(960) returns 54 in my environment.
> > So, result of
> > 	len1 = 1 << (31 - __builtin_clzl (avail));
> > is undefined. If I modify this to:
> > 	len1 = 1 << (63 - __builtin_clzl (avail));
> > I can get:
> > 
> > $ ./a.exe 40000 1
> > pipe capacity: 65536
> > write: writable 1, 40000 25536
> > write: writable 1, 24576 960
> > write: writable 0, 512 448
> > write: writable 0, 256 192
> > write: writable 0, 128 64
> > write: writable 0, 64 0
> > write: writable 0, -1 / Resource temporarily unavailable
> > 
> > with the commit 686e46ce7148 as well as with my v9 patch.
> > 
> > Could you please fix?
> 
> Yes, I will, but this is still puzzeling. While negative shift values
> are undefined in C, there's this:
> 
>   The Intel Pentium SAL instruction (generated by both gcc and Microsoft
>   C++ to evaluate left-shifts) only uses the bottom five bits of the
>   shift amount
> 
> The last 5 bits of 63 - 54 =   9 are 01001,
> the last 5 bits of 31 - 54 = -23 are 01001 as well.
> 
> I wrote a STC:
> 
> ------------------------------------
> #include <stdio.h>
> #include <stdlib.h>
> 
> int
> main (int argc, char **argv)
> {
>   ssize_t avail = atol (argv[1]);
> 
>   int x1 = 31 - __builtin_clzl (avail);
>   int x2 = 63 - __builtin_clzl (avail);
> 
>   printf ("%ld %d %u %u\n",
> 	  avail,
> 	  __builtin_clzl (avail),
> 	  1 << x1,
> 	  1 << x2);
>   return 0;
> }
> ------------------------------------
> 
> The workaround with x1 and x2 is necessary, otherwise gcc will
> fold the two expressions into a single sall instruction, even
> when building without optimization.
> 
> I can build the STC on Cygwin and with the Cygwin cross-compiler on
> Linux.  Both compilers generate identical assembler code.
> 
> In my environment the result is in both cases the same:
> 
>   $ ./clz-cyg 960
>   960 54 512 512
>   $ ./clz-lin 960
>   960 54 512 512
> 
> I get the same result, with and without -O2 (but then again, with -O2
> the sall instructions are folded into a single instruction again).
> 
> Do you get a different result?  Do you run this on an AMD CPU perhaps,
> and the AMDs implement the SAL instruction differently?

Please try this:

#include <stdio.h>
#include <stdlib.h>

#define PIPE_BUF 4096
int
main (int argc, char **argv)
{
  ssize_t avail = atol (argv[1]);
  unsigned long len1;

  if (avail < 1)
    return 0;
  if (avail == 1)
    len1 >>= 1;
  else if (avail >= PIPE_BUF)
    len1 = avail & ~(PIPE_BUF -1);
  else
    len1 = 1 << (31 - __builtin_clzl (avail));

  printf ("%ld %lu\n", avail, len1);
  return 0;
}

If the test case is compiled without optimization option,
$ ./a.exe 960
960 512

however, with -O2 option
$ ./a.exe 960
960 0

I am using gcc (GCC) 12.4.0 of cygwin gcc package.

It seems that the calcualtion of
    len1 = 1 << (31 - __builtin_clzl (avail));
is completely omitted.

In this case, avail == 1 or 1 < avail < 4096 for the last "else".
Therefore __builtin_clzl (avail) is always larger thatn 31.

I guess the compiler ommitted the undefined calculation.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
