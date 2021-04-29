Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 567893857036
 for <cygwin-patches@cygwin.com>; Thu, 29 Apr 2021 19:09:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 567893857036
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVeDs-1m3n2920MW-00RcEq for <cygwin-patches@cygwin.com>; Thu, 29 Apr 2021
 21:09:42 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 0E549A80F11; Thu, 29 Apr 2021 21:09:40 +0200 (CEST)
Date: Thu, 29 Apr 2021 21:09:40 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: CI configuration update
Message-ID: <YIsEdHJR1W0a+HYU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210429185324.17357-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210429185324.17357-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:tfMHwZgEaGjTxnMiuBUq61+ibKLJ4VzkLQ70/ExVHF4JjVzje4H
 X3np2IV8GJM70rrthGlkwWZQVcsnqP4+Kz9X6WV2Tq0XhmfesY7mm0WVQQ5Mv+xtQ2RRPjh
 jqgBkrWnHhrI5pjcGQgxFHNCP7hJxTBeGToa2WnvgPUNbBpul3j8H3LrQRf4DGlk/zPsRxO
 5iKCaXpJMd7TYnhGDmkkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Y3TabLhIgI=:1fnBgpKNUdK2qnr2uoISl6
 gkGaH1l12P+9lftMCFuWgQv5qBQNzDaXDR1WUfM4LUPqRTw/t7E88cbRVF8wAVd2QxUSIMjnt
 y/sQJqbO3FoCIE+G7VvfZe73K5fP82H3G82g1NWqcpRopz6ux34i673ivgWFiyEojM2A/27RY
 DB5511tUJ+4Lfjxm6ZJYYGUh8g3wHDHpck0f8q2uRRHu8G4Q0dEYIOK1HX+bcgc16lmEkxgbl
 yHg9cJO7qLoghXIk9USO1he8F+v0LA7oFCi7VE66/IjpQkivDAWo9agfIy1+s1DasqdPRcF8I
 Rdn3pevRU56tmcVOARXFAKY6ksxsFjlsT/Kl6HtUVISBco3oD9wGQY481I3Keb7KWkQN6fPDv
 gcQC63j/vTfS4fzZ08bvtLYyP0o5BQ0s2J9FKlTHe5wEPkBta2/otkMrt5JQ/x0RGGFJIL8kQ
 47+W7juT+TH5QqtoeVC0+mFFb9H5CcCedHZQuUjAMGG/RK/HjthA/wDqenJ8aiD6G4wJBJqWy
 vun+Q8qSMeg8gKEuSbdaeM=
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Thu, 29 Apr 2021 19:09:44 -0000

On Apr 29 19:53, Jon Turney wrote:
> Install autoconf and automake, and run winsup/autogen.sh, and don't have
> it silently ignore failures.
> 
> On AppVeyor:
> - use latest VM image, to reduce time spent installing updates.
> - run the testsuite, but ignore the result, as some tests don't work
> correctly.
> - hardcode the python-lxml and python-ply packages to install, so we get
> ones for the right python.
> - install texlive collections now needed to build documentation.
> 
> On github:
> - Use a copr for cocom, since RPMSphere's package updates don't track
> fedora:latest very efficently.
> ---
>  .appveyor.yml                | 13 +++++++++++--
>  .github/workflows/cygwin.yml | 11 +++++++----
>  winsup/autogen.sh            |  1 +
>  3 files changed, 19 insertions(+), 6 deletions(-)

LGTM, please push.


Thanks,
Corinna
