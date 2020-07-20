Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id EC0643861031
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 18:55:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EC0643861031
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MYNW8-1kK3lq1czS-00VRhT; Mon, 20 Jul 2020 20:55:44 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B0B50A82B92; Mon, 20 Jul 2020 20:55:43 +0200 (CEST)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: mmap: Remove AT_ROUND_TO_PAGE workaround
Date: Mon, 20 Jul 2020 20:55:43 +0200
Message-Id: <20200720185543.183292-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.26.2
Reply-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:c90GPJ//vFa75Yu99ypFQo+Co0F451EDw/fm+CxwVZCkg54G8Hx
 WuVV7anXXMCZFR2EC2L8g8GJYj0ZZRJJlaYssGgR/zAzaC1/wslscCfo7j+lf5d6TsUMHGN
 GbzUUjnytzd97hCna55mgsRbF76ffGxiQnloX1K6qEHZZlfG8GSn25r2MvvfisyYNbFFLk9
 nShpNj2vK1t1a4zWryMZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/7rwW2FSPr4=:CaQMmL1yjm5+18yBx2nXZP
 9Fy12QvtntAIrgLXedOnR3TDtUCQcZIfW1V41TihaRdeFdlnqKOpBIUr+0C861+pf3AAfkAHo
 My1QqIVhUYfx36KY8TnNYObu8X0ybN0GARK4TcCISKWPUmNFlJagmyXiqIOJ4HZ8/gF1XenOk
 sjDhbNve2KJs2PTd8+lRen++PaBQY+I0DnaBTlJB+NyNb0e9eWc2pXm1UelWEFIIFaekzbOwC
 nt/eZpm91Xdoxw5jD6DYMzr3CJBTdlmcvaEXxVGC9IE4woOmqJTfZMY2jMCOTEOxUVbcQQkEE
 ds4ksoZ7eLftSLyZ/GjeSu/jCCQ4Xu1bHwNrXA/teCXgcF1cdyUogsiY1LcLITVK1o/Yjcdi4
 FxCVzjscAShqoaqRJkHrRfML9AZr01ZVfcFBs/FrVDeMO4rCwMf7/+tp7u4ctoIrXE+igvFkO
 KyVaM9EOyCs2/2uvXmmPFU3Tjq6dEzjk1CyF3BPEU4ZrRHInbVOpx/vIouWqagHFH0jrXUUYG
 7Rkl4LMOJFlOv2YVGcj8FtNEwR8mxzvJHUpAfajFnuI3wZeIEMh0+oxPBLqKy7kRSuioCF7xG
 fwj+R8MEYV3JEmHrRWV2wl5NG3mCOjSEuv2YpIpq2IH6OSHwGB1OpTIYYTY/6ED/v6TmP+kid
 lCLAonBQ7sgCEquiv3a5ZHD9b2pM2F6dax7WuH3cD49cu1e5HTzLqv/1nsLaxN8trSrNmEYZU
 /oCadDVf7xLv63iHbBO6VEy6xyds3Jykyc8vP5vPRjcG+lJJsvXp8dm4E8pAX89eINNfGzuB+
 wvCRfijBEszVArTQqF9mZzyayaMeDsLYUTOQkZ/yExrlClcZlINWxCbguyiVZrITmXrZRTiKw
 mSZ6bB9O02MsPUrdaD6Q==
X-Spam-Status: No, score=-104.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 20 Jul 2020 18:55:51 -0000

From: Corinna Vinschen <corinna@vinschen.de>

It's working on 32 bit OSes only anyway. It even fails on WOW64.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---

Notes:
    Hi Ken,
    
    can you please review this patch and check if it doesn't break
    your testcase again?
    
    Thanks,
    Corinna

 winsup/cygwin/mmap.cc | 117 ++++++++++++------------------------------
 1 file changed, 34 insertions(+), 83 deletions(-)

diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
index 1fccc6c58ee9..8ac96606c2e6 100644
--- a/winsup/cygwin/mmap.cc
+++ b/winsup/cygwin/mmap.cc
@@ -195,12 +195,7 @@ MapView (HANDLE h, void *addr, size_t len, DWORD openflags,
   DWORD protect = gen_create_protect (openflags, flags);
   void *base = addr;
   SIZE_T viewsize = len;
-#ifdef __x86_64__ /* AT_ROUND_TO_PAGE isn't supported on 64 bit systems. */
   ULONG alloc_type = MEM_TOP_DOWN;
-#else
-  ULONG alloc_type = (base && !wincap.is_wow64 () ? AT_ROUND_TO_PAGE : 0)
-		     | MEM_TOP_DOWN;
-#endif
 
 #ifdef __x86_64__
   /* Don't call NtMapViewOfSectionEx during fork.  It requires autoloading
@@ -878,6 +873,10 @@ mmap64 (void *addr, size_t len, int prot, int flags, int fd, off_t off)
 
   if (!anonymous (flags) && fd != -1)
     {
+      UNICODE_STRING fname;
+      IO_STATUS_BLOCK io;
+      FILE_STANDARD_INFORMATION fsi;
+
       /* Ensure that fd is open */
       cygheap_fdget cfd (fd);
       if (cfd < 0)
@@ -896,19 +895,16 @@ mmap64 (void *addr, size_t len, int prot, int flags, int fd, off_t off)
 
       /* The autoconf mmap test maps a file of size 1 byte.  It then tests
 	 every byte of the entire mapped page of 64K for 0-bytes since that's
-	 what POSIX requires.  The problem is, we can't create that mapping on
-	 64 bit systems.  The file mapping will be only a single page, 4K, and
-	 since 64 bit systems don't support the AT_ROUND_TO_PAGE flag, the
-	 remainder of the 64K slot will result in a SEGV when accessed.
-
-	 So, what we do here is cheating for the sake of the autoconf test
-	 on 64 bit systems.  The justification is that there's very likely
-	 no application actually utilizing the map beyond EOF, and we know that
-	 all bytes beyond EOF are set to 0 anyway.  If this test doesn't work
-	 on 64 bit systems, it will result in not using mmap at all in a
-	 package.  But we want that mmap is treated as usable by autoconf,
-	 regardless whether the autoconf test runs on a 32 bit or a 64 bit
-	 system.
+	 what POSIX requires.  The problem is, we can't create that mapping.
+	 The file mapping will be only a single page, 4K, and the remainder
+	 of the 64K slot will result in a SEGV when accessed.
+
+	 So, what we do here is cheating for the sake of the autoconf test.
+	 The justification is that there's very likely no application actually
+	 utilizing the map beyond EOF, and we know that all bytes beyond EOF
+	 are set to 0 anyway.  If this test doesn't work, it will result in
+	 not using mmap at all in a package.  But we want mmap being treated
+	 as usable by autoconf.
 
 	 Ok, so we know exactly what autoconf is doing.  The file is called
 	 "conftest.txt", it has a size of 1 byte, the mapping size is the
@@ -916,31 +912,19 @@ mmap64 (void *addr, size_t len, int prot, int flags, int fd, off_t off)
 	 mapping is MAP_SHARED, the offset is 0.
 
 	 If all these requirements are given, we just return an anonymous map.
-	 This will help to get over the autoconf test even on 64 bit systems.
 	 The tests are ordered for speed. */
-#ifdef __x86_64__
-      if (1)
-#else
-      if (wincap.is_wow64 ())
-#endif
-	{
-	  UNICODE_STRING fname;
-	  IO_STATUS_BLOCK io;
-	  FILE_STANDARD_INFORMATION fsi;
-
-	  if (len == pagesize
-	      && prot == (PROT_READ | PROT_WRITE)
-	      && flags == MAP_SHARED
-	      && off == 0
-	      && (RtlSplitUnicodePath (fh->pc.get_nt_native_path (), NULL,
-				       &fname),
-		  wcscmp (fname.Buffer, L"conftest.txt") == 0)
-	      && NT_SUCCESS (NtQueryInformationFile (fh->get_handle (), &io,
-						     &fsi, sizeof fsi,
-						     FileStandardInformation))
-	      && fsi.EndOfFile.QuadPart == 1LL)
-	    flags |= MAP_ANONYMOUS;
-	}
+      if (len == pagesize
+	  && prot == (PROT_READ | PROT_WRITE)
+	  && flags == MAP_SHARED
+	  && off == 0
+	  && (RtlSplitUnicodePath (fh->pc.get_nt_native_path (), NULL,
+				   &fname),
+	      wcscmp (fname.Buffer, L"conftest.txt") == 0)
+	  && NT_SUCCESS (NtQueryInformationFile (fh->get_handle (), &io,
+						 &fsi, sizeof fsi,
+						 FileStandardInformation))
+	  && fsi.EndOfFile.QuadPart == 1LL)
+	flags |= MAP_ANONYMOUS;
     }
 
   if (anonymous (flags) || fd == -1)
