Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by sourceware.org (Postfix) with ESMTPS id 5465A385783F;
 Wed, 26 Aug 2020 14:30:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5465A385783F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Johannes.Schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598452206;
 bh=cdL774smirPdNqC/mKus5ligsNNstUKReylvWhecpoM=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=YUrOmpb+E29U1DmzRQMrbVDFW0wlGtlpcRoWmnMQHHRoLIew6CMtBmVSNSUUwy5VI
 /MM3uARuSBNEcxEgL2cq0KgWXDYdh1MNSMOtyds3UkAKn8STh8giRkc4U5FM4s0EQs
 ivfvzIUPH1ShnowIR9tT0WMsR5JAWzBAHnOgLKLc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.212.143]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRfl-1kml5r2PDF-00bqt6; Wed, 26
 Aug 2020 16:30:06 +0200
Date: Wed, 26 Aug 2020 09:30:13 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
cc: Dahan Gong <gdh1995@qq.com>, Corinna Vinschen <corinna-cygwin@cygwin.com>
Subject: Re: [Patch] Fix incorrect code page when setting console title on
 Win10
In-Reply-To: <20200826090625.GN3272@calimero.vinschen.de>
Message-ID: <nycvar.QRO.7.76.6.2008260919460.56@tvgsbejvaqbjf.bet>
References: <tencent_DEAF96B572731C3B3E524F22CCAC86D3AD07@qq.com>
 <20200826090625.GN3272@calimero.vinschen.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-ID: <nycvar.QRO.7.76.6.2008260930080.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:lUZofzOvveT8x60EaczIECHaazLDj0ADTUt5MRQaeWQJ5bjQVwq
 MxCqU3wgwCJAtjVeEjV3YHOrmyfevTU69+aRSxA3EVdR7KkSk82QLDXzkr8mprhM7IN/vr7
 gYb6cr+2qoclOSPyYY5uY7qg4IL66xOPBTYJNHEeDeQNFCg54KTx1/9xX/jX5n5t3XnPl/R
 +fPfM+Ddv+HqehJtgkwsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8PCaKvWI1js=:YgTc9yax7jAesf5oUcXtUQ
 M2/FepdIxBCiBcJ691VtxkHBXeTY85iZ3n/A7fUvGbulkWzsG8rfCg/TL/WvXdaMv1rXr9CsA
 Lec1ZlIi0lZW8ENUNw3vOwcd+JPepH6NVMNv3Kd5oq6mySqM0rYigRBl6z135c0CLnQea153+
 iQMJPoITom3LwLCCW8F4IzpFA9uTw+tNq90wlSXJOQDdMPZdcEPFdGaWt/B7A6W9/uY6Qmcox
 fQd/RDMs6dWpygxYL7KpH8KS/OCqs1IjSXPgf/uSA/mIm9n4+NERnk8Z3NdTvtDO/mMxHzf0l
 dhs+cEKxho+O3nMrB+ZVnIyZSfpwnMstr2vFHMtYjwQquUmyx5YOTKNAKIn939bHzykI+wiq6
 4zErmn4StbJJorWP+tR66k+BQeQ7wvbjBRteYtJ8ju0nrz/B7eW918qohTYtRZFQ3MdrHiRRO
 Bj33FEhd6VEe64ma0xvZp5M6r3waq0LTQqEV4KOqGQFahdmTTk5K5uPF2/+ejqB5lfGarzbwA
 3p7cKEkbwaoEx5Ufm0u0jClViX755sBQmls9DZW45LZLiLt19JpWC15OEwZcQl75t+W5qAybQ
 m1vQ0nrFuGkBZiosTPFbziy2dUnO/4MPwyoMiCKPIeOH2GRQ0HljUt4UoHbwRqqX1MIkpQms7
 hEH/Sp3E7NzYYLDuQJhRag5wgJn7LELV3Q4q4gQMj+G3gqO7vQrQypS1vkSs8rAqpGVfpxQkS
 Du2YxTWImrnOKJdkGg1ANtYeVQFgGv4xnscRf2gg1BtrmnUJqOZ6aC+RnxPRMWAol22oMqoQg
 NJQirbM9Sev2lJ9PseRtLmGlRH9tObRxO+n+ouUqi/8UA5AKEpVSgdAhFsaQa/l1SpxgzKhAv
 7FDnQ2kVMbSrBIUJcqvKmUS/PHPPUrdnVERx+AS/UKrU82xvT6Djjcd/vudFZPmxK7e0OUYUb
 iUTDKacjEXBB14lFU1tW3F4I2W6Tkfevnvidr8tC7zVOU0Mpr5GYEz47qRQepProhkHkdjSp3
 Spmpmp7RYA6KIZKVJLEhqbQf2Y0dJzz1Rt+6xx2zSl/jGngd7DDg4oJrerqRu1CZd1Fv9N9fv
 FTh/JGYM7gLgIkM9WQiRfjIxf+bM2JKhrhivIawxE1CSyewQHlf5m7fBsfTkLlFozrN9xguYh
 rECmNxtWkzqmYSLNy3omEf/4NZhZfh/soSY36SHmdjeHeLtAfFkFWcRKhF/BFAKhO+G8XAoCi
 O8+YwWZuEz7YJQ6ZahithinNN5mfB1+iFEEOFJQ==
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00, BODY_8BITS,
 DATE_IN_PAST_06_12, DKIM_SIGNED, DKIM_VALID, FREEMAIL_FROM, KAM_NUMSUBJECT,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
