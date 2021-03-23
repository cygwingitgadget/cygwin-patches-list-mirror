Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 98D4D385BF9E
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 09:30:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 98D4D385BF9E
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MHnZQ-1lUd713x9q-00EvOA for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021
 10:30:01 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5B0BFA80DBA; Tue, 23 Mar 2021 10:30:00 +0100 (CET)
Date: Tue, 23 Mar 2021 10:30:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
Message-ID: <YFm1GF/90te95gh8@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
 <ff661784-ae78-4a98-8f6d-cddd57b0d216@pismotec.com>
 <nycvar.QRO.7.76.6.2103140115180.50@tvgsbejvaqbjf.bet>
 <86c7c1b6-06f9-9e60-e9d7-072b6e8c806f@pismotec.com>
 <nycvar.QRO.7.76.6.2103150408230.50@tvgsbejvaqbjf.bet>
 <69dc492e-cce9-1a1a-7d4b-92a58dbfe981@t-online.de>
 <nycvar.QRO.7.76.6.2103221603030.50@tvgsbejvaqbjf.bet>
 <830d2446-691e-957e-9531-856e58e79c08@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <830d2446-691e-957e-9531-856e58e79c08@t-online.de>
X-Provags-ID: V03:K1:/hBNwF+hEayqB9IQ/H3NhV6hdFYo5VueIspEC3iyyv3WK4R6a6J
 uW0r4k5w8BdfBXzceK4yhiVGiUXyISGsTwkWzznrNmztr3nwI7AiBTmp1k9+liEV5b2LG/O
 85OoT0vlV9qytXvW/WkjOE4JDukNL7CdIx7IfmeIKBYA9l5ra2mRTSWvdb7jBQt3qULddWf
 9Si3lvqUIXcBXO/oUcDQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C7iV9hJfmSI=:EoP6XvFQoyS3kVRgEFwW3V
 bHu/9lH0gwwXOWZz8RmzSl5roNPc8AzeBtKJCF9waEQkUhk5u2mLu40nTI+AO64h59jI6mH5K
 YFRlVkU+/p9nsOYPu8ozJloCfoX/RBXigHf8aDn1SkBURouU8R5RHYhAgaSicIdkaS+5WUwVJ
 DCqmospjLPozbJbMvPpsUgHwH79AK5yk8kgVsBDij/N2dLJ00CyX8qxnLMrmdGAYI8vvBBWkU
 aHAAsS8dZ2j56RSp18SurEYI1JoJ+tLiS1w7tUpfzm3LIykCEkykKnSr8Kxv15fRSx040DZM+
 F3ZCyTxlfTpkIIA5Q4H4l7KXA54WviWwqNV7er3SLjyTzS8fyluxC1TQdK97lrs1QtPT5uNKu
 7ZzUpoZtfGfS4ZIgNeR//d3fgzKeBwv9g350AqixtJK6V6O4ZPNQ1zIovsUO98clzv4ML5OaQ
 5G8i2PJyBA==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 23 Mar 2021 09:30:05 -0000

On Mar 22 22:54, Hans-Bernhard Bröker wrote:
> Am 22.03.2021 um 16:22 schrieb Johannes Schindelin:
> > One of those under-documented reparse point types is the WSL symbolic
> > link, which you will notice are supported in Cygwin, removing quite some
> > sway from your argument...
> 
> I notice no such thing right now, running the currently available release
> version 3.1.7:
> 
> stat: cannot stat '//wsl$/Debian/home/hbbro/link_to_a': Input/output error

What type of WSL symlink is that?  Cygwin reads WSL 1 symlinks(*) and
creates them by default in symlink(2) cals since Cygwin 3.1.5.

(*) IO_REPARSE_TAG_LX_SYMLINK 0xa000001d


Corinna
