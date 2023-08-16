Return-Path: <SRS0=m8hS=EB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0012.nifty.com (mta-snd00006.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id B2AB23858002
	for <cygwin-patches@cygwin.com>; Wed, 16 Aug 2023 00:07:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B2AB23858002
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 by dmta0012.nifty.com with ESMTP
          id <20230816000740767.MGUT.104240.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 16 Aug 2023 09:07:40 +0900
Date: Wed, 16 Aug 2023 09:07:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: shared: Fix access permissions setting in
 open_shared().
Message-Id: <20230816090741.3d78d7b6278be4e438ca0ff3@nifty.ne.jp>
In-Reply-To: <20230815233746.1424-1-takashi.yano@nifty.ne.jp>
References: <20230815233746.1424-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 16 Aug 2023 08:37:46 +0900
Takashi Yano wrote:
> After the commit 93508e5bb841, the access permissions argument passed
> to open_shared() is ignored and always replaced with (FILE_MAP_READ |
> FILE_MAP_WRITE). This causes the weird behaviour that sshd service
> process loses its cygwin PID. This triggers the failure in pty that
> transfer_input() does not work properly.
> 
> This patch resumes the access permission settings to fix that.
> 
> Fixes: 93508e5bb841 ("Cygwin: open_shared: don't reuse shared_locations parameter as output")
> Signedd-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/mm/shared.cc | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/mm/shared.cc b/winsup/cygwin/mm/shared.cc
> index 40cdd4722..7977df382 100644
> --- a/winsup/cygwin/mm/shared.cc
> +++ b/winsup/cygwin/mm/shared.cc
> @@ -139,8 +139,7 @@ open_shared (const WCHAR *name, int n, HANDLE& shared_h, DWORD size,
>        if (name)
>  	mapname = shared_name (map_buf, name, n);
>        if (m == SH_JUSTOPEN)
> -	shared_h = OpenFileMappingW (FILE_MAP_READ | FILE_MAP_WRITE, FALSE,
> -				     mapname);
> +	shared_h = OpenFileMappingW (access, FALSE, mapname);
>        else
>  	{
>  	  created = true;
> @@ -165,8 +164,7 @@ open_shared (const WCHAR *name, int n, HANDLE& shared_h, DWORD size,
>    do
>      {
>        addr = (void *) next_address;
> -      shared = MapViewOfFileEx (shared_h, FILE_MAP_READ | FILE_MAP_WRITE,
> -				0, 0, 0, addr);
> +      shared = MapViewOfFileEx (shared_h, access, 0, 0, 0, addr);
>        next_address += wincap.allocation_granularity ();
>        if (next_address >= SHARED_REGIONS_ADDRESS_HIGH)
>  	{
> -- 
> 2.39.0
> 

cygwin-3_4-branch needs to modify the patch a bit.

diff --git a/winsup/cygwin/mm/shared.cc b/winsup/cygwin/mm/shared.cc
index 2ea3a4336..20b57ff4d 100644
--- a/winsup/cygwin/mm/shared.cc
+++ b/winsup/cygwin/mm/shared.cc
@@ -148,8 +148,7 @@ open_shared (const WCHAR *name, int n, HANDLE& shared_h, DWORD size,
       if (name)
 	mapname = shared_name (map_buf, name, n);
       if (m == SH_JUSTOPEN)
-	shared_h = OpenFileMappingW (FILE_MAP_READ | FILE_MAP_WRITE, FALSE,
-				     mapname);
+	shared_h = OpenFileMappingW (access, FALSE, mapname);
       else
 	{
 	  created = true;
@@ -175,8 +174,7 @@ open_shared (const WCHAR *name, int n, HANDLE& shared_h, DWORD size,
 	 Note that we don't actually *need* fixed addresses.  The only
 	 advantage is reproducibility to help /proc/<PID>/maps along. */
       addr = (void *) region_address[m];
-      shared = MapViewOfFileEx (shared_h, FILE_MAP_READ | FILE_MAP_WRITE,
-				0, 0, 0, addr);
+      shared = MapViewOfFileEx (shared_h, access, 0, 0, 0, addr);
     }
   /* Also catch the unlikely case that a fixed region can't be mapped at the
      fixed address. */
@@ -190,8 +188,7 @@ open_shared (const WCHAR *name, int n, HANDLE& shared_h, DWORD size,
       do
 	{
 	  addr = (void *) next_address;
-	  shared = MapViewOfFileEx (shared_h, FILE_MAP_READ | FILE_MAP_WRITE,
-				    0, 0, 0, addr);
+	  shared = MapViewOfFileEx (shared_h, access, 0, 0, 0, addr);
 	  next_address += wincap.allocation_granularity ();
 	  if (next_address >= SHARED_REGIONS_ADDRESS_HIGH)
 	    {



-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
