Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 9196E386F424
 for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2020 12:54:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9196E386F424
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQdtO-1jsmzV0VFu-00Ngia for <cygwin-patches@cygwin.com>; Fri, 04 Sep 2020
 14:54:11 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 95074A83A87; Fri,  4 Sep 2020 14:54:10 +0200 (CEST)
Date: Fri, 4 Sep 2020 14:54:10 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: create install dir for libs
Message-ID: <20200904125410.GR4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <vrit8sdpaezo.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vrit8sdpaezo.fsf@gmail.com>
X-Provags-ID: V03:K1:UQgzeAl6+UrnnFRNgti7cJzoVMxI2RDO3BvjBjk5f8b57wNeHYY
 JOFAP/VgOKBSYhnTe8XqApkT+NaIv1JgBpvfHe47CFGbJezVaWxm3RkcffsSZXn1twkSIC1
 +kYIepJHoXiUrtMDut+DbP9yj8ytOojV52K9r66BgmsMAye+vcUCNXUza511kLoDfHtrDR1
 hDGplTlh69DikAV7unwxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ubvjyXKIALs=:5nL+pVaAkOcML7mzjCPdos
 SCJg1relDvhRphiWiH02SX6kFGZQa6x+L7zHyRXc7NEJCMYCUtqKb8vETf2A8krm/3iVnE5ws
 QHCMHNM8QDCp5+g4TstQ3BcjJtCwRpDcwSF5Qj/LW6eZ/vJNu6IDcyqpH7LYNz+ABGzM0pOd9
 5RXoAXvnpZN5VkP2MKYvvZptRMGfPvD52Rp3xIZBfXTEVZRMaTIoI1z3BPAzEgmgouTPlNrWl
 hvbJr+QZmPbG3+7ujKA631f2RUlw4y9+BVA6oQW12wmtbiDULAeX5vhuIsQRHlsddY8O6lOOq
 CGZ28OHkpkeR+qsQPD0Ap1D/GCm7xYWiB4//l7CmeZU7nzqJJuVWpzmFwqBrwZpc8JquKIfwi
 WG/UayWXpYWZK5VnMz0r1cNuriqzmsykxohIx54H/E5IhGabydCFFfRAJ+6aY+CiaP9EWQvQG
 aUKZ+hQC6bB4Ocw34kPG/w4c6CSQaOPA8F5N3VBCMXSTjeKk+0L3H2j2X1zzwcMtkQ87wJUjn
 a7jxHOSu/e0JQMBHlmB7FISzswkJbEaZClAoMqe/tlndf9WngU9DqDLHsPQ38kt6iWQstdjGb
 E9dK7zo6ZUraPhOa56OoQ0CU/cB3Gike6t0MhcDRDCES6CXPw9QYjfEd1CQj4TQpBCmnkPJpj
 +Qs4abwEvWm/q/ewHyk1q2lDmAjWmb558iffZrnVq3FhSZ8hDVl9riWDrAOSdMRb+zirAF2W0
 v8dwTxWBqkouo7VAU0w59NSrsJcSryM4ph1EJBPXC7ORt/cBBen2p3yTYxTGQ3gIonX05UamP
 JnAJP+ybl+5nZoZzfJjj+cqRrIrUVGWTiPIiGYd2DjqrNaad6pJfknHG9JLSNxiXyHjKmIY9d
 74zx1Yvvz37PFWLCCE4w==
X-Spam-Status: No, score=-105.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 04 Sep 2020 12:54:14 -0000

On Aug 27 09:02, David McFarland via Cygwin-patches wrote:
> This fixes a race in parallel installs.
> ---
>  winsup/cygwin/Makefile.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
> index fac81759e..ea0243033 100644
> --- a/winsup/cygwin/Makefile.in
> +++ b/winsup/cygwin/Makefile.in
> @@ -600,7 +600,7 @@ install: install-libs install-headers install-man install-ldif install_target \
>  uninstall: uninstall-libs uninstall-headers uninstall-man
>  
>  install-libs: $(TARGET_LIBS)
> -	@$(MKDIRP) $(DESTDIR)$(bindir)
> +	@$(MKDIRP) $(DESTDIR)$(bindir) $(DESTDIR)$(tooldir)/lib
>  	$(INSTALL_PROGRAM) $(TEST_DLL_NAME) $(DESTDIR)$(bindir)/$(DLL_NAME); \
>  	for i in $^; do \
>  	    $(INSTALL_DATA) $$i $(DESTDIR)$(tooldir)/lib/`basename $$i` ; \
> -- 
> 2.28.0

Pushed.

Thanks,
Corinna
