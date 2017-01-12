Return-Path: <cygwin-patches-return-8684-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51318 invoked by alias); 12 Jan 2017 00:38:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51030 invoked by uid 89); 12 Jan 2017 00:38:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.5 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,KAM_ASCII_DIVIDERS,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=ate, 1.50, kbyte, coincidence
X-HELO: mail-qt0-f169.google.com
Received: from mail-qt0-f169.google.com (HELO mail-qt0-f169.google.com) (209.85.216.169) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 12 Jan 2017 00:38:15 +0000
Received: by mail-qt0-f169.google.com with SMTP id v23so4364591qtb.0        for <cygwin-patches@cygwin.com>; Wed, 11 Jan 2017 16:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=xOz2eBlcL/8LaNo/eMhxWzcinXjDXDrfzL9GG9LLnMc=;        b=k8gocaBmiYuKuKSasQ0PgeenqdwdRBhs8shNq8fz1nT51gcCoBtbJUb4mMY5UFCRTS         NxUAEpenFfFV9d8v5OANJ5W3n4pxCwVqx0Kje4YBXFkixStTS5FvX+1VJF35xc7vfVnl         9hjMV32sOyB9XEfQnNNvHTANSIXx0XLEbzuVrAWSppxW5zsofE76AnTxfuqPYJey2RV+         FyVYmAn6dU6LqFFLciVvSwkGZcBZ/tz3hsgyd1gQhxduH4PSIW3qoVyZSgw9wJ0XvV2p         quRp6cL9f7lWGroVQXE0oGm16G8TMmP4En3TYRjwx1Yfq9lf2zPsS1ErVqDtIZ25ZL7U         lYXw==
X-Gm-Message-State: AIkVDXLCj4paiBVKUhcJvxC3DYjQA0teZ+/gGjClhE+pvLKPRV9ayqDCOm/07Qd1bpnfwLynelAn9aPEFIarVw==
X-Received: by 10.237.42.108 with SMTP id k41mr9988227qtf.81.1484181493239; Wed, 11 Jan 2017 16:38:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.165.38 with HTTP; Wed, 11 Jan 2017 16:38:12 -0800 (PST)
In-Reply-To: <CAO1c0ATh9aD-zbHcpna76EXr-Lavrbk5rnnnJC+bAtehe2xXHQ@mail.gmail.com>
References: <CAO1c0ATh9aD-zbHcpna76EXr-Lavrbk5rnnnJC+bAtehe2xXHQ@mail.gmail.com>
From: Daniel Havey <dhavey@gmail.com>
Date: Thu, 12 Jan 2017 00:38:00 -0000
Message-ID: <CAO1c0ARd7smeWLDpqHVyBSvcAZMSAKA4uDc3e2nKHpT73PiWBQ@mail.gmail.com>
Subject: Re: Limited Internet speeds caused by inappropriate socket buffering in function fdsock (winsup/net.cc)
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00025.txt.bz2

Hi Corinna,
I can see your email on the archive, but, I never received it in my
gmail account (not even in a spam folder).  I think the Internet ate
your message.

Yes Windows :).  I'm the Program Manager for Windows 10 transports and
IP.  Anything in layers 4 or 3.  We can help you with network stack in
the current release of Windows 10.  Downlevel is more difficult.  I'm
not sure about the answer to your question on the size of wmem.  I
don't think that there is a static value that will work in all cases
since Windows TCP will send 1 BDP worth of data per RTT.  If the BDP
is large then the static value could easily be too small and if the
BDP is small then the static value could easily be too large.  It will
take some digging to figure out what the best practice is.  I will do
some digging and let you know the results.

In the mean time I will apply your recommendations to my patch and repost it.

thanxs ;^)
...Daniel





