Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2111.outbound.protection.outlook.com [40.107.236.111])
 by sourceware.org (Postfix) with ESMTPS id 5C1CC3857C73
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 21:26:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5C1CC3857C73
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bcmdlq9Ie8AufgXMMcuusCcP2VZtwbW4iboBmDeuvBlyZt3bXVLid4a2qmeC9BzBNg54BPjGU+6FTtAGyguCeFya5b71nrblwo0e/GoftqQKKbD4557s8uHr3s3Gcu0Ue2M3x6qkAgpvbFfCdr2WYFMYuMe97QhKgASTeQ6Iglr5afecvU0qItG004exzgBAbraQJFUI4mSQOfgw+s4m1znkN4Ltb5V3TuzljyvK4hKSvrzLbBo7EzuLBCl7be/+Gy+y1sMTm8jbITx2Xk2FjOmSceShloBS2BsvZIm9Wub2l8XTMPEAbkzJWDgebzV7U1Z/5tEW+FRrYONaOzox9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WAewohUcnnAw27v7kxC2XzOfMeYaTgP9fKkCPBrU+A=;
 b=Zr4JqpthwPpjEmR3/wyb2RDYwpxKIGKziQArkgi+j2Vh0nEiFlJDunuohkhAOJEeEunOHeW4zpWXZ2KV3JoVJvB/vvO3Qf2TmVXTTE7GWztSJmB9LP5ZxZhD0h/sjJt9aApiemV0EktCh+gFXiCF8RSqJsxWWOxx5N6IOGbgRZ4yEImhvgMERU/S4BZSiaR1RJ5u8K9SeQEgbxpklIIA0H/P8owJXqaOQ6jXdAsZWwzzC/SJWVW2/C3Y+TP3jsKtDwd5RmOQHdWVY1C/qJlgOYHyBD+WbMLhKf2vaE9C7doDzrsnMHCre7lwQw0go0MQanRa+1w6O3NQfwLPU6Ncgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6126.namprd04.prod.outlook.com (2603:10b6:208:e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 21:26:35 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 21:26:35 +0000
Subject: Re: [PATCH] Cygwin: mmap: Remove AT_ROUND_TO_PAGE workaround
To: cygwin-patches@cygwin.com
References: <20200720185543.183292-1-corinna-cygwin@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <6eee5eb3-e37b-0255-4cc7-f66774092a03@cornell.edu>
Date: Mon, 20 Jul 2020 17:26:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200720185543.183292-1-corinna-cygwin@cygwin.com>
Content-Type: multipart/mixed; boundary="------------D075BABC66CCCC5774FBF145"
Content-Language: en-US
X-ClientProxiedBy: BL1PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:208:257::9) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 BL1PR13CA0034.namprd13.prod.outlook.com (2603:10b6:208:257::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.14 via Frontend Transport; Mon, 20 Jul 2020 21:26:35 +0000
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 989f8d4b-9597-4946-9589-08d82cf3948a
X-MS-TrafficTypeDiagnostic: MN2PR04MB6126:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6126A9DA151D03924A8F276ED87B0@MN2PR04MB6126.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gzX2luN+l1T03RVFqB5qbz8IKlyxXtrYp9aWocy7fhuTzQ7yVlLLpSbAg4uwoU1qhsiXwR5h4iupFyqGaCKbV76Ohu6XgRjs10spL3zRQAaGz2k4lJhsLZUUds1Ur9F72Vjkudl3kSigdK8b+AVFlvDjLBjvSkQJCwtKJXCtl7vA2o2jba7eqChf5qbr0L7CVVFW5JWjeLrfr9+VicSo/v31wVNpQl8Khp6jGrry6tzBk7HnjgGdNOTsCKNvWPIeAaFhv67DwDHRUovFNSPIIOdeZNVjD1gC0tPDZvypc2H9t1jJ2d/Bs19HvdVAkVUKSpH9Ey0JMkZ5jCK7fdqUKQMxzs1DBqWFkIyHJe41VxYQND2SVIeB48btXKyKpkLB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(66946007)(66476007)(66556008)(66616009)(235185007)(956004)(83380400001)(8676002)(478600001)(2616005)(5660300002)(52116002)(75432002)(31686004)(186003)(16576012)(31696002)(6486002)(786003)(36756003)(316002)(6916009)(26005)(8936002)(16526019)(6666004)(2906002)(33964004)(86362001)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +FdIWcAYgxtY3j9DQqwVemkW+XDhFk1dbTHYHWtaE+LfHBc3aIfmtnF8XzAHGfG1eOzWDS/DbtVEUkouJhHvPr42xzFEPGZSIQLtE/aytSoL0jsGyqOz3c4sxe4bO9KFbcHharMW8L1/f8hfBJjQV9P2oXfAq32c+g/bpo6Zd22g3N3dYCKrt6PcQ84T3Pz3QIA4FSGHK29ypU7bZAukK1PZDZcQPlV2nEpubK09YLAHwDBH1DouKoLydvhK54oOfzl0sRu7i1dDd0Jsi9oSPZJYB5pPGhpIt5IGRpjsxWDTbLoExw+G9qQ0vXcEM16cfuxjneTnOX6pLZdaULng7uqFG98T/mdUDTS2VIepumPclup1KzMJ/l8N1TdCKPvsU3fwU0LUcvk8kn50WGYmaZTUrsJLTo6P7SJ+BB+0rwP1lnJLsKrK3T6swPZ42XMlhKBF1iio8xtx9AQTRn9a7oB+Ls6zJ+z+kB57hlX6meQ=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 989f8d4b-9597-4946-9589-08d82cf3948a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 21:26:35.5159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXk6cgR1j7gIeM7/k1jH3As4WD9D/c8gzXIo7nnpV+PRDeIC7WWviLrzEF+0LVv30WxYlYtczmJ6W/pOyUZQpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6126
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Mon, 20 Jul 2020 21:26:40 -0000

--------------D075BABC66CCCC5774FBF145
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Corinna,

On 7/20/2020 2:55 PM, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> It's working on 32 bit OSes only anyway. It even fails on WOW64.
> 
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
> 
> Notes:
>      Hi Ken,
>      
>      can you please review this patch and check if it doesn't break
>      your testcase again?
>      
>      Thanks,
>      Corinna
> 
>   winsup/cygwin/mmap.cc | 117 ++++++++++++------------------------------
>   1 file changed, 34 insertions(+), 83 deletions(-)
> 
> diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
> index 1fccc6c58ee9..8ac96606c2e6 100644
> --- a/winsup/cygwin/mmap.cc
> +++ b/winsup/cygwin/mmap.cc
> @@ -195,12 +195,7 @@ MapView (HANDLE h, void *addr, size_t len, DWORD openflags,
>     DWORD protect = gen_create_protect (openflags, flags);
>     void *base = addr;
>     SIZE_T viewsize = len;
> -#ifdef __x86_64__ /* AT_ROUND_TO_PAGE isn't supported on 64 bit systems. */
>     ULONG alloc_type = MEM_TOP_DOWN;
> -#else
> -  ULONG alloc_type = (base && !wincap.is_wow64 () ? AT_ROUND_TO_PAGE : 0)
> -		     | MEM_TOP_DOWN;
> -#endif
>   
>   #ifdef __x86_64__
>     /* Don't call NtMapViewOfSectionEx during fork.  It requires autoloading
> @@ -878,6 +873,10 @@ mmap64 (void *addr, size_t len, int prot, int flags, int fd, off_t off)
>   
>     if (!anonymous (flags) && fd != -1)
>       {
> +      UNICODE_STRING fname;
> +      IO_STATUS_BLOCK io;
> +      FILE_STANDARD_INFORMATION fsi;
> +
>         /* Ensure that fd is open */
>         cygheap_fdget cfd (fd);
>         if (cfd < 0)
> @@ -896,19 +895,16 @@ mmap64 (void *addr, size_t len, int prot, int flags, int fd, off_t off)
>   
>         /* The autoconf mmap test maps a file of size 1 byte.  It then tests
>   	 every byte of the entire mapped page of 64K for 0-bytes since that's
> -	 what POSIX requires.  The problem is, we can't create that mapping on
> -	 64 bit systems.  The file mapping will be only a single page, 4K, and
> -	 since 64 bit systems don't support the AT_ROUND_TO_PAGE flag, the
> -	 remainder of the 64K slot will result in a SEGV when accessed.
> -
> -	 So, what we do here is cheating for the sake of the autoconf test
> -	 on 64 bit systems.  The justification is that there's very likely
> -	 no application actually utilizing the map beyond EOF, and we know that
> -	 all bytes beyond EOF are set to 0 anyway.  If this test doesn't work
> -	 on 64 bit systems, it will result in not using mmap at all in a
> -	 package.  But we want that mmap is treated as usable by autoconf,
> -	 regardless whether the autoconf test runs on a 32 bit or a 64 bit
> -	 system.
> +	 what POSIX requires.  The problem is, we can't create that mapping.
> +	 The file mapping will be only a single page, 4K, and the remainder
> +	 of the 64K slot will result in a SEGV when accessed.
> +
> +	 So, what we do here is cheating for the sake of the autoconf test.
> +	 The justification is that there's very likely no application actually
> +	 utilizing the map beyond EOF, and we know that all bytes beyond EOF
> +	 are set to 0 anyway.  If this test doesn't work, it will result in
> +	 not using mmap at all in a package.  But we want mmap being treated
> +	 as usable by autoconf.
>   
>   	 Ok, so we know exactly what autoconf is doing.  The file is called
>   	 "conftest.txt", it has a size of 1 byte, the mapping size is the
> @@ -916,31 +912,19 @@ mmap64 (void *addr, size_t len, int prot, int flags, int fd, off_t off)
>   	 mapping is MAP_SHARED, the offset is 0.
>   
>   	 If all these requirements are given, we just return an anonymous map.
> -	 This will help to get over the autoconf test even on 64 bit systems.
>   	 The tests are ordered for speed. */
> -#ifdef __x86_64__
> -      if (1)
> -#else
> -      if (wincap.is_wow64 ())
> -#endif
> -	{
> -	  UNICODE_STRING fname;
> -	  IO_STATUS_BLOCK io;
> -	  FILE_STANDARD_INFORMATION fsi;
> -
> -	  if (len == pagesize
> -	      && prot == (PROT_READ | PROT_WRITE)
> -	      && flags == MAP_SHARED
> -	      && off == 0
> -	      && (RtlSplitUnicodePath (fh->pc.get_nt_native_path (), NULL,
> -				       &fname),
> -		  wcscmp (fname.Buffer, L"conftest.txt") == 0)
> -	      && NT_SUCCESS (NtQueryInformationFile (fh->get_handle (), &io,
> -						     &fsi, sizeof fsi,
> -						     FileStandardInformation))
> -	      && fsi.EndOfFile.QuadPart == 1LL)
> -	    flags |= MAP_ANONYMOUS;
> -	}
> +      if (len == pagesize
> +	  && prot == (PROT_READ | PROT_WRITE)
> +	  && flags == MAP_SHARED
> +	  && off == 0
> +	  && (RtlSplitUnicodePath (fh->pc.get_nt_native_path (), NULL,
> +				   &fname),
> +	      wcscmp (fname.Buffer, L"conftest.txt") == 0)
> +	  && NT_SUCCESS (NtQueryInformationFile (fh->get_handle (), &io,
> +						 &fsi, sizeof fsi,
> +						 FileStandardInformation))
> +	  && fsi.EndOfFile.QuadPart == 1LL)
> +	flags |= MAP_ANONYMOUS;
>       }
>   
>     if (anonymous (flags) || fd == -1)
> @@ -1089,6 +1073,7 @@ go_ahead:
>       }
>   
>   #ifdef __x86_64__
> +  orig_len = roundup2 (orig_len, pagesize);
>     if (!wincap.has_extended_mem_api ())
>       addr = mmap_alloc.alloc (addr, orig_len ?: len, fixed (flags));
>   #else
> @@ -1099,7 +1084,6 @@ go_ahead:
>   	 deallocated and the address we got is used as base address for the
>   	 subsequent real mappings.  This ensures that we have enough space
>   	 for the whole thing. */
> -      orig_len = roundup2 (orig_len, pagesize);
>         PVOID newaddr = VirtualAlloc (addr, orig_len, MEM_TOP_DOWN | MEM_RESERVE,
>   				    PAGE_READWRITE);
>         if (!newaddr)
> @@ -1132,51 +1116,18 @@ go_ahead:
>     if (orig_len)
>       {
>         /* If the requested length is bigger than the file size, the
> -	 remainder is created as anonymous mapping.  Actually two
> -	 mappings are created, first the remainder from the file end to
> -	 the next 64K boundary as accessible pages with the same
> -	 protection as the file's pages, then as much pages as necessary
> -	 to accomodate the requested length, but as reserved pages which
> -	 raise a SIGBUS when trying to access them.  AT_ROUND_TO_PAGE
> -	 and page protection on shared pages is only supported by the
> -	 32 bit environment, so don't even try on 64 bit or even WOW64.
> -	 This results in an allocation gap in the first 64K block the file
> -	 ends in, but there's nothing at all we can do about that. */
> -#ifdef __x86_64__
> -      len = roundup2 (len, wincap.allocation_granularity ());
> -      orig_len = roundup2 (orig_len, wincap.allocation_granularity ());
> -#else
> -      len = roundup2 (len, wincap.is_wow64 () ? wincap.allocation_granularity ()
> -					      : wincap.page_size ());
> -#endif
> +	 remainder is created as anonymous mapping, as reserved pages which
> +	 raise a SIGBUS when trying to access them.  This results in an
> +	 allocation gap in the first 64K block the file ends in, but there's
> +	 nothing at all we can do about that. */
> +      len = roundup2 (len, pagesize);
>         if (orig_len - len)
>   	{
> -	  orig_len -= len;
> -	  size_t valid_page_len = 0;
> -#ifndef __x86_64__
> -	  if (!wincap.is_wow64 ())
> -	    valid_page_len = orig_len % pagesize;
> -#endif
> -	  size_t sigbus_page_len = orig_len - valid_page_len;
> +	  size_t sigbus_page_len = orig_len - len;
>   
> -	  caddr_t at_base = base + len;
> -	  if (valid_page_len)
> -	    {
> -	      prot |= __PROT_FILLER;
> -	      flags &= MAP_SHARED | MAP_PRIVATE;
> -	      flags |= MAP_ANONYMOUS | MAP_FIXED;
> -	      at_base = mmap_worker (NULL, &fh_anonymous, at_base,
> -				     valid_page_len, prot, flags, -1, 0, NULL);
> -	      if (!at_base)
> -		{
> -		  fh->munmap (fh->get_handle (), base, len);
> -		  set_errno (ENOMEM);
> -		  goto out_with_unlock;
> -		}
> -	      at_base += valid_page_len;
> -	    }
>   	  if (sigbus_page_len)
>   	    {
> +	      caddr_t at_base = base + len;
>   	      prot = PROT_READ | PROT_WRITE | __PROT_ATTACH;
>   	      flags = MAP_ANONYMOUS | MAP_NORESERVE | MAP_FIXED;
>   	      at_base = mmap_worker (NULL, &fh_anonymous, at_base,

I think you still left in some 32 bit code that should be removed, and also 
orig_len now doesn't get rounded up on 32 bit.  Here's an additional diff that I 
think is needed beyond your patch:

diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
index 8ac96606c..fa9266825 100644
--- a/winsup/cygwin/mmap.cc
+++ b/winsup/cygwin/mmap.cc
@@ -1009,20 +1009,8 @@ mmap64 (void *addr, size_t len, int prot, int flags, int 
fd, off_t off)
           goto go_ahead;
         }
        fsiz -= off;
-      /* We're creating the pages beyond EOF as reserved, anonymous pages.
-        Note that 64 bit environments don't support the AT_ROUND_TO_PAGE
-        flag, which is required to get this right for the remainder of
-        the first 64K block the file ends in.  We perform the workaround
-        nevertheless to support expectations that the range mapped beyond
-        EOF can be safely munmap'ed instead of being taken by another,
-        totally unrelated mapping. */
-      if ((off_t) len > fsiz && !autogrow (flags))
-       orig_len = len;
-#ifdef __i386__
-      else if (!wincap.is_wow64 () && roundup2 (len, wincap.page_size ())
-                                     < roundup2 (len, pagesize))
-       orig_len = len;
-#endif
+      /* We're creating the pages beyond EOF as reserved, anonymous
+        pages if MAP_AUTOGROW is not set. */
        if ((off_t) len > fsiz)
         {
           if (autogrow (flags))
@@ -1037,9 +1025,12 @@ mmap64 (void *addr, size_t len, int prot, int flags, int 
fd, off_t off)
                 }
             }
           else
-           /* Otherwise, don't map beyond EOF, since Windows would change
-              the file to the new length, in contrast to POSIX. */
-           len = fsiz;
+           {
+             /* Otherwise, don't map beyond EOF, since Windows would change
+                the file to the new length, in contrast to POSIX. */
+             orig_len = len;
+             len = fsiz;
+           }
         }

        /* If the requested offset + len is <= file size, drop MAP_AUTOGROW.
@@ -1072,8 +1063,8 @@ go_ahead:
         }
      }

-#ifdef __x86_64__
    orig_len = roundup2 (orig_len, pagesize);
+#ifdef __x86_64__
    if (!wincap.has_extended_mem_api ())
      addr = mmap_alloc.alloc (addr, orig_len ?: len, fixed (flags));
  #else

I'm attaching an amended commit.

I could easily have missed something, and I don't have a 32 bit OS to test on, 
so just ignore my changes if I'm wrong.

But I've retested the php test case, and it's still OK with this patch.

Ken

--------------D075BABC66CCCC5774FBF145
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-mmap-Remove-AT_ROUND_TO_PAGE-workaround.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Cygwin-mmap-Remove-AT_ROUND_TO_PAGE-workaround.patch"

From 6c26194304efa42394fdb509a94d618931ba8279 Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <corinna@vinschen.de>
Date: Mon, 20 Jul 2020 20:55:43 +0200
Subject: [PATCH] Cygwin: mmap: Remove AT_ROUND_TO_PAGE workaround

It's working on 32 bit OSes only anyway. It even fails on WOW64.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/mmap.cc | 142 +++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 100 deletions(-)

diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
index 1fccc6c58..fa9266825 100644
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
@@ -1025,20 +1009,8 @@ mmap64 (void *addr, size_t len, int prot, int flags, int fd, off_t off)
 	  goto go_ahead;
 	}
       fsiz -= off;
-      /* We're creating the pages beyond EOF as reserved, anonymous pages.
-	 Note that 64 bit environments don't support the AT_ROUND_TO_PAGE
-	 flag, which is required to get this right for the remainder of
-	 the first 64K block the file ends in.  We perform the workaround
-	 nevertheless to support expectations that the range mapped beyond
-	 EOF can be safely munmap'ed instead of being taken by another,
-	 totally unrelated mapping. */
-      if ((off_t) len > fsiz && !autogrow (flags))
-	orig_len = len;
-#ifdef __i386__
-      else if (!wincap.is_wow64 () && roundup2 (len, wincap.page_size ())
-				      < roundup2 (len, pagesize))
-	orig_len = len;
-#endif
+      /* We're creating the pages beyond EOF as reserved, anonymous
+	 pages if MAP_AUTOGROW is not set. */
       if ((off_t) len > fsiz)
 	{
 	  if (autogrow (flags))
@@ -1053,9 +1025,12 @@ mmap64 (void *addr, size_t len, int prot, int flags, int fd, off_t off)
 		}
 	    }
 	  else
