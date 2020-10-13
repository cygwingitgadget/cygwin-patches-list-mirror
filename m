Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id D517F38618E2
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 18:11:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D517F38618E2
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MTikV-1ktVLz1uAf-00U4jI for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020
 20:11:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id DF59FA8184A; Tue, 13 Oct 2020 20:11:05 +0200 (CEST)
Date: Tue, 13 Oct 2020 20:11:05 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/8] Drop STDINCFLAGS overrides
Message-ID: <20201013181105.GV26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
 <20201012192943.15732-3-jon.turney@dronecode.org.uk>
 <20201013121012.GL26704@calimero.vinschen.de>
 <e5c85057-5570-8076-1b5a-0bcd74a5c701@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5c85057-5570-8076-1b5a-0bcd74a5c701@dronecode.org.uk>
X-Provags-ID: V03:K1:OiLSKZYo23puK+Hp/yQH8Vgf7vT20XKStq11w5dat3jpV0I1LNU
 JHLGjn1ppzkqJc7zK5cfiq7QCYYp/eTsLLHI6u1os/nJBUnoBcNUjAJFCwMspgXqNyVLSv1
 mt17habfesZos2hARHubmLiJ52FB087aGhj1N5eBgS7o5OXW0DWcIHasvkdHd5CeYcb2474
 5FNSVLUYBbrZjdKOcr+Hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/tiJEd30N6M=:xZPgcd49suzqfyINOb4N70
 UOlm58vuOptjxMzrT0uewRWt+G2sNyX9F6JFpXAkbrVUpDRIWfvr70t14k5P1K28wG6Pyd9Md
 X4KswAQ1akWoYB6Wrld1D4/T5T3NKLq6zD+89vPW/IoMkZmNBKqiLkKG6IHM/H9PJsotOIl77
 JroiOaXNwP1i8ksaWr6Vm/luS+KxKgkiBciCueiOqxBxis/KuvIOmXizkRh2tjmT/gjn8Ddh9
 ao6iPkwNpNjIfqvpUfKvd6HLfmBF0vup5fiszIfeBehKdLUtWyEpVqt4YHqKBaMHOcb1BJsk4
 OEiHdSPy2DnJYLioIvcHd+1bote91utEz0kU12HICJq8bV/rSGPMQVQt9GGxMSI1YiedFCKNj
 KSXZdRhMu3KNvv0OzLSfqk1C8vVzEAqMo/BMlCe3VTtr9QcTeIoIiB7QjElGAsWbzIUPmE7NN
 oHHD0Sdunn5L6QNfhgaNUTxhfMVVrUsezLx1w6Qkmjt+c7JaXPEqHt6oM31nPpJ5oHIXc0Z32
 0fhfETv5yo/J2ruSh/O3nn+K20nIUuCumuNbU+xPMXaf/r9v20zHtM68Pht+i1dMDvwFybgZR
 Ox4eLyLu057R5WldLOnoxxSo+8r2vtCI20pGWsEAMFn2LU4La29EvAfxO+1K7hMTLcADgbIS+
 PVjc863LIZiOgBjlD3YvVf16oK+1c3cCPmUhgaEijP3pT1xJoXXk8QL7/hEBs8ptv7icUwNrB
 Snl8PtM9JyhxY0MVTa/52gzfRlpUT6PQIVaTx+J+bznjkKOzi7M2G08h947leUz8Hf2QeJL7v
 sd1qfDVIZk7GMN4Ot/D7TFjJGRzJevMGvua0UO6UJU/p96lX8yXTQ8cqxb16nXjqCNCxHtWe9
 VxS/teV1Fkj5GfY280rDHA7JTu104BqQEYy/Vg7T8=
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Tue, 13 Oct 2020 18:11:09 -0000

On Oct 13 18:36, Jon Turney wrote:
> On 13/10/2020 13:10, Corinna Vinschen wrote:
> > On Oct 12 20:29, Jon Turney wrote:
> > > This used to turn off -nostdinc on a per-file basis, but has no effect
> > > since 4c36016b.
> > 
> > I'd prefer a longer SHA-1, at least 12 chars.  Maybe we should
> 
> With ~20K commits in the repository, the chance of a hash collision in the
> first 32 bits (~~ 4*10^9) seems pretty small, but sure.
> 
> > add a "Fixes: ..." along the lines of the Linux kernel from now on?
> 
> This doesn't actually fix anything, just removes some cruft.

Point.

> > Ideally we'd get rid of ccwrap/c++wrap, too...
> 
> Working on it :)

\o/


Corinna
