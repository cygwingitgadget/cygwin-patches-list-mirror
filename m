Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id AFABA385E83D
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 14:00:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AFABA385E83D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MjSwu-1lLdIi0bbW-00l0o3 for <cygwin-patches@cygwin.com>; Tue, 06 Jul 2021
 16:00:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 01811A80D68; Tue,  6 Jul 2021 16:00:05 +0200 (CEST)
Date: Tue, 6 Jul 2021 16:00:04 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Improve utils manpages
Message-ID: <YORh5Gfuhw7G6OnP@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210616161918.41015-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210616161918.41015-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:RwsJi4L24uf/0pu8y9Cp1LoKBVCdjFtGblk1Xyr/F6mRLZHf/+y
 sOTUm4KHqhIi0FUe/vIqWSc7JRDpFJ+Ij1tyevBhN2TzroZwK/125206fVczOEy/5APwWou
 AUmLiJ9iJcA1e0p7OpCuWL+CZ0mYzDkOSLmtEad4KsjudhawyYXcz1qa2A+kBnCjU9twdWi
 PhZ+lE8T3fpUjCl07hYig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CPyDEmODUjc=:hmOKkignBS1QGZGQHA8yTj
 r3BQ0cZDJDHm299logplaxiduE3io+sbLMMjW9a4Fpr6Q3ByPW486epBqx3C99sBXK9GO+CVX
 k27ubkJkoHPi46Gcd8l0cqZ2FE2eZQr4CxIpj5/FtnlQqNFbUD6Y9yTsoXyBf961+oX/dU/yo
 U8Me5u8FlHc22bJpUrYBKXw+oL0HaH/fHwet08l6PT4CfySrnD728L1wy/KmRmvyTZhDfSIUL
 0hrOh5jdlUDOQ3pkAz9AWMgtgsT0JGYq9kGyjWFYg/VmDIBAi9aqaEn4W1Zii2C1OBBFCCEyj
 e2wIuknVXAyyPmKcfFuIYZHvNsnaefK5ySv33Kmf1eO6jjYyj0M1MDn6QOo10R/iq9VkKHxlK
 bR/G7nyoSkS+FVlDBHeLekuzdl/bAgjELv5rhIFt0Segmwaon+SqgmpvUKs8qaLHeK5Zteh/M
 X3lqTfcWUqEoX0B95C7H1oBwYOFeAdVMoH/vKAMZ/K8FKOW4rgXXhhsqPL5XuXx1jmf8o7Ng2
 YpMRVDoY4rfpc+TDBsZy/t2oiHDB57EX9Ej+7lb0GDIU+d5R9ZCvod5LcyEzrS5CIrUDHsj9P
 mUAuD/5sH1AyJLRe/Oiu7liNdj3FgM/xXn0wVlSfqYdmgqe+8lz4e9RXs4IFKwcUsnW0tqTW8
 YctNWjcDUmx4/kYyJuaSxXIeBppYv6Px3yBJxY3zM4ucLtW/6jTBYeUb7gScc1F0rtApONTtj
 VDcijI/8Gur1Gd9Kwf7CoH6R88ZfWJGA+E1yzBg74TmN3+j5GeGf6xseyMDrqC//n7FWU5jWT
 eTdAGV+xfZFEmytk9gV+1eNejp3zQc1+bOdO/YyBYQDWA9vQRuIyX34un3GmlGzBteDFK88UM
 XnK8PjgS1DEdebcvJu7A==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Tue, 06 Jul 2021 14:00:09 -0000

On Jun 16 17:19, Jon Turney wrote:
> Jon Turney (2):
>   Cygwin: Various minor fixes to utils documentation
>   Cygwin: Use cmdsynopsis element in utils documentation
> 
>  winsup/doc/utils.xml | 709 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 594 insertions(+), 115 deletions(-)
> 
> -- 
> 2.31.1

Great stuff, please push.


Thanks,
Corinna