-	    /* Otherwise, don't map beyond EOF, since Windows would change
-	       the file to the new length, in contrast to POSIX. */
-	    len = fsiz;
+	    {
+	      /* Otherwise, don't map beyond EOF, since Windows would change
+		 the file to the new length, in contrast to POSIX. */
+	      orig_len = len;
+	      len = fsiz;
+	    }
 	}
 
       /* If the requested offset + len is <= file size, drop MAP_AUTOGROW.
@@ -1088,6 +1063,7 @@ go_ahead:
 	}
     }
 
+  orig_len = roundup2 (orig_len, pagesize);
 #ifdef __x86_64__
   if (!wincap.has_extended_mem_api ())
     addr = mmap_alloc.alloc (addr, orig_len ?: len, fixed (flags));
@@ -1099,7 +1075,6 @@ go_ahead:
 	 deallocated and the address we got is used as base address for the
 	 subsequent real mappings.  This ensures that we have enough space
 	 for the whole thing. */
-      orig_len = roundup2 (orig_len, pagesize);
       PVOID newaddr = VirtualAlloc (addr, orig_len, MEM_TOP_DOWN | MEM_RESERVE,
 				    PAGE_READWRITE);
       if (!newaddr)
@@ -1132,51 +1107,18 @@ go_ahead:
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
2.27.0


--------------D075BABC66CCCC5774FBF145--
