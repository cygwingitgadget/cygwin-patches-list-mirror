Return-Path: <joe@pismotec.com>
Received: from mail.pismotec.com (mail.pismotec.com [100.42.30.2])
 by sourceware.org (Postfix) with ESMTPS id 8B8DB3857805
 for <cygwin-patches@cygwin.com>; Fri, 12 Mar 2021 17:05:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8B8DB3857805
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=pismotec.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=joe@pismotec.com
Received: from [10.7.1.101] (unknown [50.39.143.95])
 by mail.pismotec.com (Postfix) with ESMTPSA id 8032E14BE0CB;
 Fri, 12 Mar 2021 09:05:09 -0800 (PST)
Subject: Re: [PATCH 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
To: Johannes Schindelin <johannes.schindelin@gmx.de>, cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
From: Joe Lowe <joe@pismotec.com>
Message-ID: <ff661784-ae78-4a98-8f6d-cddd57b0d216@pismotec.com>
Date: Fri, 12 Mar 2021 09:03:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, NICE_REPLY_A, RCVD_IN_BARRACUDACENTRAL, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 12 Mar 2021 17:05:12 -0000


I am skeptical about this patch (part 1), interposing appexec reparse 
point data as symlinks for cygwin applications.

The appexec reparse point data is essentially an extended attribute 
holding data that is used by CreateProcess(), more like a windows .lnk 
file or an X11 .desktop file, not like a posix symlink. M$ just chose an 
unnecessarily obtuse way to store the files data. This reminds me of old 
Macintosh zero length font files.

The useful function of the patch would seem to be as a way to display a 
portion of the data in shell directory listings for the user. I suggest 
this function is better provided by updated application code.


The patch part 2 seems entirely appropriate.


Joe L.


On 2021-03-12 07:11, Johannes Schindelin via Cygwin-patches wrote:
> When the Windows Store version of Python is installed, so-called "app
> execution aliases" are put into the `PATH`. These are reparse points
> under the hood, with an undocumented format.
> 
> We do know a bit about this format, though, as per the excellent analysis:
> https://www.tiraniddo.dev/2019/09/overview-of-windows-execution-aliases.html
> 
> 	The first 4 bytes is the reparse tag, in this case it's
> 	0x8000001B which is documented in the Windows SDK as
> 	IO_REPARSE_TAG_APPEXECLINK. Unfortunately there doesn't seem to
> 	be a corresponding structure, but with a bit of reverse
> 	engineering we can work out the format is as follows:
> 
> 	Version: <4 byte integer>
> 	Package ID: <NUL Terminated Unicode String>
> 	Entry Point: <NUL Terminated Unicode String>
> 	Executable: <NUL Terminated Unicode String>
> 	Application Type: <NUL Terminated Unicode String>
> 
> Let's treat them as symbolic links. For example, in this developer's
> setup, this will result in the following nice output:
> 
> 	$ cd $LOCALAPPDATA/Microsoft/WindowsApps/
> 
> 	$ ls -l python3.exe
> 	lrwxrwxrwx 1 me 4096 105 Aug 23  2020 python3.exe -> '/c/Program Files/WindowsApps/PythonSoftwareFoundation.Python.3.7_3.7.2544.0_x64__qbz5n2kfra8p0/python.exe'
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   winsup/cygwin/path.cc | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index f3b9913bd0..63f377efb1 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -2538,6 +2538,30 @@ check_reparse_point_target (HANDLE h, bool remote, PREPARSE_DATA_BUFFER rp,
>         if (check_reparse_point_string (psymbuf))
>   	return PATH_SYMLINK | PATH_REP;
>       }
> +  else if (!remote && rp->ReparseTag == IO_REPARSE_TAG_APPEXECLINK)
> +    {
> +      /* App execution aliases are commonly used by Windows Store apps. */
> +      WCHAR *buf = (WCHAR *)(rp->GenericReparseBuffer.DataBuffer + 4);
> +      DWORD size = rp->ReparseDataLength / sizeof(WCHAR), n;
> +
> +      /*
> +         It seems that app execution aliases have a payload of four
> +	 NUL-separated wide string: package id, entry point, executable
> +	 and application type. We're interested in the executable. */
> +      for (int i = 0; i < 3 && size > 0; i++)
> +        {
> +	  n = wcsnlen (buf, size - 1);
> +	  if (i == 2 && n > 0 && n < size)
> +	    {
> +	      RtlInitCountedUnicodeString (psymbuf, buf, n * sizeof(WCHAR));
> +	      return PATH_SYMLINK | PATH_REP;
> +	    }
> +	  if (i == 2)
> +	    break;
> +	  buf += n + 1;
> +	  size -= n + 1;
> +	}
> +    }
>     else if (rp->ReparseTag == IO_REPARSE_TAG_LX_SYMLINK)
>       {
>         /* WSL symlink.  Problem: We have to convert the path to UTF-16 for
> --
> 2.30.2
> 
