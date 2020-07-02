Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id AF2C23875461
 for <cygwin-patches@cygwin.com>; Thu,  2 Jul 2020 07:43:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AF2C23875461
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MIMXC-1jccfS0Lem-00EJfS for <cygwin-patches@cygwin.com>; Thu, 02 Jul 2020
 09:43:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8BCC4A80926; Thu,  2 Jul 2020 09:43:17 +0200 (CEST)
Date: Thu, 2 Jul 2020 09:43:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 8/8] Cygwin: Consider DLL rebasing when computing dumper
 exclusions
Message-ID: <20200702074317.GM3499@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
 <20200701212529.13998-9-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200701212529.13998-9-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:BoRaIo3WBzy8QM4w/0MUDAsBVr5XMOMKKSC3spDn2KnzXCU1kXv
 Q/6Mn2h5517v/qoW82JuAQ5BN53UfHlqOITYyzWuBaKo4sZ6NID8cAvo+62cLLT39L9L94j
 UwPixB24ONVhzwnDwkytB0eRsDNNxFUCoUtZcl+vSjTTAD5q/TW+6iikdPAd1p2f7mknbyv
 aB8XKeY7quLEHBsxrQMIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nr/RrVgzqUk=:7jlC8sSJcKrV1W/qCalIi2
 AkYQpKdS77gsI8uldVl99rcV6qx8Z83BXjq+UvHsuSsY5pZ9reBe/OHy583VKndtFCdipA8W7
 Sxb11FYikO8Wlw35PvH83fYto/lW+blJC35sHwz+syGMO7sX7yJOJnjl21X73Vu+Mtbw6fe2T
 x5Y98T7INPtwHlNau3QbLEIuTE12wx3qkQjBKnCZ5+H7JG3NUJTXaGGTQt0zp8yFbdT6bBSwz
 whhAAAE6sEwNE7x5ZSHqwraQHwo1XH1Pm9x2vm4jkzRzpa3qzpZ5R7XvqlytEAijf5IRMpw1F
 W3lMZY40n1UJ9AwwVTJzbS3Ha1Bo0Vh3xfsVm4A+gp6U+fTzAmeKfM6Jj7HGeXA2b8YuQTvQe
 rOb04+xQ2hslkfKeq6IsHGhcEUPST6KmmGHm+If/cDVf78CY7W1ed5fMgO9gufW3S/5bef9Et
 aQOefUBR1MLoUO0fkmOoXJgxRMrq2HU9embDb/ZDkILd1C7NrLGZ6pcbUYM+eE6ph3T27fwmu
 uLA2rejbiKI/BXYlwvpsTQ5kUMzv73sEY7j2UZp8bl4lDx+2AMeWZGc2cu6Cw99FE9OEwQbEA
 UWYrqj6LpMK27hrz9f9ueKvcKUo9I3R5QEs1EC0iqsZ4ZVO0vuVq1hlQdG8aNNhuhihClXrtO
 +VQmkDMvTb+TrvWtg28yhVKc5DARuMJlTOq9A7Gjy26xgpTeM1e/Rz/3E8wIzFw3z0YKhGt15
 QHDN00vdk87vo+Rk9hdRbC+qIoV5nM9+4h6UKYGjB6KFcZ5wZO5UYFRJhlR1Oco4PQi768T7F
 ub67VlCntHsVMKGH+p3Z0/l1lH4vaf3EYS6Cr6G3FNt/1xLwgxutYJzutrKW5+Bd3AHU8Q1
X-Spam-Status: No, score=-99.0 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Thu, 02 Jul 2020 07:43:21 -0000

On Jul  1 22:25, Jon Turney wrote:
> I think this would always have been neeeded, but is essential on x86_64,
> as kernel32.dll has an ImageBase of 00000001:80000000 (but is always

Great, but that shouldn't matter much given that system DLLs are
ASLRed all the time.

> +parse_pe (const char *file_name, exclusion * excl_list, LPVOID base_address)
>  {
>    if (file_name == NULL || excl_list == NULL)
>      return 0;
> @@ -104,7 +104,19 @@ parse_pe (const char *file_name, exclusion * excl_list)
>      }
>  
>    bfd_check_format (abfd, bfd_object);
> -  bfd_map_over_sections (abfd, &select_data_section, (PTR) excl_list);
> +
> +  /* Compute the relocation offset for this DLL.  Unfortunately, we have to
> +     guess at ImageBase (one page before vma of first section), since bfd
> +     doesn't let us get at backend-private data */
> +  bfd_vma imagebase = abfd->sections->vma - 0x1000;

VirtualQueryEx?  The AllocationBase is identical to the base address
of the DLL loaded at that address.


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
