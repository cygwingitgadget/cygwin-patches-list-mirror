Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	by sourceware.org (Postfix) with ESMTPS id C0C0F385B53F
	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2023 12:12:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C0C0F385B53F
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M6DrU-1pXdjk3woi-006hIE; Mon, 20 Mar 2023 13:12:16 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9E7EFA80BBE; Mon, 20 Mar 2023 13:12:15 +0100 (CET)
Date: Mon, 20 Mar 2023 13:12:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v
 container(regenerate)
Message-ID: <ZBhNn6nItmyk2Ylk@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Yoshinao Muramatsu <ysno@ac.auone-net.jp>,
	cygwin-patches@cygwin.com
References: <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <20230320115102.1692-1-ysno@ac.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230320115102.1692-1-ysno@ac.auone-net.jp>
X-Provags-ID: V03:K1:GJD+Bl5TpTqbYyEgOFa7tcyCRL1HIUc0uEoZ4ZZfLJph+UbTX6I
 z+MM3PZIYomFPZ4QpPhFELIFP2Yn7d+dV+zw1WkvcWlUogCCyPinTkYvuZ0KHufwVNJInGk
 JrRp+aoe3IXYVm9BqpwbScyp/U2ybnrXApZsDFu7tR9WqQHWwcjMKxqODJ8/LvlYc2300Rc
 2X+t+0+HlsS/6dfYa1xvw==
UI-OutboundReport: notjunk:1;M01:P0:s2EDsy6Pp1Q=;VU6tWWowPqdUwLCIsATotEKimbn
 9G2ZkJ9WUqha78rzkJd06Dv2/FeLyYobWuAzxPfiN7LnJquFTN0kS9dg2gRwG58LzjvgXqjPv
 FOKTPtFz9LmKKdYyZq4Y0yFDF4384Ky0w4Dh7Pb5yZS1GxV+eflJEx7sUGWFlGBq3isHLyZ7z
 r4W+I+Ef0qc4VkYW7Kh1ggTFAGlYXC2b+oWjjyAaS1ZyiM+7DNfUl2XEDxKT0PdNwTmas4Cr7
 1AQyX8kcpg+k6UfegWmtNZcSYocDfU8H+eYBKLi2tUgbjEV9Lp8aYL4OoaYnvwzs6YVzaUt4t
 Zg3xJZsrePfak00nw/VToDcSbrF5HDCi0KGTQP50Xs3swboJc2tuqDaspKalUA7ocnGEBfhtc
 DCmL+5oXMLm6cV/VOEPVKlXIE7KpPaKUFKv5S/kKTNEuicdgyAC970G6jtYDAbZo9D/cFt2Vo
 Z7AD30BYAkkR1TSq5FmNHu6jk0oRGmYI/Gce5L7xnphb+APmQ4R21RKiMgM4YRCyANYnGRN3Z
 v2GrHlaLB/200krwn0Wi/Ichy4xZNNP7TKGMSL0lf6anjJS3jsbpLujsHWpnb95OBd4wLx8JD
 Ix4UKRBtXBmJ2UU1HItMlLy+a4hUmfxMqXWspFA22dSdzwIiAQ786+2R7+8OyH2digA+63HU/
 fH6vNqTRGeIg5IPz/itYJBDAUxus/A/mhLGM01QGZw==
X-Spam-Status: No, score=-97.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Yoshinao,

I just pushed a patch to fs_info::update to take the filesystem
flags introduced starting with Windows 7 into account:

https://sourceware.org/cgit/newlib-cygwin/commit/?id=fcccdc4021ff

AFAICS, this patch should already fix the problem.

It's not the last state, though, because a few more tweak are necessary:

- The filesystem shows up as "cifs" rather than "ntfs" in mount.
- Creating case sensitive directories won't work.
- an upper/lowercase problem in user extended attributes.
- unlinking files-in-use is broken yet.

I intend to fix those in a followup patch.

The next cygwin test release 3.5.0-0.249.g59241913330c will contain the
above patch.  Before we go ahead and apply your patch, can you test if
this already works as desired?  I'd like to get this working and then we
add your workaround, in case we encounter this problem in another
scenario, too.


Thanks,
Corinna



On Mar 20 20:50, Yoshinao Muramatsu wrote:
> From: Yoshinao <ysno@ac.auone-net.jp>
> 
> use real name and add `Signed-Off-By:' field, as suggested by Corinna.
> code is untouched.
> 
> Yoshinao Muramatsu (3):
>   fix unlink in container
>   fix rename in container
>   log disabling posix semantics
> 
>  winsup/cygwin/syscalls.cc | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> -- 
> 2.37.3.windows.1
