Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id BE2B63857003
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 11:02:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BE2B63857003
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUXlA-1ksn8y1tMu-00QRG4 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020
 13:02:56 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 11E25A82BD6; Tue, 13 Oct 2020 13:02:56 +0200 (CEST)
Date: Tue, 13 Oct 2020 13:02:56 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/6] Some AF_UNIX fixes
Message-ID: <20201013110256.GG26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201004164948.48649-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201004164948.48649-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:07bef+4ec51P+8mdD4Ly8hhrpI198CZAlu1aocd3+fTGfa6+LG4
 Xhwf6uN0Fzt+VRvt0bCZMQVcMkck/Q7Nh7CHK5XeJdAiILEzvz8LIq3Opf+CeEru7cJP07I
 vGQHgmwYGufa7Jg8GG7wQdeW9eL4Eep9ih2EARcMJTeX6klQlvG0uJTF2/pEJCp9OlKyO2Z
 VQGIF8HpzIEXF6zBvskhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kMY5WO/8iOY=:9soieKZfK49QSbUiRiEmPv
 DYXAEKqTjIo8XjMx+Evsf9hLbpxQg9p8IelV7hUS0khGwRs833lHCBuudLnRPBcUbHV/NsJ7q
 /hgvyFhTeUuEa4x/oUOqhwF8A7Bmz6vsg84JfMDHnxN2w3583AflFtLgmgWix4iUBlghqesid
 l305peK6RSebW0gvNPy4GfKva/5fFXN3nhSw5zS0+DH0rOl3YT8kQydO7lx737ERJUphe5WF4
 P/VKJGbFLF+LqEVJ0xYeMRbvfUUnpcUuFRZZtdLeECZgWDlhicU/xGqitBiMuajcv66IBxfOq
 eqa7YlrE6ElJ8all+0hj/5HwbIt3YOBXf/SA70+BUDJ5/qT2Vtyw+sIGWr4fhhLLskfWeh607
 WLl2f8DC5JzhX/JdUuMp40BDgqaM3os4YY/NRGyK7uSWswXoIyK6M5E8ZkfGpNtRD2KBT84Vc
 PrxAj6yQGA==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 13 Oct 2020 11:02:59 -0000

On Oct  4 12:49, Ken Brown via Cygwin-patches wrote:
> I'm about to push these.  Corinna, please check them when you return.
> The only difference between v2 and v1 is that there are a few more
> fixes.
> 
> I'm trying to help get the AF_UNIX development going again.  I'm
> mostly working on the topic/af_unix branch.  But when I find bugs that
> exist on master, I'll push those to master and then merge master to
> topic/af_unix.
> 
> So far what I have on that branch locally (to be pushed shortly) is an
> implementation of fhandler_socket_unix::read, which I've tested by
> running the srver/client programs from Section 57.2 of Kerrisk's book,
> "The Linux Programming Interface".

Oh boy, this is SOOOO great!  Thanks for working on that!


Corinna
