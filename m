Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id A5DAE3858D34
 for <cygwin-patches@cygwin.com>; Thu,  2 Jul 2020 07:48:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A5DAE3858D34
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mq2Sa-1j4w9o15Aw-00n7Am for <cygwin-patches@cygwin.com>; Thu, 02 Jul 2020
 09:48:58 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CFDE1A80926; Thu,  2 Jul 2020 09:48:57 +0200 (CEST)
Date: Thu, 2 Jul 2020 09:48:57 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 8/8] Cygwin: Consider DLL rebasing when computing dumper
 exclusions
Message-ID: <20200702074857.GP3499@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
 <20200701212529.13998-9-jon.turney@dronecode.org.uk>
 <20200702074317.GM3499@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200702074317.GM3499@calimero.vinschen.de>
X-Provags-ID: V03:K1:+Eh4+UKS5EhGRuSPMnccbcii9DWMsFW/s0XEmvxLh2x4QBejb0r
 k6llwNPuOe7Pjy/dKhoVsks/YxAkYV1PzStaeuLYh/tCpD9qmfwKG+YSZk3iK5H2FzYiEmY
 rS0gjAtoBuLCCgMBGM/98Swf5hrKDntHc7jQ5gUXVuQO6BatDrRxCIHQHW9TWjpR4hY1/wJ
 tlutGCTcMixO30hWOgcNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GmpL2KbsRK0=:Gmblv3cJvGFaYm1CUgSbeH
 Uoffr4dTlbATwE6qsXpedoIvwiMe3b0DaMHp6C8iHa+kkyG2E4QhOAuSdaJqDkKQfZQkfJym0
 iIctbT7AS7leDrWdeVPDiAgKJ7XMCrq78nrYN7EybpCeycgfRE7CH0HZPdSBZ3F+bFe/yJfh+
 Z6HxSbLcH72X7zt1t+VwzvFM9sxVQAyoBeHLn710Ddpq2kRSYQAYZiAHyZlPnfpEF7klTptE0
 MfyY8pVRQwF7MejXBqQnfiTckh1aAmzirKK72M7mpXPjd5SZvw/0MqKHmngIjfCstpLVtYDPh
 ZFIDRuEXCb4XZibLPgbYLF1+UQTlTIDN9/xISUDUTjsR60ZFBalPiK3iSCMGi2ZXBu1Tm8hjF
 7Fkn72w1WO6rPQlLOPwdIz/vZEiwuYxg/jwbovQWzHegZl32vs7Zy49dIiDxAEhCpLU8vlS+F
 y2jat+r3D9YWHK0gFhgyRn1E0DGSbmZfValmoo3CSWyoc2szdG7lgyL/GahFSv9audpvlKH2n
 ksqcsUs4VjHuUdiqAhUZviRrBXLmsCaPN0yWIty3L9AbuLeuCAnt/Dqsiy87eHwiDclHROcBQ
 8WW34LxGmApxzkV7m5JhIzfAFQA+B4lVufQh0sru0q7i6OE2Kyr02irTVvQizy8TRklyv6Paz
 yKG9zeklf3p2AiS43LpxgZDqCo576ic8bVkps9QspYHarLMNFdKBSPIqs5vHry3h4y7DH9qXz
 Avc+4OS10i7XNIDk/swLLDua//Aw9RKIE1l/7EXtWJ+GRCc723A+g0x6kBfDO4xNPjuH0ZkPE
 gSi52fn6o3QYiJ5hvR/2DlIIPWfpkcRTOVt7lUyUmZis4d2kJu3cD5Rmrkledx7DTzDwJ20In
 Z9kwm95f4NHYk9mAH9jQ==
X-Spam-Status: No, score=-98.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Thu, 02 Jul 2020 07:49:01 -0000

On Jul  2 09:43, Corinna Vinschen wrote:
> On Jul  1 22:25, Jon Turney wrote:
> > I think this would always have been neeeded, but is essential on x86_64,
> > as kernel32.dll has an ImageBase of 00000001:80000000 (but is always
> 
> Great, but that shouldn't matter much given that system DLLs are
> ASLRed all the time.
> 
> > +parse_pe (const char *file_name, exclusion * excl_list, LPVOID base_address)
> >  {
> >    if (file_name == NULL || excl_list == NULL)
> >      return 0;
> > @@ -104,7 +104,19 @@ parse_pe (const char *file_name, exclusion * excl_list)
> >      }
> >  
> >    bfd_check_format (abfd, bfd_object);
> > -  bfd_map_over_sections (abfd, &select_data_section, (PTR) excl_list);
> > +
> > +  /* Compute the relocation offset for this DLL.  Unfortunately, we have to
> > +     guess at ImageBase (one page before vma of first section), since bfd
> > +     doesn't let us get at backend-private data */
> > +  bfd_vma imagebase = abfd->sections->vma - 0x1000;
> 
> VirtualQueryEx?  The AllocationBase is identical to the base address
> of the DLL loaded at that address.

Uhm... right.  Always assuming you get at the Windows process handle
from bfd...


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
