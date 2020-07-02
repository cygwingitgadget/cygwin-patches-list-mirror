Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 75050388B01E
 for <cygwin-patches@cygwin.com>; Thu,  2 Jul 2020 07:44:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 75050388B01E
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MAPBF-1jgDqR4AsF-00Bqqf for <cygwin-patches@cygwin.com>; Thu, 02 Jul 2020
 09:44:45 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A816DA80926; Thu,  2 Jul 2020 09:44:44 +0200 (CEST)
Date: Thu, 2 Jul 2020 09:44:44 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/8] Fix dumper for x86_64
Message-ID: <20200702074444.GN3499@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
 <e058a12f-97b2-d237-a97f-4a691bf5c6e3@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e058a12f-97b2-d237-a97f-4a691bf5c6e3@dronecode.org.uk>
X-Provags-ID: V03:K1:Rvakr1KJq/B22XNoqvrztairAdbpwAsBFFsvGvKqMtnWwiXOn+u
 WeobLDC/W0c9qUOdpnqY0zmi/h/TmIE+viJwxC2MIF5/KZmrahPfhADtwpKKxD8bY/GPSmr
 fPEJu6ChKLke2UL3KEot7mfP4eNNJvXR4r5gzkwb70yY2rCE/7Qm+XrzXNpCq4knRU0OAaf
 ML1rN7CWn40B2WvthZItw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ZOZy/qpA+I=:vmDBfpswR3bgkDLCxXSmuc
 V+QWVgBUFcDwPzloTHv+o4IYNdX6OQ5O5VWH5IHVDmatcGrnih1qhs7zsDnp6durehzUnAdKu
 clFOCuFM3GErNgzAwB1Ncfqhzfkgjx23tG6qeVxtFyaQlJt7zjwncXONGSO5ouwSY+0+dQOG0
 HmrxHISO1Sv2uzV/xm70NeSThrSeOlZ/ABG74k9CW4uBq3xrLHhTMU1xn9Jck+JEyS0vAk0D1
 NUf/Fcll9poV3NZZDIAa0cIF+PNp8Q2fcOUH54R1m91vpaKeRL3xN0XqJmyZgCBTFGZsqhtw+
 zs+opOxChj7J+CyPBTRCV3lHcemqCuelbTwoI/+Ca7tbT7LIVtTxQwNiS1dYC6d3ChBi0Dn7F
 EaK5hQTIPRGSD6/VZJ7e9wN4G2PVImLBZU+rvlu522yHtt0TQ/8L5u3jkYA47YxcDeqJYN8Ts
 IzLoaE5xHgtPR/YDu8Kr7CdWMgzqZJ7JSEdMYhEh80UGvIPtEcpqo8ZX6MULRQ/W08uc7W/2b
 om8OMoPsJ7esJjl6i3wpq8N9EJeM+UGM7hb7lRAI+kKQcUQQ4Z3IaRWQdJ/89+bKaCB8cdV+/
 IuhxnELmvKF474WdgVIm/X0CkTMehit6QSXN+cVoG+RA+6Ltd0v+rH0+ETJajV2s7I4bnSpzV
 qU64Ehmq8I8sIFafD2rkiWlEBEthA5BOwCdElSD0P10zTjCPHbaP/B8toJwzyCSftZtl5Ab7P
 gueXsKxOdkrYzfId39Fxty6pq2Sy/8tp1dhJec2jmfiFxXGVJTpS/7pkxqYPDpGabXL1jo6LD
 VsmyB3Ix5krtg3z2qPgnq6wB3+l1V1bwwceiTrULDuzGbo1nZsWKK/T203tB7gjxJVZAQAvby
 zVEN9FHpa94Lzgm+FrUQ==
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
X-List-Received-Date: Thu, 02 Jul 2020 07:44:47 -0000

On Jul  1 22:29, Jon Turney wrote:
> 
> This needs to be aligned with some changes to gdb to consume the dumps it
> produces, so it's probably best to hold off applying this until it's more
> obvious what's going to happen with those.
> 
> Random notes:
> 
> - objdump identifies the output of dumper on x86_64 as
> 'elf64-x86-64-cloudabi' (perhaps due to some over-eager sniffer).
> 
> - regions excluded from the dump aren't rounded up to page size, so we may
> end up writing the excess into the dump.
> 
> - looking at the loaded modules and inspecting them to determine what memory
> regions don't need to appear in the dump seems odd.  I'm not sure we don't
> just exclude MEMORY_BASIC_INFORMATION.Type == MEM_IMAGE regions (assuming
> they get converted to MEM_PRIVATE regions if written when copy-on-write).

Could format_process_maps() in fhandler_process.cc be a role model here?


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
