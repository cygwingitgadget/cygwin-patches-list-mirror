Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 153923858001
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 11:00:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 153923858001
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MrQ2R-1k5O4H2tOR-00oUZO for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020
 13:00:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 0F8D9A82BD6; Tue, 13 Oct 2020 13:00:06 +0200 (CEST)
Date: Tue, 13 Oct 2020 13:00:06 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: winlean.h: remove most of extended memory API
Message-ID: <20201013110006.GF26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200923235225.46299-1-kbrown@cornell.edu>
 <ddeace5b-33a2-ed1f-5b30-0d33bfe61ca3@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddeace5b-33a2-ed1f-5b30-0d33bfe61ca3@dronecode.org.uk>
X-Provags-ID: V03:K1:r1/grUPd3/4YxgTfIFiP0gfF1f0E6FFVcj7OMtGQrB50E21LJlK
 idzrb9pAwJXCUNrDKe1UTnNyruXy0rISiIb9ViU/Um6Do5UipVfxCz78UtYYF4sTN3Lflkw
 f7sx0jAjivLprOtD6U1hCvmE1Mw4pVmM3kF/F3dY0OnQyk64efzSD/r91eEhcCqm1+1TMuB
 6NjPyFw+PWNxzOEeXTRcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:70C0Hfi+l4U=:8CqOdoSneDIGcom/YSDJfb
 09WBW/2YQZ+I5Xz1qxpf1pTexhCTng8wrmSIsPremmOpua6bVj/UCO/CcraEGa0opqABcFBUN
 taSCD7op8BTUc5SgBvngFeT0HQNvyIpQZSBoCmBl4gBLBdBf1n3DPAyEfeuuEn0VN/eW8gTMy
 Bs8MtnxUC3tnFHCmC8VybrifuWWsHLnqlLjjJ+AKeqCKUTqZ1Ijd4xylNd3Vdl7HSF+6RPGmC
 sar4VYS621AFf2Hr4ZVj9nM9w+w6zkrA9+GgWJn8xO6p1d4yt0shEN0HW+Gsa7dxGxtFBhZGX
 Jzx/GRCWeljNMaTlf7BG870kGQWvB5rlSyisb3qZjulYbgs61gK3yZdKeDDz5uIJirnXQ7tEs
 0Gp9hlC8K5jifmTfEQjuDgTNgMoqecNbInm4+E2ZmI4YfRing8bKpqiov6fNWxwmaaFVm67X6
 2j0HJsGg9yVd3fM11AfzifnOkU0AndabioaVQqdWACSOP7svV8075WCMqTZ0nB+z/45e25ILF
 uoCK+ijDXzegkiK/dh6ZKpQiTv9P8wZrXcc3QkmEcxFAYBdBJzJ95JfOweXtCV64F/5DJyFyp
 gzd4pt2W0gj+7ivcv9gsI2hIXNQ5VNTLNnDXmztSj3YEz1c/AFbnq4/LoILpmKbDjrvRIdBZF
 KVh4qF93c7/uDN0aqAfuF/J79nCsKKhR3urE02jZsvLqXWbCgP3Dd1CcIv1YUueemgMvVkBEU
 qlKHI+qruwQteuC3XB/bOFdrZM9w4gvjjKsPz42K9Jhb29GDslxm2zGZVw0KM3MPosuOUwLqs
 ibwR9eRbi3fgaf8EKwAmgQzxsxrcL+DF/YCbQRDurwZyGBfDxSniWLKS6yoxk5snnjzXcNduo
 wWGr1YjB7acz5XnjNiDQ==
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
X-List-Received-Date: Tue, 13 Oct 2020 11:00:09 -0000

On Sep 24 15:04, Jon Turney wrote:
> On 24/09/2020 00:52, Ken Brown via Cygwin-patches wrote:
> > This was added as a temporary measure in commit e18f7f99 because it
> > wasn't yet in the mingw-w64 headers.  With one exception, it is now in
> > the current release of the headers (version 8.0.0), so we don't need
> > it in winlean.h.  The exception is that VirtualAlloc2 is only declared
> > conditionally in <w32api/memoryapi.h>, so retain it in winlean.h.  Add
> 
> I assume it's conditional on the windows version targetted, but it might
> help to mention that in a comment.
> 
> > "WINAPI" to its declaration for consistency with the delaration in
> > memoryapi.h.
> > 
> > Also revert commit 3d136011, which was a related temporary workaround.
> 
> Looks good to me.
> 
> I think this isn't going work any more with older win32api, but we probably
> don't care about that.  It would perhaps be nice to explicitly complain
> about that (checking __MINGW64_VERSION_MAJOR somehow), rather than exploding
> incomprehensibly if the w32api is too old?
> 
> > In particular, I'd like to know if my handling of the declaration of
> > VirtualAlloc2 seems reasonable.  Among other things, I'm puzzled by the
> > apparent need to add WINAPI.  If it's really needed, I don't know how
> > the calls of that function could have worked before.  Can anyone
> > enlighten me?
> 
> I believe that WINAPI only does something (stdcall) on x86, so it might well
> be that it's never worked on Windows 10 =>1803 x86?

VirtualAlloc2 is only called in x86_64 code, so the WINAPI was not
required.  x86 is a lost case in terms of memory allocation anyway.


Corinna