@@ -1089,6 +1073,7 @@ go_ahead:
     }
 
 #ifdef __x86_64__
+  orig_len = roundup2 (orig_len, pagesize);
   if (!wincap.has_extended_mem_api ())
     addr = mmap_alloc.alloc (addr, orig_len ?: len, fixed (flags));
 #else
@@ -1099,7 +1084,6 @@ go_ahead:
 	 deallocated and the address we got is used as base address for the
 	 subsequent real mappings.  This ensures that we have enough space
 	 for the whole thing. */
-      orig_len = roundup2 (orig_len, pagesize);
       PVOID newaddr = VirtualAlloc (addr, orig_len, MEM_TOP_DOWN | MEM_RESERVE,
 				    PAGE_READWRITE);
       if (!newaddr)
@@ -1132,51 +1116,18 @@ go_ahead:
   if (orig_len)
     {
       /* If the requested length is bigger than the file size, the
-	 remainder is created as anonymous mapping.  Actually two
-	 mappings are created, first the remainder from the file end to
-	 the next 64K boundary as accessible pages with the same
-	 protection as the file's pages, then as much pages as necessary
-	 to accomodate the requested length, but as reserved pages which
-	 raise a SIGBUS when trying to access them.  AT_ROUND_TO_PAGE
-	 and page protection on shared pages is only supported by the
-	 32 bit environment, so don't even try on 64 bit or even WOW64.
-	 This results in an allocation gap in the first 64K block the file
-	 ends in, but there's nothing at all we can do about that. */
-#ifdef __x86_64__
-      len = roundup2 (len, wincap.allocation_granularity ());
-      orig_len = roundup2 (orig_len, wincap.allocation_granularity ());
-#else
-      len = roundup2 (len, wincap.is_wow64 () ? wincap.allocation_granularity ()
-					      : wincap.page_size ());
-#endif
+	 remainder is created as anonymous mapping, as reserved pages which
+	 raise a SIGBUS when trying to access them.  This results in an
+	 allocation gap in the first 64K block the file ends in, but there's
+	 nothing at all we can do about that. */
+      len = roundup2 (len, pagesize);
       if (orig_len - len)
 	{
-	  orig_len -= len;
-	  size_t valid_page_len = 0;
-#ifndef __x86_64__
-	  if (!wincap.is_wow64 ())
-	    valid_page_len = orig_len % pagesize;
-#endif
-	  size_t sigbus_page_len = orig_len - valid_page_len;
+	  size_t sigbus_page_len = orig_len - len;
 
-	  caddr_t at_base = base + len;
-	  if (valid_page_len)
-	    {
-	      prot |= __PROT_FILLER;
-	      flags &= MAP_SHARED | MAP_PRIVATE;
-	      flags |= MAP_ANONYMOUS | MAP_FIXED;
-	      at_base = mmap_worker (NULL, &fh_anonymous, at_base,
-				     valid_page_len, prot, flags, -1, 0, NULL);
-	      if (!at_base)
-		{
-		  fh->munmap (fh->get_handle (), base, len);
-		  set_errno (ENOMEM);
-		  goto out_with_unlock;
-		}
-	      at_base += valid_page_len;
-	    }
 	  if (sigbus_page_len)
 	    {
+	      caddr_t at_base = base + len;
 	      prot = PROT_READ | PROT_WRITE | __PROT_ATTACH;
 	      flags = MAP_ANONYMOUS | MAP_NORESERVE | MAP_FIXED;
 	      at_base = mmap_worker (NULL, &fh_anonymous, at_base,
-- 
2.26.2