On Mon, Jan 9, 2017 at 3:49 PM, Daniel Havey <dhavey@gmail.com> wrote:
> At Windows we love what you are doing with Cygwin.  However, we have
> been getting reports from our hardware vendors that iperf is slow on
> Windows.  Iperf is of course compiled against the cygwin1.dll and we
> believe we have traced the problem down to the function fdsock in
> net.cc.  SO_RCVBUF and SO_SNDBUF are being manually set.  The comments
> indicate that the idea was to increase the buffer size, but, this code
> must have been written long ago because Windows has used autotuning
> for a very long time now.  Please do not manually set SO_RCVBUF or
> SO_SNDBUF as this will limit your internet speed.
>
> I am providing a patch, an STC and my cygcheck -svr output.  Hope we
> can fix this.  Please let me know if I can help further.
>
> Simple Test Case:
> I have a script that pings 4 times and then iperfs for 10 seconds to
> debit.k-net.fr
>
>
> With patch
> $ bash buffer_test.sh 178.250.209.22
> usage: bash buffer_test.sh <iperf server name>
>
> Pinging 178.250.209.22 with 32 bytes of data:
> Reply from 178.250.209.22: bytes=32 time=167ms TTL=34
> Reply from 178.250.209.22: bytes=32 time=173ms TTL=34
> Reply from 178.250.209.22: bytes=32 time=173ms TTL=34
> Reply from 178.250.209.22: bytes=32 time=169ms TTL=34
>
> Ping statistics for 178.250.209.22:
>     Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
> Approximate round trip times in milli-seconds:
>     Minimum = 167ms, Maximum = 173ms, Average = 170ms
> ------------------------------------------------------------
> Client connecting to 178.250.209.22, TCP port 5001
> TCP window size: 64.0 KByte (default)
> ------------------------------------------------------------
> [  3] local 10.137.196.108 port 58512 connected with 178.250.209.22 port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0- 1.0 sec   768 KBytes  6.29 Mbits/sec
> [  3]  1.0- 2.0 sec  9.25 MBytes  77.6 Mbits/sec
> [  3]  2.0- 3.0 sec  18.0 MBytes   151 Mbits/sec
> [  3]  3.0- 4.0 sec  18.0 MBytes   151 Mbits/sec
> [  3]  4.0- 5.0 sec  18.0 MBytes   151 Mbits/sec
> [  3]  5.0- 6.0 sec  18.0 MBytes   151 Mbits/sec
> [  3]  6.0- 7.0 sec  18.0 MBytes   151 Mbits/sec
> [  3]  7.0- 8.0 sec  18.0 MBytes   151 Mbits/sec
> [  3]  8.0- 9.0 sec  18.0 MBytes   151 Mbits/sec
> [  3]  9.0-10.0 sec  18.0 MBytes   151 Mbits/sec
> [  3]  0.0-10.0 sec   154 MBytes   129 Mbits/sec
>
>
> Without patch:
> dahavey@DMH-DESKTOP ~
> $ bash buffer_test.sh 178.250.209.22
>
> Pinging 178.250.209.22 with 32 bytes of data:
> Reply from 178.250.209.22: bytes=32 time=168ms TTL=34
> Reply from 178.250.209.22: bytes=32 time=167ms TTL=34
> Reply from 178.250.209.22: bytes=32 time=170ms TTL=34
> Reply from 178.250.209.22: bytes=32 time=169ms TTL=34
>
> Ping statistics for 178.250.209.22:
>     Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
> Approximate round trip times in milli-seconds:
>     Minimum = 167ms, Maximum = 170ms, Average = 168ms
> ------------------------------------------------------------
> Client connecting to 178.250.209.22, TCP port 5001
> TCP window size:  208 KByte (default)
> ------------------------------------------------------------
> [  3] local 10.137.196.108 port 58443 connected with 178.250.209.22 port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0- 1.0 sec   512 KBytes  4.19 Mbits/sec
> [  3]  1.0- 2.0 sec  1.50 MBytes  12.6 Mbits/sec
> [  3]  2.0- 3.0 sec  1.50 MBytes  12.6 Mbits/sec
> [  3]  3.0- 4.0 sec  1.50 MBytes  12.6 Mbits/sec
> [  3]  4.0- 5.0 sec  1.50 MBytes  12.6 Mbits/sec
> [  3]  5.0- 6.0 sec  1.50 MBytes  12.6 Mbits/sec
> [  3]  6.0- 7.0 sec  1.50 MBytes  12.6 Mbits/sec
> [  3]  7.0- 8.0 sec  1.50 MBytes  12.6 Mbits/sec
> [  3]  8.0- 9.0 sec  1.50 MBytes  12.6 Mbits/sec
> [  3]  9.0-10.0 sec  1.50 MBytes  12.6 Mbits/sec
> [  3]  0.0-10.1 sec  14.1 MBytes  11.7 Mbits/sec
>
>
> The output shows that the RTT from my machine to the iperf server is
> similar in both cases (about 170ms) however with the patch the
> throughput averages 129 Mbps while without the patch the throughput
> only averages 11.7 Mbps.  If we calculate the maximum throughput using
> Bandwidth = Queue/RTT we get (212992 * 8)/0.170 = 10.0231 Mbps.  This
> is just about what iperf is showing us without the patch since the
> buffer size is set to 212992 I believe that the buffer size is
> limiting the throughput.  With the patch we have no buffer limitation
> (autotuning) and can develop the full potential bandwidth on the link.
>
> If you want to duplicate the STC you will have to find an iperf server
> (I found an extreme case) that has a large enough RTT distance from
> you and try a few times.  I get varying results depending on Internet
> traffic but without the patch never exceed the limit caused by the
> buffering.
>
> Here is the patch:
> --- net.cc_orig 2017-01-09 09:37:54.301210600 -0800
> +++ net.cc 2017-01-09 14:15:57.998895500 -0800
> @@ -517,7 +517,7 @@
>  bool
>  fdsock (cygheap_fdmanip& fd, const device *dev, SOCKET soc)
>  {
> -  int size;
> +//  int size;
>
>    fd = build_fh_dev (*dev);
>    if (!fd.isopen ())
> @@ -584,6 +584,7 @@
>    fd->set_flags (O_RDWR | O_BINARY);
>    debug_printf ("fd %d, name '%s', soc %p", (int) fd, dev->name (), soc);
>
> +
>    /* Raise default buffer sizes (instead of WinSock default 8K).
>
>       64K appear to have the best size/performance ratio for a default
> @@ -608,6 +609,8 @@
>       of 1k, but since 64k breaks WSADuplicateSocket we use 63Kb.
>
>       (*) Maximum normal TCP window size.  Coincidence?  */
> +
> +
>  #ifdef __x86_64__
>    ((fhandler_socket *) fd)->rmem () = 212992;
>    ((fhandler_socket *) fd)->wmem () = 212992;
> @@ -615,6 +618,14 @@
>    ((fhandler_socket *) fd)->rmem () = 64512;
>    ((fhandler_socket *) fd)->wmem () = 64512;
>  #endif
> +
> +/*   Please don't do this.  Windows doesn't have a default buffer of
> 8K it uses autotuning.
> +     The thing about network buffers is they have to be chosen
> dynamically.  Both Windows
> +     and Linux do this.  However, this code sets the SO_SNDBUF and
> SO_RCVBUF size statically.
> +     This will limit Internet speeds and cause bufferbloat.  Let the
> OS dynamically choose
> +     the SO_SNDBUF and SO_RCVBUF sizes.
> +
> +
>    if (::setsockopt (soc, SOL_SOCKET, SO_RCVBUF,
>      (char *) &((fhandler_socket *) fd)->rmem (), sizeof (int)))
>      {
> @@ -632,7 +643,9 @@
>   (char *) &((fhandler_socket *) fd)->wmem (),
>   (size = sizeof (int), &size)))
>   system_printf ("getsockopt(SO_SNDBUF) failed, %u", WSAGetLastError ());
> -    }
> +    } */
> +
> +
>
>    /* A unique ID is necessary to recognize fhandler entries which are
>       duplicated by dup(2) or fork(2).  This is used in BSD flock calls
