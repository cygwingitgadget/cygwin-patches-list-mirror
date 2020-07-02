Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 63EB43858D34
 for <cygwin-patches@cygwin.com>; Thu,  2 Jul 2020 07:47:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 63EB43858D34
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8hlZ-1jmCzE3UuX-004iYQ for <cygwin-patches@cygwin.com>; Thu, 02 Jul 2020
 09:47:49 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2C6F6A80926; Thu,  2 Jul 2020 09:47:48 +0200 (CEST)
Date: Thu, 2 Jul 2020 09:47:48 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/8] Fix dumper for x86_64
Message-ID: <20200702074748.GO3499@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:g0nu312dNFv1FlpGF0K8HgQvMXUwnI2oRBPioL3xuft1mrwwTQi
 lKLbQwXM5WAOXmr/Kh9wyZEL58Mt9EaDCw7R+FH+PBip723IhZDi389suP94UO44DsrwQ1l
 6wfFFqaXb2nCWdtcf8G5gJUgWCPxDzftjMuknWVOo51nBefPClotAYzjWZYAAQwDHQj2Ece
 re7YQ/SI/Chu95jKgAmuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1yfEWENrz+o=:QWbPKrVptj9bJUjwkVSvlw
 AlLtdW+Ys99YpqYzs65luLrUvAf//ElUrb3zMO/TDe6aWrLFLHv+jjFMNA2sSClPHzH7n81MU
 ls3vnSHEoPFvl2pihF4qzyO0Ll1ewyN6q67ATw7gW7z0UnGvJdI8iwzHh0mh/VVrd3Qv14fAx
 bP9sWWsStl7DjEMXFIsuZKKTbftLZOkty/ecDujtFjkj3u7TKC/OhS1bBJQQ3hM27v6JqbDnH
 Wup/Csxt05QOHldmKBuIlsr6Rb/vFulurfGevVO8FNvSox3da+qu01WUPxATS+RlrhDI29uHF
 cjyYhlQ5LeYvlo9UeFGrEgSdCH+oIJiWxdXEG4YPJVjbFHlbL9LnU3pbxxbw42cv/VvRZ5kBU
 Xy4uaHlP3QgPZnC8VB1aMSeNEjMkoKJT2d/hxubSyGBNx216s1HsFmWPLGh0YwacqUj3z50mf
 pZWVP2tkxOyMLtXlmf6W6Jbwjk5RSHyBJzjESlD9SjukmlAFQ/ST2gZvyZz8fTXowbO2IX9i7
 TJ4RA1OK+BW2Iu/pcHzjsMsQdvlpISbPRjQL0AWgAlMtv6af1Z0xNcHaVtOm83CQFd6OIk0u0
 Z5endESaymKTkIYZwvunkipqZXI/vr7Brd/PP1oO8notrjiTaAgLX0mvmJuXtXbZdkBnzQiVc
 sl7Zp9HiW3cnBKAX3RMpbf04DAg2gEZef+yTIhWiPfk4GAoqhUQUB2q+TzSG5oiyFEBSJ1P8B
 6yHD4GivZmEJVJFF1AfGWMc3WwJNjFO/L3t4X0CBWZiDjq3LYJjIleWOTZCMR3g+i8Daj/mQv
 lAVuofv567ebJ65B8AYivxcybD8B3iwAj+8+VxuMU9ISdSt5zpyYXUf2irOp4USVq+Ak7ES
X-Spam-Status: No, score=-98.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS, KAM_NUMSUBJECT,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 02 Jul 2020 07:47:52 -0000

On Jul  1 22:25, Jon Turney wrote:
> Jon Turney (8):
>   Cygwin: Slightly improve error_start documentation
>   Cygwin: Update ELF target used by dumper on x86_64
>   Cygwin: Add a new win32_pstatus data type for modules on x86_64
>   Cygwin: Make dumper scan more than first 4GB of VM on x86_64
>   Cygwin: Fix bfd target for parsing PE files on x86_64 in dumper
>   Cygwin: Fix dumper region order/overlap checking
>   Cygwin: Handle excluded regions more robustly in dumper
>   Cygwin: Consider DLL rebasing when computing dumper exclusions
> 
>  winsup/cygwin/include/cygwin/core_dump.h | 16 ++++++---
>  winsup/doc/cygwinenv.xml                 |  6 +++-
>  winsup/utils/dumper.cc                   | 23 ++++++++++---
>  winsup/utils/dumper.h                    |  2 +-
>  winsup/utils/parse_pe.cc                 | 43 +++++++++++++++++-------
>  5 files changed, 66 insertions(+), 24 deletions(-)
> 
> -- 
> 2.27.0

As soon as you're sure the timing is right, feel free to apply
patches as you see fit.  Dumper is all yours :)


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
