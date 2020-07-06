Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 34FFD3858D35
 for <cygwin-patches@cygwin.com>; Mon,  6 Jul 2020 18:10:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 34FFD3858D35
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFbBO-1k8RDe2SK6-00HBN6 for <cygwin-patches@cygwin.com>; Mon, 06 Jul 2020
 20:10:12 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 20FEEA8087B; Mon,  6 Jul 2020 20:10:12 +0200 (CEST)
Date: Mon, 6 Jul 2020 20:10:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/8] Fix dumper for x86_64
Message-ID: <20200706181012.GE514059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
 <e058a12f-97b2-d237-a97f-4a691bf5c6e3@dronecode.org.uk>
 <20200702074444.GN3499@calimero.vinschen.de>
 <b2a72bb3-1852-46fe-81d2-0107c0076564@dronecode.org.uk>
 <20200706081200.GA514059@calimero.vinschen.de>
 <edcb449d-43b1-b80a-a4f7-e7b8c64d4b3d@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edcb449d-43b1-b80a-a4f7-e7b8c64d4b3d@dronecode.org.uk>
X-Provags-ID: V03:K1:RkQj1OzML2dC0PR+pUEa/BaDmK6Ab0BW+JT7E4tKwBOj9VB4Gky
 oKISntlRjKPnoDcDlQurtCsPsfnGbcHn63c+i4Fj9BrqkLGBL+lKo3k36bPMoQE3iLgZZ9Z
 sn8x99iHyxlnproTGhkSkwf0xyx9tlffuzQTAZZ0ZkPXphCjQjs07wqHk+VvUdCY0HHvn/F
 PcATw1szeGjmsLg2fDSPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rvZpaJSKW9Q=:ANNrXA0wKvP7rc/0aWmf63
 x7lkdMd+9hJHzoci/fjz9S8NOmZbfgMfCUnlZxDiqvUA7e9vogGqXrqLnnHkQNyFURGZClsU4
 gw3namHe8vFWxvp47dSRRWMEE1CnJa71o6wX9iJZSfvN5aSZlFqsJ+exS63+gGayrtX7zNrel
 q5ZO2znMqvQsuowGFrxw80Uvb+gtYQ0fYAzBhgcIpCyYngOwp4sz39OGrejYiHii0O1hEZjk/
 p6uONHorFt2MXru/dSy3TgF+J3X+bFIMyRZGJhxCBCH3wK/jTQWZgtd1gMLBkCQzW+YUKmTDf
 NJ/7aJu538vNfomkBNT3PCBKyArDZvPUtGAKEKkBQbk+QyJXzDdeIFBR7WCJoJJYNunW1UGot
 tTxswb5UXA82gsd9wdvaYx+vNSPtCmsOEQjdflILrzEGQ9nugRxscmbyWJjAPK+JnvU3fDbZM
 7elSBaV3Y7AK5yNd7jJv7/8pOmV/ksZS5jge8LrxIVLWOwVFvKMX81kh69TqFcXbTwJU86w49
 7D2LCXo2cNHPQWrcneBIfrx/u2ojMVVhuXFEaZ4izatWJMlydiHXmbU6l1+U/k2sfDhrQWVMc
 BFTi+qPLJuLfsgthDK9FEmiEROATNTOzlgkUhywxKE+tERyeIz246m1E++gJ/pi2LmerV+sHs
 wo0L08rxgyuuxmlcSul+i1KQeCpwirT0J60PM97Q+76Zbpx+ByTWqGPcqqVrsIpxwBqjhPg3s
 /kDM/yhxcaUVJqVQFe3x9YkAlR9ZQxnOggTTa2BmHL1lYf8/g9hU+GqUXwevkHcWLnNDPTXJT
 MeF6vbeTjxMuSQEYucIXCAZ6tk+OJuzEd10LWOFrz+HHKn6k7WCtJaG9a8SxedsH6slTWVGZ9
 vdVOEO77XI3atBfK72Zg==
X-Spam-Status: No, score=-97.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, KAM_NUMSUBJECT, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 06 Jul 2020 18:10:16 -0000

On Jul  6 14:34, Jon Turney wrote:
> On 06/07/2020 09:12, Corinna Vinschen wrote:
> > On Jul  5 17:49, Jon Turney wrote:
> > > On 02/07/2020 08:44, Corinna Vinschen wrote:
> > > > On Jul  1 22:29, Jon Turney wrote:
> > > > > 
> > > > > This needs to be aligned with some changes to gdb to consume the dumps it
> > > > > produces, so it's probably best to hold off applying this until it's more
> > > > > obvious what's going to happen with those.
> > > > > 
> > > > > Random notes:
> > > > > 
> > > > > - objdump identifies the output of dumper on x86_64 as
> > > > > 'elf64-x86-64-cloudabi' (perhaps due to some over-eager sniffer).
> > > > > 
> > > > > - regions excluded from the dump aren't rounded up to page size, so we may
> > > > > end up writing the excess into the dump.
> > > > > 
> > > > > - looking at the loaded modules and inspecting them to determine what memory
> > > > > regions don't need to appear in the dump seems odd.  I'm not sure we don't
> > > > > just exclude MEMORY_BASIC_INFORMATION.Type == MEM_IMAGE regions (assuming
> > > > > they get converted to MEM_PRIVATE regions if written when copy-on-write).
> > > 
> > > Unfortunately, that doesn't happen, and the region appears to stay
> > > MEM_IMAGE, even if it's been modified.
> > > 
> > > I'm inclined to just dump MEM_IMAGE regions if they are writable (although
> > > using the current protection isn't 100% correct, because it may have been
> > > changed using VirtualProtect())
> > > 
> > > I suspect there's probably some undocumented MemoryInformationClass for
> > > NtQueryVirtualMemory() that would let us determine if a region is sharable
> > > or not, but ...
> > 
> > Surprisingly, there's nothing undocumented in NtQueryVirtualMemory and
> > the API is fully exposed by VirtualQuery(Ex).
> 
> I came across [1], which seems to use some MemoryInformationClass values I
> can't find any MSDN documentation on, but perhaps I'm getting lost.
> 
> [1] https://github.com/processhacker/processhacker/blob/master/phnt/include/ntmmapi.h#L87

Uh, sorry.  I confused NtQueryVirtualMemory with just the
MemoryBasicInformation class.  Looking into the above, the
MEMORY_REGION_INFORMATION struct looks pretty interesting
but I doubt it helps...


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
