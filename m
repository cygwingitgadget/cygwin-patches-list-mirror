Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 54B1D393C85D
 for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020 13:24:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 54B1D393C85D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M27ep-1k9BNy3URV-002aGK for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020
 15:24:11 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 57FE6A83A79; Fri, 28 Aug 2020 15:24:11 +0200 (CEST)
Date: Fri, 28 Aug 2020 15:24:11 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] CI update
Message-ID: <20200828132411.GI3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200826210409.2497-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826210409.2497-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:GtIMAw9Qikwv47x4ohJO+1RwOP8d+PJasK1yKALmJHWlKf47EeT
 tFaTQBFTWxpUR5gzT2tm5VGgS3QbdX0h4ywatJqLHqKYp9B4zShEet+x1IY7IJ7llZUYaBh
 OZ/zyoxu1LNCRTdSpfOvtPIfo2BNVq236ylPbgVznAgOGlDrIv+KTlgwicZKUaGbfZznfE/
 alDGCeuffnkcllN1cYAUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZAW1SfgkqeU=:bEj+QasBxWxHI1w+X6tGW6
 CQeYPM9WgKQykaSZMMas98RmloMtLe80EtMYBZHynpVXF3JY8i/cE3+L4vm4Q/Tq/U6fsfIiQ
 jSaTAcXdiI9onARgrHgcRFrR3ShcH9/dHW4pyS7r4CjY9RNXScENryU/As9lAVsjsdVepadd6
 5anCt3XfOndK6n02YuVnWtXpZstdz/3nU3HbAnKHQIyrMfVAITF3bT6wxPd+SRkmDCFosycFi
 9COn4SZFVe8ubb2DbDUyv9+wnXY7bLipQmaWk/A1XlSVxGGj6onQVIBZ0hKwMi2mx2YuFPI+e
 kKb9hbVpXxtSBM1oNPEqEc1b1N1AP/m9oV9dsSG+E/jTtKV6CZMljj3TP1F0+5Fw7zbwxv1RP
 ep+hq5jYvnf0YWerETKJXGGy5dhhDZ3LVd9hMORldsiYOw4gCcF+jO7YkZQPC7ys4UDiYm5DA
 iDX4S5vRZg3tx+lAV1Axyv/iGEDeyI3DRCL7ySEZtuoYNUDKVHsDwfZF2H8K4LSHF6ZvkAgCE
 T58/c/1TVw+voHuxfAU32f23xb8lUgkvkrXIkGHVIP4xSBND46ViG944Bk5ZadA42nqlnf2tN
 WNE+W0/mJ8irgw+AkA7diO3G7Tb5MjI5pkxp1XiAkZNRVDfzhJvOrWhZAXgw8zWnbVmLDy2dm
 ChmV+NcDXLasw4A+A4nP07bSrPQl3FYeNEtrtH8zmZJuX/DHC9CJeGJxhm7Q0NyD86Ws/NWaf
 02ubnNbiTPwKcIuy1jRqmQNMh+bIoU/k+iskRPIVbSAmwXK7hMDX50AUGFzyQwALjSOrlGmAk
 JzC7ezIc3iQ9voetwm4/8bhCmZ9XYZZHX+sRBJ8Sd6vo4s8eSFDANd/0J2gujzWsR3J3Vc6R4
 9m5aKLm0RZJbGUoLXCjg==
X-Spam-Status: No, score=-99.9 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Fri, 28 Aug 2020 13:24:16 -0000

On Aug 26 22:04, Jon Turney wrote:
> Since we recently had the unpleasant surprise of discovering that Cygwin
> doesn't build on F32 when trying to make a release, this adds some CI to
> test that.
> 
> Open issues: Since there don't seem to be RedHat packages for cocom, this
> grabs a cocom package from some random 3rd party I found on the internet.
> That might not be the best idea :).
> 
> This also updates other CI configurations.
> 
> Jon Turney (3):
>   Cygwin: Add .appveyor.yml
>   Cygwin: Add github action to cross-build on Fedora
>   Cygwin: Remove .drone.yml
> 
>  .appveyor.yml                | 69 ++++++++++++++++++++++++++++++++++++
>  .drone.yml                   | 58 ------------------------------
>  .github/workflows/cygwin.yml | 45 +++++++++++++++++++++++
>  3 files changed, 114 insertions(+), 58 deletions(-)
>  create mode 100644 .appveyor.yml
>  delete mode 100644 .drone.yml
>  create mode 100644 .github/workflows/cygwin.yml

Go ahead.


Thanks,
Corinna
