Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id A61E7385E83D
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 14:06:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A61E7385E83D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MEVqu-1lz6mO1Hzu-00G3QG for <cygwin-patches@cygwin.com>; Tue, 06 Jul 2021
 16:06:58 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 93834A80D68; Tue,  6 Jul 2021 16:06:57 +0200 (CEST)
Date: Tue, 6 Jul 2021 16:06:57 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] format_proc_cpuinfo: add Linux 5.13 AMD/Hygon rapl
Message-ID: <YORjgZsC3VHpmYPe@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210629170924.30628-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210629170924.30628-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:bvxXhACc0cZycem4X6BL66CD73mmGnvq0c+Y2Bhm7kRgf57X2tI
 /U98WrNppXc6rqcW8ynw0mCFyR9WJW+bi42CFuVo3BAAhAqwgDsGjgXmR7ho7HD1vhzmJ1+
 zX70Ez2NO2w+3gGinJRJ+Vd/7O7lgOQUnxDw9gpG4Py0/D/yKFoLtrljUtMCU8JaI6TcRzC
 jKt7BSjm3Qi/Q1ipfDDwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JuG3sj5Wf8k=:popgXJ6pxjxotcwH1QO2m6
 Nni9WtkXYmOSis78czGfeEBeaP/3yKsDRc3QES/MlhKSomuEY/pQFUFz43AyYwTRGRBJxOysd
 0/RxFitwjrVdLo2RcloAcQlB75I8NggkBQkxl+L9URqhrn5Dcy6AbdH05wxdpYszA4JIgt69r
 Meq38ZH0JUbwqvkkJq6vbc+co5/eANJkxc4dYWvITdO8+VyACmeZF8+hGI7HGAGKU5QFwZBXc
 IjvouMhaQGFpY4/5klv7TkRqIoJDKuGLdUho/uBvr8uhalBxFKvhm9As7R0Vwey8ZMbyO6+D6
 jFmab7K+5mJMTGNNNvUewceZYU76R3ospuCVqmTcGrlwMZqmsYK4Hzr9ol5FDyXpE4uDwvTr1
 W3eWbhu3nMzkH9IyyPLe7CaFd33ArtJLGerAa6DdpbQTGqpfJ7+oyprTylMy/KcG0jx549avG
 IjpcqSzNG8QD/tqFDGd6NBrl6pqZ/k/INrkjFV90vXtSUsFtpWVBOCaoimqxNTOFL5IU59are
 167UkwkXyAPwRha+//8JQIzyABWHuBxuQLTF+K/+/1vb5NDBEPUYz8IiH0Dobgy36xx3aXYdX
 gY9jHlmFZ8NUbBNI5nC9vl/uHo+5mrCTwTL+Yj8Ov3ETjDEZ5k+SAi1ZGKWhjdI3nSKfyGmfO
 6no6ZeW50HGdIRJLN42gb/If5cJW2uuqtXZcowxVXgRy0YuOHPsXw+RQAfMjoFR5XpEZiGFzM
 BwCGHzN2l1CemrOr0vFOyCHFIjJXWmq3ACqJ6FhMpQX5YbXmn43E9zHDKhDYWZMa6NPQKF6e1
 gQJxm7o4ILtqTKIGHsy+5GiNHhTDf4DSpHIOh78ZNIGIwHbhZDKYl9TV39cgMuKh+GH1NF2+5
 zBINpNJorkOdXspJra4A==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 06 Jul 2021 14:07:01 -0000

On Jun 29 11:09, Brian Inglis wrote:
> 
> Linux 5.13 Opossums on Parade added features and changes:
> add AMD 0x80000007 EDX:14 rapl runtime average power limit
> ---
>  winsup/cygwin/fhandler_proc.cc | 8 ++++++++
>  1 file changed, 8 insertions(+)

Pushed.


Thanks,
Corinna