X-List-Received-Date: Wed, 26 Aug 2020 14:30:14 -0000

Hi Corinna,

On Wed, 26 Aug 2020, Corinna Vinschen wrote:

> On Aug 26 16:43, =E5=AE=AB=E5=A4=A7=E6=B1=89 via Cygwin-patches wrote:
> > When Cygwin sets console titles on Win10 (has_con_24bit_colors &amp;&a=
mp; !con_is_legacy),
> > `WriteConsoleA` is used and causes an error if:
> > 1. the environment variable of `LANG` is `***.UTF-8`
> > 2. and the code page of console.exe is not UTF-8
> > &nbsp; 1. e.g. on my Computer, it's GB2312, for Chinese text
> >
> >
> > I've done some tests on msys2 and details are on https://github.com/gi=
t-for-windows/git/issues/2738,
> > and I filed a PR of https://github.com/git-for-windows/msys2-runtime/p=
ull/25.

Just in case you want to have a look at it, you can download the patch via
https://github.com/git-for-windows/msys2-runtime/commit/334f52a53a2e6b7f56=
0b0e8810b9f672ebb3ad24.patch

FWIW my original reviewer comment was: "why not fix wpbuf.send() in the
first place?" but after having a good look around, that method seemed to
be called from so many places that I "got cold feet" of that approach.

For one, I saw at least one caller that wants to send Escape sequences,
and I have no idea whether it is a good idea to do that in the `*W()`
version of the `WriteConsole()` function.

So the real question from my side is: how to address properly the many
uses of `WriteConsoleA()` (which breaks all kinds of encodings in many
situations because Windows' idea of the current code page and Cygwin's
idea of the current locale are pretty often at odds).

The patch discussed here circumvents one of those call sites.

However, even though there have not been any callers of `WriteConsoleA()`
in Cygwin v3.0.7 (but four callers of `WriteConsoleW()` which I suspect
were converted to `*A()` calls in v3.1.0 by the Pseudo Console patches),
there are now a whopping 15 callers of that `*A()` function in Cygwin
v3.1.7. See here:

	$ git grep WriteConsoleA
	winsup/cygwin/fhandler_console.cc:    WriteConsoleA (handle, buf, ixput, =
wn, 0);
	winsup/cygwin/fhandler_console.cc:          WriteConsoleA (get_output_han=
dle (), "\033[?1h", 5, NULL, 0);
	winsup/cygwin/fhandler_console.cc:            WriteConsoleA (get_output_h=
andle (), &last_char, 1, 0, 0);
	winsup/cygwin/fhandler_console.cc:                WriteConsoleA (get_outp=
ut_handle (),
	winsup/cygwin/fhandler_console.cc:            WriteConsoleA (get_output_h=
andle (), buf, strlen (buf), 0, 0);
	winsup/cygwin/fhandler_console.cc:            WriteConsoleA (get_output_h=
andle (), buf, strlen (buf), 0, 0);
	winsup/cygwin/fhandler_console.cc:            WriteConsoleA (get_output_h=
andle (), buf, strlen (buf), 0, 0);
	winsup/cygwin/fhandler_console.cc:            WriteConsoleA (get_output_h=
andle (), buf, strlen (buf), 0, 0);
	winsup/cygwin/fhandler_console.cc:            WriteConsoleA (get_output_h=
andle (), buf, strlen (buf), 0, 0);
	winsup/cygwin/fhandler_console.cc:            WriteConsoleA (get_output_h=
andle (), buf, strlen (buf), 0, 0);
	winsup/cygwin/fhandler_console.cc:                    WriteConsoleA (get_=
output_handle (),
	winsup/cygwin/fhandler_tty.cc:DEF_HOOK (WriteConsoleA);
	winsup/cygwin/fhandler_tty.cc:WriteConsoleA_Hooked
	winsup/cygwin/fhandler_tty.cc:  return WriteConsoleA_Orig (h, p, l, n, o)=
;
	winsup/cygwin/fhandler_tty.cc:      DO_HOOK (NULL, WriteConsoleA);

That cannot be intentional, can it? We should always thrive to use the
`*W()` functions so that we can be sure that the expected encoding is
used, right?

Ciao,
Dscho
