Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 5DCFE385041D
 for <cygwin-patches@cygwin.com>; Fri, 30 Apr 2021 19:07:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5DCFE385041D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFKX3-1lnr193x5l-00FnWZ for <cygwin-patches@cygwin.com>; Fri, 30 Apr 2021
 21:07:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 94674A80393; Fri, 30 Apr 2021 21:07:06 +0200 (CEST)
Date: Fri, 30 Apr 2021 21:07:06 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Ensure toollibdir exists before installing a
 link there
Message-ID: <YIxVWm/s1XoksqSh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210430171455.26156-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210430171455.26156-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:jJRmGxMeEFBM3bnBJq7bfnQntLGmn+I8cg1xlfEc43oFViPK8zx
 GHIHoquCQ9AM2Ie2RcGLKsgJ5SrtpeiP8vfu1kEDfFTIRFrXZ5+y7LIxbS/a44AeJEn5RPP
 dHE6U8Xj4IDflSbGfGtPmwOJB/E+yweRbuI52Ho27quFQGBHiVOtHfwlwkD12tdoU20QcoJ
 Bd+UqHtueKLa7Qoq6Y7Og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4hSqa0m3VpQ=:6PIL5oT6RvtvEiXATW8quq
 OvHgyMLK9pwHyz8E+uQkZCdKMj3j09K2JMDdW1DOuqAPLPnmpj/rVnF76RgyY5txPpPOBIr7t
 4RPfAOtNP3PK956NC+7aMfkIVyszln4tF18PIXyhCenEVW/RlYQgZvuc/lG5uLcOAjhgT4NKw
 CkcqZ6zbkJ/CasL/z+yUKrAoZJJ1xuL93wUUGGqI07paA0rmGr8CKLxz/KZ6Q8Pojzsad0IRa
 zN5cfxkVE7mbAB0VE0C1b3abDSeD1yYCwDJx8955gsBD/4G78vNjcI/XMElleqf2fan7udp08
 zfXPgUklQeTGdYlQdBdjiAf/g3r5h0t/36xC3OzrJGBwMOwTDuTW3FhIdnR9hjE7UAWLtXm1A
 7YpjXVe4UtO1vUtB6Uf/9riK+caeU2YQC7OfaSJho/8BpCguayQO+akU5E75PMySmh4YVCWji
 zIyg+Ap8+/zs1TdiuLJYlRA+qzu3E3rZWaaQX9DJlJl/fhByDss+GHWKjny9K3cRdg24p9uI1
 pijJiaCyq4yE0X3XplVNYM=
X-Spam-Status: No, score=-106.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Fri, 30 Apr 2021 19:07:09 -0000

On Apr 30 18:14, Jon Turney wrote:
> This helps 'make install -j2' work.
> ---
>  winsup/cygwin/Makefile.am | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
> index a2e673c13..8cde3f452 100644
> --- a/winsup/cygwin/Makefile.am
> +++ b/winsup/cygwin/Makefile.am
> @@ -733,6 +733,7 @@ install-data-local: install-headers install-ldif
>  install-libs:
>  	@$(MKDIR_P) $(DESTDIR)$(bindir)
>  	$(INSTALL_PROGRAM) $(TEST_DLL_NAME) $(DESTDIR)$(bindir)/$(DLL_NAME)
> +	@$(MKDIR_P) $(DESTDIR)$(toollibdir)
>  	(cd $(DESTDIR)$(toollibdir) && ln -sf $(LIB_NAME) libg.a)
>  
>  install-headers:
> -- 
> 2.31.1

Pushed.


Thanks,
Corinna
